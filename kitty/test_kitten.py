from typing import List
from kitty.boss import Boss
import os

def main(args: List[str]) -> str:
    test_env = os.environ.get('TEST')
    print(f'The env var TEST is {test_env}')
    for name, value in os.environ.items():
        print("{0}: {1}".format(name, value))
    print(args)
    input('Press any key...')
    return test_env

