from typing import TypedDict
import sys
import stat
import pathlib
import enum
import signal
import os
import subprocess

from collections.abc import Callable
import collections


class Theme(enum.Enum):
    DAWN = "dawn"
    MOON = "moon"
    ROSE_PINE = "rose_pine"


class Prog(TypedDict):
    setup_func: Callable[[pathlib.Path, Theme], None]
    remote: str | None
    map: dict[Theme, str]


CONFIG_PATH = pathlib.Path.home() / ".config"

SOURCE_DIR = CONFIG_PATH / "scripts" / "themes"


def nvim_callback(_: pathlib.Path, current_theme: Theme):
    dst = CONFIG_PATH / "nvim" / "lua" / "modules" / "ui" / "color_scheme.txt"
    __ = dst.write_text(current_theme.value)


def create_link(src: pathlib.Path, dst: pathlib.Path):
    if dst.exists():
        dst.unlink()
    dst.symlink_to(src)


def kitty_callback(src: pathlib.Path, _: Theme):
    dst = pathlib.Path("/home/james/.config/kitty/theme.conf")
    create_link(src, dst)

    pids = subprocess.check_output(["pidof", "kitty"]).decode("utf-8").split()
    for pid in pids:
        os.kill(int(pid), signal.SIGUSR1)


def hyprland_callback(src: pathlib.Path, _: Theme):
    dst = CONFIG_PATH / "hypr" / "theme.conf"
    create_link(src, dst)


def waybar_callback(src: pathlib.Path, _: Theme):
    dst = CONFIG_PATH / "waybar" / "theme.css"
    create_link(src, dst)


def starship_callback(src: pathlib.Path, _: Theme):
    dst = CONFIG_PATH / "starship.toml"
    create_link(src, dst)


def fzf_callback(src: pathlib.Path, _: Theme):
    dst = CONFIG_PATH / "zsh" / "fzf_theme.sh"
    os.chmod(
        src,
        stat.S_IXUSR
        | stat.S_IXGRP
        | stat.S_IEXEC
        | stat.S_IXOTH
        | stat.S_IROTH
        | stat.S_IRUSR
        | stat.S_IRGRP,
    )
    create_link(src, dst)
    __ = os.system(dst)


def wallpaper_callback(src: pathlib.Path, _: Theme):
    __ = os.system(f'hyprctl hyprpaper reload ,"{src}"')
    dst = CONFIG_PATH / "hypr" / "wallpaper"
    create_link(src, dst)


def task_callback(src: pathlib.Path, _: Theme):
    dst = CONFIG_PATH / "task" / "theme.theme"
    create_link(src, dst)


def rofi_callback(src: pathlib.Path, _: Theme):
    dst = CONFIG_PATH / "rofi" / "theme.rasi"
    create_link(src, dst)


def zen_callback(src: pathlib.Path, _: Theme):
    dst = (
        pathlib.Path.home()
        / ".zen"
        / "vcjqwr14.Default (release)"
        / "chrome"
        / "theme.css"
    )
    create_link(src, dst)


def dunst_callback(src: pathlib.Path, _: Theme):
    dst = CONFIG_PATH / "dunst" / "dunstrc.d" / "50-theme.conf"
    create_link(src, dst)
    __ = os.system("pkill dunst")


