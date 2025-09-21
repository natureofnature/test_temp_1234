#/bin/bash
file_name=/home/vllm-ascend-origin/vllm_ascend/core/schedule_config.py
cfg_name=./debug/dump_config.json
log_file="log_gt.txt"
rm -f $log_file
sed -i 's/scheduler_config\["enable_chunked_prefill"\] = True/scheduler_config["enable_chunked_prefill"] = False/' $file_name
sed -i 's/debug\/compare_chunked/debug\/compare_gt/' $cfg_name
python test_single.py >> $log_file

