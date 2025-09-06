#/bin/bash
file_name=/home/vllm-ascend-origin/vllm_ascend/core/schedule_config.py
ctrl_file=kv_debug/ctrl.json
log_file="log_gt.txt"
rm -f $log_file
sed -i 's/scheduler_config\["enable_chunked_prefill"\] = True/scheduler_config["enable_chunked_prefill"] = False/' $file_name
sed -i 's/\"chunked\": true/\"chunked\": false/' $ctrl_file
python test_ds_2.py >> $log_file