PROGS = {
    "nvim": {"setup_func": nvim_callback},
    "kitty-main": {
        "remote": "https://github.com/rose-pine/kitty/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "dist/rose-pine-moon.conf",
            Theme.DAWN: "dist/rose-pine-dawn.conf",
            Theme.ROSE_PINE: "dist/rose-pine.conf",
        },
        "setup_func": kitty_callback,
    },
    "hyprland-main": {
        "remote": "https://github.com/rose-pine/hyprland/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "rose-pine-moon.conf",
            Theme.DAWN: "rose-pine-dawn.conf",
            Theme.ROSE_PINE: "rose-pine.conf",
        },
        "setup_func": hyprland_callback,
    },
    "waybar-main": {
        "remote": "https://github.com/rose-pine/waybar/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "rose-pine-moon.css",
            Theme.DAWN: "rose-pine-dawn.css",
            Theme.ROSE_PINE: "rose-pine.css",
        },
        "setup_func": waybar_callback,
    },
    "starship-main": {
        "remote": "https://github.com/rose-pine/starship/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "rose-pine-moon.toml",
            Theme.DAWN: "rose-pine-dawn.toml",
            Theme.ROSE_PINE: "rose-pine.toml",
        },
        "setup_func": starship_callback,
    },
    "fzf-main": {
        "remote": "https://github.com/rose-pine/fzf/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "dist/rose-pine-moon.sh",
            Theme.DAWN: "dist/rose-pine-dawn.sh",
            Theme.ROSE_PINE: "dist/rose-pine.sh",
        },
        "setup_func": fzf_callback,
    },
    "wallpapers-main": {
        "remote": "https://github.com/rose-pine/wallpapers/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "bay.JPG",
            Theme.DAWN: "oceandrone2.JPG",
            Theme.ROSE_PINE: "rose_pine_noiseline.png",
        },
        "setup_func": wallpaper_callback,
    },
    "rose-pine-taskwarrior-main": {
        "remote": "https://github.com/d2718nis/rose-pine-taskwarrior/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "rose-pine-moon-16.theme",
            Theme.DAWN: "rose-pine-dawn-16.theme",
            Theme.ROSE_PINE: "rose-pine-16.theme",
        },
        "setup_func": task_callback,
    },
    "rofi-main": {
        "remote": "https://github.com/rose-pine/rofi/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "rose-pine-moon.rasi",
            Theme.DAWN: "rose-pine-dawn.rasi",
            Theme.ROSE_PINE: "rose-pine.rasi",
        },
        "setup_func": rofi_callback,
    },
    "rose-pine-dunst-main": {
        "remote": "https://github.com/d2718nis/rose-pine-dunst/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "rose-pine-moon.conf",
            Theme.DAWN: "rose-pine-dawn.conf",
            Theme.ROSE_PINE: "rose-pine.conf",
        },
        "setup_func": dunst_callback,
    },
    "zen-browser-main": {
        "remote": "https://github.com/rose-pine/zen-browser/archive/refs/heads/main.zip",
        "map": {
            Theme.MOON: "dist/rose-pine-dawn.css",
            Theme.DAWN: "dist/rose-pine-dawn.css",
            Theme.ROSE_PINE: "dist/rose-pine-dawn.css",
        },
        "setup_func": zen_callback,
    },
}


def normalise_progs() -> dict[str, Prog]:
    defaults: Prog = {
        "setup_func": lambda _, __: None,
        "remote": None,
        "map": collections.defaultdict(str),
    }
    result: dict[str, Prog] = {prog: {**defaults, **PROGS[prog]} for prog in PROGS}

    return result


def fetch_remote(url: str) -> None:
    path = str(SOURCE_DIR / "temp.zip")
    os.system(f"curl -L -o {path} {url}")
    os.system(f"unzip {path} -d {str(SOURCE_DIR)}")


def main():
    progs = normalise_progs()
    themes = {
        "moon": Theme.MOON,
        "dawn": Theme.DAWN,
        "rose_pine": Theme.ROSE_PINE,
    }
    current_theme = themes[sys.argv[1]]

    if not SOURCE_DIR.exists():
        SOURCE_DIR.mkdir()

    for prog_name in progs:
        current_source_dir = SOURCE_DIR / prog_name

        if not current_source_dir.exists() and progs[prog_name]["remote"] is not None:
            fetch_remote(progs[prog_name]["remote"])

        current_source = current_source_dir / progs[prog_name]["map"][current_theme]
        progs[prog_name]["setup_func"](current_source, current_theme)


if __name__ == "__main__":
    main()
