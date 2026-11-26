Ale-Evolved (Alev) ZSH Theme
=============

This theme is based in the [alepimentel's ale](https://github.com/alepimentel/ale-zsh) theme.

![Alev theme with nerd fonts](assets/banner.png)

---

~5 years of tweaking the original theme as I pleased + 3 hours fixing the spaghetti mess I left with ChatGPT.

---

What does it show?
------------------
- User and hostname.
- Current working directory with path shortening.
- Current Git branch, exact tag or abbreviated commit hash in detached HEAD state.
- Git working tree status (clean or dirty).
- Git counters for ahead and behind commits, staged changes, conflicts, modified, deleted and untracked files.
- Command execution time.
- Non-zero exit codes.
- ASCII support
- Dedicated indicators for root users and SSH connections.
- Active virtual environments and programming language versions (as far as I could).

Features
--------

- Automatic color depth detection and fallback:
  - True Color.
  - ANSI 256 colors.
  - ANSI 88 colors.
  - ANSI 16 colors.
  - ANSI 8 colors.
- Automatic ASCII fallback on basic terminals.
- Intelligent path shortening.
- Automatic wrapping of language and environment indicators.
- Colored stderr output.
- Built-in visual previews and diagnostic functions.

Compatibility
-------------
- The theme is meant work with [Oh My Zsh](http://ohmyz.sh)

Dependencies
------------

- Zsh
- [Oh my Zsh](https://ohmyz.sh/)
- Opcional: [Nerd Fonts](https://www.nerdfonts.com/) to have the nice icons.

Installation
------------
1. Put the `*.zsh-theme` files inside the `~/.ohmyzsh/custom/themes/`
2. Edit the the `ZSH_THEME` variable to the name of the theme in your `~/.zshrc` file
    1. `ZSH_THEME="alev"` ⟶ Unicode dark background
    2. `ZSH_THEME="alev-light"` ⟶ Unicode light background
    3. `ZSH_THEME="alev-nerd-font"` ⟶ Nerd font support dark background (as God intended)
    4. `ZSH_THEME="alev-light-nerd-font"` ⟶ Nerd font support light background

Notes
-----
- Left some debugging functions inside (just for fun). Use the `_alev_help` to see everything. 
- Most of the things can be toggled on or off via the variables at the top of the `.zsh-theme` file.



