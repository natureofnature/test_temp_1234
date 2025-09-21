#rm -rf /tmp/kv_o*
#rm -rf /tmp/vllm_ascend_kv_dump_*
#rm -rf debug/compare_gt
#bash run_gt.sh  
rm -rf debug/compare_chunked
bash run_chunked_prefill.sh  
grep log_gt.txt -rne "Generated" && echo "===" && grep log_chunked.txt -rne "Generated" && echo "===" && grep -oP '(?<=for request).*' log_gt.txt | uniq  | grep -oP '(?<=: ).*' |sort | uniq 
#grep log_gt.txt -rne "Generated"
