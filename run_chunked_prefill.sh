#/bin/bash
file_name=/home/vllm-ascend-origin/vllm_ascend/core/schedule_config.py
cfg_name=./debug/dump_config.json
sed -i 's/scheduler_config\["enable_chunked_prefill"\] = False/scheduler_config["enable_chunked_prefill"] = True/' $file_name
log_file="log_chunked.txt"
rm -f $log_file
sed -i 's/debug\/compare_gt/debug\/compare_chunked/' $cfg_name
python test_single.py >> $log_file
