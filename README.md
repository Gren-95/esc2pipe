# esc2pipe

A [fish](https://fishshell.com/) plugin that types `|` when you press Escape.

## Why

Some keyboard layouts put the pipe character behind a combination a laptop
cannot produce — no dedicated key, and no AltGr position that works. If you
write shell pipelines all day, reaching for it is a constant interruption.

`esc2pipe` rebinds a key you rarely need at a prompt to the one you need
constantly.

## Requirements

- fish, tested on 4.6. The plugin uses only `bind` and `commandline`, both
  stable across many major versions.
- The default key bindings. See [Notes](#notes) if you use vi mode.

## Installation

### With [Fisher](https://github.com/jorgebucaran/fisher)

```fish
fisher install Gren-95/esc2pipe
```

### By hand

```fish
curl -o ~/.config/fish/conf.d/esc2pipe.fish \
  https://raw.githubusercontent.com/Gren-95/esc2pipe/main/conf.d/esc2pipe.fish
exec fish
```

Anything in `conf.d` is sourced automatically when fish starts, so there is
nothing to add to `config.fish`.

## Usage

Press <kbd>Esc</kbd> at the prompt. ` |` is inserted at the cursor:

```
cat access.log        # type this
                      # press Esc
cat access.log |      # you get this
cat access.log |grep 404
```

## How it works

The whole plugin is four lines:

```fish
function insert_pipe_on_esc
    commandline -i " |"
end

bind escape insert_pipe_on_esc
```

`commandline -i` inserts text at the cursor and moves the cursor along with it.

## Notes

**There is no space after the pipe.** The inserted string is `" |"` — a space
before, none after. `cat log |grep 404` runs exactly as `cat log | grep 404`
does, but if you want the second space, change the string in the function.

**Escape has a short delay.** fish waits `fish_escape_delay_ms` after an
Escape to tell a real keypress from the start of an escape sequence, such as
the one an arrow key sends. The default is 30 ms, so the pipe appears a beat
after the key. Tune it with:

```fish
set -U fish_escape_delay_ms 20
```

**vi mode conflicts.** Under `fish_vi_key_bindings`, Escape leaves insert
mode. This plugin claims that key, so the two fight over it. Bind something
else instead:

```fish
bind ctrl-g insert_pipe_on_esc
```

## Known issues

The published `conf.d/esc2pipe.fish` also runs:

```fish
set -U CURSOR (math $CURSOR + 2)
```

That line has no effect. `commandline -i` already advances the cursor, and
`CURSOR` is not a variable fish reads — it just creates a universal variable
of that name in your shell. It is harmless, and removing it changes nothing
about how the plugin behaves.

## Uninstall

```fish
fisher remove Gren-95/esc2pipe        # if installed with Fisher
rm ~/.config/fish/conf.d/esc2pipe.fish  # if installed by hand
exec fish
```

## Bash and Zsh

Earlier versions shipped `esc2pipe.sh` and `esc2pipe.zsh`. Both were removed
in March 2024. This is a fish plugin only.

## Licence

GPL-3.0 — see [LICENSE](LICENSE).
