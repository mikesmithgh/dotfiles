from typing import List
from kitty.boss import Boss
from kittens.tui.handler import result_handler
from kitty.fast_data_types import get_options
import os
import subprocess
import json


def main():
    raise SystemExit('Must be run as kitten')


@result_handler(type_of_input=None, no_ui=True, has_ready_notification=False)
def handle_result(args: List[str], result: str, target_window_id: int,
                  boss: Boss) -> None:

    del args[0]
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        menu = {}
        fzf_input = None
        for k, v in get_options().alias_map:
            print(k)
            print(v)
        # for key, menu_action in get_options().menu_map.items():
        #     if key[0] == 'global':
        #         menu_item = ' :: '.join(list(key[1:]))
        #         menu[menu_item] = menu_action
        #         if fzf_input:
        #             fzf_input = f'{fzf_input}\n{menu_item}'
        #         else:
        #             fzf_input = menu_item
        #
        # p = subprocess.Popen(['fzf'],
        #                      stdin=subprocess.PIPE,
        #                      stdout=subprocess.PIPE)
        # stdout, stderr = p.communicate(str.encode(fzf_input))
        #
        # item = stdout.decode().replace('\n', '')
        # action = menu.get(item)
        # cmd = (
        #     'kitten',
        #     'themes',
        # )
        # boss.call_remote_control(w, cmd)
