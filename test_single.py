import os
import time
import argparse
import random
import string
from pathlib import Path
import torch
 
from vllm import LLM, SamplingParams
from datasets import load_dataset, Features, Value, Sequence
from transformers import AutoTokenizer



os.environ["ASCEND_RT_VISIBLE_DEVICES"]="8,9,10,11,12,13,14,15"
os.environ["VLLM_ASCEND_ENABLE_MLP_OPTIMIZE"] = "1"
 
if __name__ == "__main__":
    torch.cuda.empty_cache()
    parser = argparse.ArgumentParser()
 
    parser.add_argument('--input_len', type=int, default=1024)
    parser.add_argument('--output_len', type=int, default=10)
    parser.add_argument('--bs', type=int, default=1)
    #parser.add_argument('--model_path', type=str, default="/mnt/weight/deepseekv3-lite-base-latest")
    parser.add_argument('--model_path', type=str, default="/home/DeepSeek-V2-Lite")
    parser.add_argument('--tp', type=int, default=2)   # 4 to 8
    parser.add_argument('--cp', type=int, default=4)   # 4 to 8
    parser.add_argument('--profiler_dir', type=str, default=None)
    parser.add_argument('-p', '--profiling', action="store_true")
    parser.add_argument('--iter_times', type=int, default=1)
    parser.add_argument('-c', '--enable_chunked_prefill', default=True)
 
    args = parser.parse_args()

    def generate_odd_queue_string(length):
        return ' '.join(str(2*i + 1) for i in range(length))
 
    
 
    sampling_params = SamplingParams(temperature = 0.0, max_tokens=args.output_len)
    # sampling_params = SamplingParams(temperature = 0.8, top_p = 0.95, max_tokens=args.output_len)
    # sampling_params = SamplingParams(temperature = 0.6, top_k = 40, top_p = 0.95, repetition_penalty = 1.03, ignore_eos=True,  max_tokens=args.output_len)
    llm = LLM(model=args.model_path,
              trust_remote_code=True,
              enforce_eager=True,
              tensor_parallel_size=args.tp,  # tp=8   建议 TP=4
              context_parallel_size=args.cp,  # tp=8   建议 TP=4
              enable_prefix_caching=False,
              enable_expert_parallel=True,
              enable_chunked_prefill=True,    # 待确认是否生效
              enable_sequence_parallel=True,
              max_num_batched_tokens=1024, #16384  1024  74000  131072
              max_model_len=4096,   # 128K  131072
              additional_config={"ascend_scheduler_config": {"enabled": True}},
              block_size=128,
              gpu_memory_utilization=0.9  # 默认值0.9
              )
 
    base = 300
    for i in range(2):
        prompts = [
            generate_odd_queue_string(base+i)+" " 
        ]
        t0 = time.time()
        for _ in range(args.iter_times):
            outputs = llm.generate(prompts, sampling_params)
        t1 = time.time()
        print(f"TTFT: {(t1 - t0) * 1000 / (args.iter_times * args.bs)} ms")
     
        for i, output in enumerate(outputs):
            prompt = output.prompt
            generated_text = output.outputs[0].text
            # print(
            #     f"req_num: {i}\nGenerated text: {generated_text!r}"
            # )
            prompt = prompt.split(" ")
            print(
                #f"prompt:{prompt}\n"
                #f"req_num: {i}\n[{prompt}] -> Generated text: {generated_text!r}\n"
                f"req_num: {i}\n[{prompt[-5:]}] -> Generated text: {generated_text!r}\n"
                f"Token ids: {output.outputs[0].token_ids}\n"
            )
     
    print("end.")
