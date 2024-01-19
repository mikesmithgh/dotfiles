from typing import List
from kitty.boss import Boss
from kittens.tui.handler import result_handler
from kitty.key_encoding import CTRL, SHIFT
from kitty.fast_data_types import click_mouse_cmd_output, move_cursor_to_mouse_if_in_prompt
from kitty.fast_data_types import PRESS, MOVE, RELEASE, send_mouse_event, MOUSE_SELECTION_NORMAL, MOUSE_SELECTION_RECTANGLE
from kittens.tui.loop import Loop


def main():
    raise SystemExit('Must be run as kitten')


@result_handler(type_of_input=None, no_ui=True, has_ready_notification=False)
def handle_result(args: List[str], result: str, target_window_id: int,
                  boss: Boss) -> None:
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        # cell_x = 0
        # cell_y = 0
        # x = 389
        # y = 198
        # button = -1
        # action = MOVE
        # # mods = SHIFT | CTRL
        # mods = 0
        # send_mouse_event(w.screen, cell_x, cell_y, button, action, mods, x, y,
        #                  False)
        # action = PRESS
        # send_mouse_event(w.screen, cell_x, cell_y, button, action, mods, x, y,
        #                  False)
        # action = RELEASE
        # send_mouse_event(w.screen, cell_x, cell_y, button, action, mods, x, y,
        #                  False)
        # w.clear_selection()
        # # # move_cursor_to_mouse_if_in_prompt(w.os_window_id, w.tab_id, w.id)
        # # w.mouse_selection(MOUSE_SELECTION_RECTANGLE)
        # w.screen.scroll_until_cursor_prompt()

        click_mouse_cmd_output(w.os_window_id, w.tab_id, w.id, True)
        w.scroll_to_prompt(-1)
        w.mouse_handle_click('prompt')
