import binascii
import math
import os
import struct
import zlib

from kittens.tui.handler import result_handler

LOGO_PATH = os.path.expanduser("~/.cache/kitty-zoom-magnifier.png")
LOGO_COLOR = (243, 139, 168, 230)  # Catppuccin red, ~90% alpha
LOGO_SIZE = 81  # 40% larger than 58px


def _chunk(name, data):
    return (
        struct.pack(">I", len(data))
        + name + data
        + struct.pack(">I", binascii.crc32(name + data) & 0xFFFFFFFF)
    )


def _write_png(path, size, pixels):
    raw = b"".join(
        b"\x00" + b"".join(bytes(pixels[y * size + x]) for x in range(size))
        for y in range(size)
    )
    sig = b"\x89PNG\r\n\x1a\n"
    ihdr = _chunk(b"IHDR", struct.pack(">IIBBBBB", size, size, 8, 6, 0, 0, 0))
    idat = _chunk(b"IDAT", zlib.compress(raw, 9))
    iend = _chunk(b"IEND", b"")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "wb") as f:
        f.write(sig + ihdr + idat + iend)


def _draw_magnifier(size, color):
    cx, cy = size * 0.38, size * 0.38
    r_outer = size * 0.32
    r_inner = size * 0.23
    thickness = size * 0.10
    angle = math.pi / 4
    hx0 = cx + r_outer * math.cos(angle)
    hy0 = cy + r_outer * math.sin(angle)
    hx1, hy1 = size - 5, size - 5
    dx, dy = hx1 - hx0, hy1 - hy0
    seg_len_sq = dx * dx + dy * dy

    def covers(fx, fy):
        d = math.hypot(fx - cx, fy - cy)
        if r_inner <= d <= r_outer:
            return True
        t = max(0.0, min(1.0, ((fx - hx0) * dx + (fy - hy0) * dy) / seg_len_sq))
        px, py = hx0 + t * dx, hy0 + t * dy
        return math.hypot(fx - px, fy - py) <= thickness and d >= r_outer

    transparent = (0, 0, 0, 0)
    r, g, b, a = color
    pixels = []
    for y in range(size):
        for x in range(size):
            # 2x2 supersample for cheap antialiasing
            count = sum(
                1 for sy in (0.25, 0.75) for sx in (0.25, 0.75)
                if covers(x + sx, y + sy)
            )
            if count == 0:
                pixels.append(transparent)
            else:
                pixels.append((r, g, b, a * count // 4))
    return pixels


def _ensure_logo():
    if not os.path.exists(LOGO_PATH):
        pixels = _draw_magnifier(LOGO_SIZE, LOGO_COLOR)
        _write_png(LOGO_PATH, LOGO_SIZE, pixels)


def main(args):
    pass


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    _ensure_logo()
    tab = boss.active_tab
    if tab is None:
        return
    tab.toggle_layout("stack")
    in_stack = tab.current_layout.name == "stack"
    for window in tab:
        if in_stack:
            window.set_logo(LOGO_PATH, "center", 0.9)
        else:
            window.set_logo("none")
