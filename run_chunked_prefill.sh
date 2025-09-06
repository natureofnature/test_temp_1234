#/bin/bash
file_name=/home/vllm-ascend-origin/vllm_ascend/core/schedule_config.py
ctrl_file=./kv_debug/ctrl.json
sed -i 's/scheduler_config\["enable_chunked_prefill"\] = False/scheduler_config["enable_chunked_prefill"] = True/' $file_name
sed -i 's/\"chunked\": false/\"chunked\": true/' $ctrl_file
log_file="log_chunked.txt"
rm -f $log_file
python test_ds_2.py >> $log_file
