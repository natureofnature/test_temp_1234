import os
def _chunked_prefill_enabled() -> bool:
    # Prefer explicit env from user; support multiple names for convenience
    for name in ("VLLM_ASCEND_CHUNKED_PREFILL", "VLLM_ASCEND_IS_CHUNKED", "VLLM_ASCEND_FORCE_CHUNKED"):
        val = os.getenv(name)
        if val is not None:
            return val in ("1", "true", "True")
    return False

print(_chunked_prefill_enabled())
