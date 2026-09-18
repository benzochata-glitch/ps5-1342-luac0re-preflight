-- E40 Luac0re preflight v0.2
-- Exact-target, userland-only, fail-closed probe for PS5 FW 13.42.
-- No AIO. No UAF/race. No kernel/HV writes. No persistence.

local function fail(reason)
    print("E40_VERDICT=DENY")
    print("E40_REASON=" .. tostring(reason))
    return
end

if PLATFORM ~= "PS5" then
    return fail("WRONG_PLATFORM:" .. tostring(PLATFORM))
end

if tostring(FW_VERSION) ~= "13.42" then
    return fail("WRONG_FW:" .. tostring(FW_VERSION))
end

if type(jit_syscall) ~= "table" or type(jit_syscall.getpid) ~= "function" then
    return fail("NO_JIT_SYSCALL")
end

if type(jit_libc_error) ~= "function"
    or type(jit_read32) ~= "function"
    or type(jit_write32) ~= "function" then
    return fail("NO_ERRNO_PRIMITIVES")
end

local pid = jit_syscall.getpid()
if not pid or pid <= 0 then
    return fail("GETPID_FAILED:" .. tostring(pid))
end

local errno_ptr = jit_libc_error()
if not errno_ptr or errno_ptr == 0 then
    return fail("ERRNO_PTR_INVALID")
end

-- Calibration only: close(-1) must fail with EBADF (9).
-- The write below touches only this process's errno storage.
jit_write32(errno_ptr, 0)

if type(jit_syscall.close) ~= "function" then
    return fail("NO_CLOSE_SYSCALL")
end

local close_ret = jit_syscall.close(-1)
local errno_val = jit_read32(errno_ptr)

print("E40_FW=" .. tostring(FW_VERSION))
print("E40_PID=" .. tostring(pid))
print("E40_CLOSE_RET=" .. tostring(close_ret))
print("E40_ERRNO=" .. tostring(errno_val))

if close_ret == -1 and errno_val == 9 then
    print("E40_VERDICT=PASS")
else
    print("E40_VERDICT=INCONCLUSIVE")
end
