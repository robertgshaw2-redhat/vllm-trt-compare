export HF_HOME=~
export MODEL=meta/llama-3.3-70b-instruct

if [[ ! -v URL ]]; then
  echo "URL is unset. It should be URL=http://XXX:8000"
  echo "Run `kubectl get services -n comparison` to find the URL."
fi

guidellm benchmark --target=$URL --model=$MODEL --rate-type=concurrent --rate=1 --max-requests=10 --output-path=~/ --processor=$MODEL --data='{"prompt_tokens":2000, "output_tokens":500}'
guidellm benchmark --target=$URL --model=$MODEL --rate-type=concurrent --rate=10 --max-requests=100 --output-path=~/ --processor=$MODEL --data='{"prompt_tokens":2000, "output_tokens":500}'
guidellm benchmark --target=$URL --model=$MODEL --rate-type=concurrent --rate=25 --max-requests=250 --output-path=~/ --processor=$MODEL --data='{"prompt_tokens":2000, "output_tokens":500}'
guidellm benchmark --target=$URL --model=$MODEL --rate-type=concurrent --rate=50 --max-requests=500 --output-path=~/ --processor=$MODEL --data='{"prompt_tokens":2000, "output_tokens":500}'
guidellm benchmark --target=$URL --model=$MODEL --rate-type=concurrent --rate=100 --max-requests=1000 --output-path=~/ --processor=$MODEL --data='{"prompt_tokens":2000, "output_tokens":500}'
guidellm benchmark --target=$URL --model=$MODEL --rate-type=concurrent --rate=150 --max-requests=1500 --output-path=~/ --processor=$MODEL --data='{"prompt_tokens":2000, "output_tokens":500}'
guidellm benchmark --target=$URL --model=$MODEL --rate-type=concurrent --rate=200 --max-requests=2000 --output-path=~/ --processor=$MODEL --data='{"prompt_tokens":2000, "output_tokens":500}'