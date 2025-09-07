#/bin/bash
file_name=/home/vllm-ascend-origin/vllm_ascend/core/schedule_config.py
sed -i 's/scheduler_config\["enable_chunked_prefill"\] = False/scheduler_config["enable_chunked_prefill"] = True/' $file_name
log_file="log_chunked.txt"
rm -f $log_file
echo /tmp/kv_on > /tmp/vllm_ascend_kv_dump_dir
echo on > /tmp/vllm_ascend_kv_dump_tag
python test_single.py >> $log_file
