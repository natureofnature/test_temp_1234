#/bin/bash
file_name=/home/vllm-ascend-origin/vllm_ascend/core/schedule_config.py
log_file="log_gt.txt"
sed -i 's/scheduler_config\["enable_chunked_prefill"\] = True/scheduler_config["enable_chunked_prefill"] = False/' $file_name
export VLLM_ASCEND_KV_DEBUG=1  && export VLLM_ASCEND_CHUNKED_PREFILL=0 && python test_ds_2.py >> $log_file

