#/bin/bash
file_name=/home/vllm-ascend-origin/vllm_ascend/core/schedule_config.py
sed -i 's/scheduler_config\["enable_chunked_prefill"\] = False/scheduler_config["enable_chunked_prefill"] = True/' $file_name
log_file="log_chunked.txt"
rm -f $log_file
export VLLM_ASCEND_KV_DEBUG=1 &&  VLLM_ASCEND_CHUNKED_PREFILL=1 && python test_ds_2.py >> $log_file
