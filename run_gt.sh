#/bin/bash
file_name=/home/vllm-ascend-origin/vllm_ascend/core/schedule_config.py
log_file="log_gt.txt"
rm -f $log_file
sed -i 's/scheduler_config\["enable_chunked_prefill"\] = True/scheduler_config["enable_chunked_prefill"] = False/' $file_name
echo /tmp/kv_off > /tmp/vllm_ascend_kv_dump_dir
echo off > /tmp/vllm_ascend_kv_dump_tag
python test_single.py >> $log_file

