from typing import List
from kitty.boss import Boss
from kittens.tui.handler import result_handler
from kitty.key_encoding import CTRL, SHIFT
from kitty.fast_data_types import PRESS, RELEASE, send_mouse_event


def main():
    raise SystemExit('Must be run as kitten')


@result_handler(type_of_input=None, no_ui=True, has_ready_notification=False)
def handle_result(args: List[str], result: str, target_window_id: int,
                  boss: Boss) -> None:
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        screen = w.screen
        screen.screen_set_last_visited_prompt(1)
