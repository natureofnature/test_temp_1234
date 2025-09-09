#rm -rf /tmp/kv_o*
#rm -rf /tmp/vllm_ascend_kv_dump_*
bash run_gt.sh  
#bash run_chunked_prefill.sh  
#grep log_chunked.txt -rne "Generated" && echo "===" && grep log_gt.txt -rne "Generated" && echo "===" && grep -oP '(?<=for request).*' log_gt.txt | uniq  | grep -oP '(?<=: ).*' |sort | uniq 
grep log_gt.txt -rne "Generated"
