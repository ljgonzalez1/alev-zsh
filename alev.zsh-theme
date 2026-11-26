# Alev (Ale Evolved) - Zsh theme
# _ALEV_*: editable settings; _alev_*: public functions; __alev_* / __ALEV_*: internal.

# ============================================================================
# USER SETTINGS — STYLE
# ============================================================================

# Select the palette for the terminal background at theme load (true: dark; false: light).
# Set before loading the theme; this does not change the terminal background itself.
: ${_ALEV_DARK_THEME:=true}

# nf: Nerd Fonts; unicode: standard Unicode; ascii: force ASCII.
# nf and unicode fall back to ASCII on native Linux consoles, TERM=dumb or non-UTF-8 locales.
# The chosen font must support the requested glyphs; no font probing is performed.
: ${_ALEV_ICON_MODE:=unicode}

# System uptime, independently of command timing; false hides it and skips the query.
: ${_ALEV_UPTIME_ENABLED:=false}

# Override zsh-autosuggestions on load, color-depth changes and explicit prompt refresh.
# False leaves the plugin configuration untouched; use the AUTOSUGGEST palette role below.
: ${_ALEV_AUTOSUGGEST_OVERRIDE:=true}

# Use local Konsole's RGB capability hint even when TERM=linux; false respects TERM.
: ${_ALEV_KONSOLE_RGB_HINT:=true}

# Select auto, truecolor, 256, 88, 16 or 8. Auto uses terminal capability declarations; explicit modes
# force the encoding. ANSI-8 uses only basic foreground SGR 30..37 (no bright foreground codes).
# The minimum emitted depth is 8, even when fewer colors or no colors are advertised.
: ${_ALEV_COLOR_DEPTH:=auto}               # auto | truecolor | 256 | 88 | 16 | 8
# Allow RGB selection in auto color mode; false limits auto to 256, 88, 16 or 8. Explicit truecolor still
# forces RGB.
: ${_ALEV_TRUECOLOR:=true}                 # allow RGB in auto mode
# Auto fallback: RGB -> 256 -> 88 -> 16 -> 8.
# Repeat capability checks: during idle editing only in opt-in asynchronous ZLE mode,
# otherwise between commands. False keeps the initial result until a manual refresh in isolated mode.
: ${_ALEV_CAPABILITIES_AUTO_REFRESH:=true}
# Minimum interval in whole seconds between automatic capability checks; 0 disables periodic checks.
# Isolated mode checks only when a new prompt is about to be displayed.
: ${_ALEV_CAPABILITIES_REFRESH_INTERVAL_SECONDS:=5}
# Interpolate intermediate tree rows in True Color for non-root users; false uses the TREE color for those
# rows.
: ${_ALEV_TREE_GRADIENT_ENABLED:=true}     # True Color intermediate rows
# Wrap complete runtime segments onto extra using rows when they exceed the width budget; false leaves one
# logical using row.
# A single oversized segment may still wrap at the terminal level.
: ${_ALEV_WRAP_USING:=true}
# Allow a contiguous path section to be omitted after the duration has been hidden for width; false keeps
# the full path.
# The last directory and ~ or / remain intact; unavoidable overflow is allowed.
: ${_ALEV_PATH_SHORTEN_ENABLED:=true}      # after hiding time, if needed
# Reserve this many terminal columns (nonnegative integer) when fitting the prompt; no spaces are printed.
# 0 uses the full reported width; a larger margin hides duration or shortens the path earlier.
: ${_ALEV_WIDTH_MARGIN:=2}                 # reserve cells, never print padding
# Also query stty size in an interactive terminal when available; use the smaller valid width. False uses
# Zsh COLUMNS alone.
: ${_ALEV_WIDTH_CHECK_TTY:=true}

# Color palette — RGB, ANSI-256, ANSI-88, ANSI-16, ANSI-8.
# Set _ALEV_<ROLE>_COLOR to #RRGGBB, or _ALEV_<ROLE>_ANSI (256),
# _ALEV_<ROLE>_ANSI_88, _ALEV_<ROLE>_ANSI_16 or _ALEV_<ROLE>_ANSI_8 to an index.
# Each index defaults to auto: use the table for unchanged RGB, otherwise quantize the custom RGB.
# Explicit indices and RGB overrides may bypass the default contrast policy.
# Nominal backgrounds: dark #252729; light #F5F5F5. ANSI-256 defaults avoid mutable base slots.
# Light RGB and 256 defaults target contrast >= 4.5:1; 88/16/8 target >= 3:1
# where the limited palette requires a hue-preserving compromise. ANSI-88 may use base slots.
# Actual basic ANSI colors depend on the terminal.
# STDERR uses pink/red tones; AUTOSUGGEST is intentionally muted.
# Each row contains the dark and light tuples; both variants use the same color engine.
typeset -gA __alev_color_palette_defaults=(

  # Identity and path
  # Normal username. Overrides: _ALEV_USER_COLOR / _ALEV_USER_ANSI.
  USER                     '#3DAEE9 74 27 6 6 | #005A9C 25 22 4 4'
  # Normal hostname or box name. Overrides: _ALEV_HOST_COLOR / _ALEV_HOST_ANSI.
  HOST                     '#00D7AF 43 26 6 6 | #005F87 24 24 4 4'
  # Root username and root tree/input indicator. Overrides: _ALEV_ROOT_USER_COLOR / _ALEV_ROOT_USER_ANSI.
  ROOT_USER                '#FF5F00 202 68 9 3 | #A13B00 94 32 1 1'
  # Hostname or box name when running as root. Overrides: _ALEV_ROOT_HOST_COLOR / _ALEV_ROOT_HOST_ANSI.
  ROOT_HOST                '#FF875F 209 69 9 3 | #8A3B1A 88 32 1 1'
  # Working-directory text (bold). Overrides: _ALEV_PATH_COLOR / _ALEV_PATH_ANSI.
  PATH                     '#FFFF00 226 76 11 3 | #7A4700 88 32 1 1'
  # Omission marker in a shortened path (bold). Overrides: _ALEV_PATH_ELLIPSIS_COLOR /
  # _ALEV_PATH_ELLIPSIS_ANSI.
  PATH_ELLIPSIS            '#FF4500 202 64 9 1 | #FF4500 202 64 1 1'
  # Prompt connective text such as at, in, on, using, took and over. Overrides: _ALEV_TEXT_COLOR /
  # _ALEV_TEXT_ANSI.
  TEXT                     '#FFFFFF 231 79 15 7 | #202124 235 80 0 0'

  # Tree and separators
  # Top tree connector and non-gradient intermediate connectors. Overrides: _ALEV_TREE_COLOR /
  # _ALEV_TREE_ANSI.
  TREE                     '#FFFFFF 231 79 15 7 | #30363B 237 80 0 0'
  # Separators between runtime segments, duration and SSH notice. Overrides: _ALEV_SEPARATOR_COLOR /
  # _ALEV_SEPARATOR_ANSI.
  SEPARATOR                '#BFBFBF 250 85 7 7 | #606060 59 81 0 0'
  # Secondary prompt (PS2) for incomplete or multiline shell input. Overrides: _ALEV_CONTINUATION_COLOR /
  # _ALEV_CONTINUATION_ANSI.
  CONTINUATION             '#A0A0A0 247 84 7 7 | #555D63 59 81 0 0'
  # zsh-autosuggestions foreground; overrides: _ALEV_AUTOSUGGEST_COLOR and depth-specific ANSI indices.
  AUTOSUGGEST              '#808080 244 83 8 7 | #707070 242 81 8 0'

  # Git reference and counters
  # Git reference when no staged, unmerged, modified, deleted or untracked entries exist. Overrides:
  # _ALEV_GIT_CLEAN_COLOR / _ALEV_GIT_CLEAN_ANSI.
  GIT_CLEAN                '#11D116 40 24 2 2 | #087229 22 2 2 2'
  # Git reference when at least one local change is present. Overrides: _ALEV_GIT_DIRTY_COLOR /
  # _ALEV_GIT_DIRTY_ANSI.
  GIT_DIRTY                '#FF4377 204 69 9 1 | #B00045 125 48 1 1'
  # Ahead-of-upstream counter. Overrides: _ALEV_GIT_AHEAD_COLOR / _ALEV_GIT_AHEAD_ANSI.
  GIT_AHEAD                '#5FFF87 84 45 10 2 | #17723D 23 81 2 2'
  # Behind-upstream counter. Overrides: _ALEV_GIT_BEHIND_COLOR / _ALEV_GIT_BEHIND_ANSI.
  GIT_BEHIND               '#FF875F 209 69 9 3 | #A34522 94 32 1 1'
  # Staged/index-change counter. Overrides: _ALEV_GIT_STAGED_COLOR / _ALEV_GIT_STAGED_ANSI.
  GIT_STAGED               '#5FFF87 84 45 10 2 | #17723D 23 81 2 2'
  # Unmerged/conflict counter. Overrides: _ALEV_GIT_CONFLICT_COLOR / _ALEV_GIT_CONFLICT_ANSI.
  GIT_CONFLICT             '#FF4A4A 203 69 9 1 | #B52222 124 48 1 1'
  # Unstaged modification counter. Overrides: _ALEV_GIT_MODIFIED_COLOR / _ALEV_GIT_MODIFIED_ANSI.
  GIT_MODIFIED             '#FFD75F 221 73 11 3 | #7A4700 88 32 1 1'
  # Deletion counter. Overrides: _ALEV_GIT_DELETED_COLOR / _ALEV_GIT_DELETED_ANSI.
  GIT_DELETED              '#FF5F5F 203 69 9 1 | #B52B32 125 48 1 1'
  # Untracked-file counter. Overrides: _ALEV_GIT_UNTRACKED_COLOR / _ALEV_GIT_UNTRACKED_ANSI.
  GIT_UNTRACKED            '#87AFFF 111 43 7 7 | #315F99 60 22 4 4'

  # Input indicator
  # Bottom tree corner in a Git worktree. Overrides: _ALEV_GIT_CORNER_COLOR / _ALEV_GIT_CORNER_ANSI.
  GIT_CORNER               '#AFFFFF 159 63 15 7 | #435E69 240 6 6 6'
  # Bottom tree dash in a Git worktree. Overrides: _ALEV_GIT_DASH_COLOR / _ALEV_GIT_DASH_ANSI.
  GIT_DASH                 '#87D7FF 117 43 14 7 | #17627C 24 6 6 6'
  # Normal Git input icon. Overrides: _ALEV_GIT_ICON_COLOR / _ALEV_GIT_ICON_ANSI.
  GIT_ICON                 '#FFD7AF 223 74 15 7 | #6A4526 95 32 1 1'
  # Bottom tree corner in a non-root SSH session. Overrides: _ALEV_SSH_CORNER_COLOR /
  # _ALEV_SSH_CORNER_ANSI.
  SSH_CORNER               '#AFFFFF 159 63 15 7 | #435E69 240 6 6 6'
  # Bottom tree dash in a non-root SSH session. Overrides: _ALEV_SSH_DASH_COLOR / _ALEV_SSH_DASH_ANSI.
  SSH_DASH                 '#87D7FF 117 43 14 7 | #17627C 24 6 6 6'
  # SSH input icon or SSH label in the root notice. Overrides: _ALEV_SSH_COLOR / _ALEV_SSH_ANSI.
  SSH                      '#5FAFFF 75 43 14 6 | #175D9E 25 22 4 4'
  # Bottom tree corner in ordinary directories or home. Overrides: _ALEV_FOLDER_CORNER_COLOR /
  # _ALEV_FOLDER_CORNER_ANSI.
  FOLDER_CORNER            '#FFFFD7 230 78 15 7 | #4C5A69 240 4 4 4'
  # Bottom tree dash in ordinary directories or home. Overrides: _ALEV_FOLDER_DASH_COLOR /
  # _ALEV_FOLDER_DASH_ANSI.
  FOLDER_DASH              '#FFFF87 228 77 11 7 | #2F5F87 24 4 4 4'
  # Home-directory input icon. Overrides: _ALEV_HOME_ICON_COLOR / _ALEV_HOME_ICON_ANSI.
  HOME_ICON                '#FFFF00 226 76 11 3 | #2F5F87 24 4 4 4'
  # Unicode home circle (neutral foreground for the selected background); overrides: _ALEV_HOME_UNICODE_ICON_COLOR and depth-specific ANSI indices.
  HOME_UNICODE_ICON        '#FFFFFF 231 79 15 7 | #262626 235 80 0 0'
  # Ordinary directory input icon. Overrides: _ALEV_FOLDER_ICON_COLOR / _ALEV_FOLDER_ICON_ANSI.
  FOLDER_ICON              '#D7D700 184 56 11 3 | #2F5F87 24 4 4 4'

  # Languages and environments
  # Python virtualenv icon. Overrides: _ALEV_PYTHON_COLOR / _ALEV_PYTHON_ANSI.
  PYTHON                   '#658CD9 104 38 6 6 | #285AA6 25 17 4 4'
  # Python virtualenv name, including a nested environment name. Overrides: _ALEV_PYTHON_VIRTUALENV_COLOR /
  # _ALEV_PYTHON_VIRTUALENV_ANSI.
  PYTHON_VIRTUALENV        '#FFD75F 221 73 11 3 | #7A4700 88 32 1 1'
  # Conda environment segment. Overrides: _ALEV_CONDA_COLOR / _ALEV_CONDA_ANSI.
  CONDA                    '#3EB049 71 25 2 2 | #247035 23 2 2 2'
  # Node.js runtime icon and version text. Overrides: _ALEV_NODEJS_COLOR / _ALEV_NODEJS_ANSI.
  NODEJS                   '#5FD700 76 40 2 2 | #356B08 58 80 2 2'
  # Java runtime icon and version text. Overrides: _ALEV_JAVA_COLOR / _ALEV_JAVA_ANSI.
  JAVA                     '#F89820 208 68 9 3 | #8F3F00 88 32 1 1'
  # Kotlin runtime icon and version text. Overrides: _ALEV_KOTLIN_COLOR / _ALEV_KOTLIN_ANSI.
  KOTLIN                   '#A97BFF 141 39 7 7 | #6D37B7 61 34 5 5'
  # Go runtime icon and version text. Overrides: _ALEV_GO_COLOR / _ALEV_GO_ANSI.
  GO                       '#00ADD8 38 26 6 6 | #00677E 24 6 6 6'
  # Rust runtime icon and version text. Overrides: _ALEV_RUST_COLOR / _ALEV_RUST_ANSI.
  RUST                     '#DEA584 180 53 7 7 | #7A4330 95 32 1 1'
  # .NET runtime icon and version text. Overrides: _ALEV_DOTNET_COLOR / _ALEV_DOTNET_ANSI.
  DOTNET                   '#A17ADC 140 38 7 7 | #7042A3 61 34 5 5'
  # Ruby runtime icon and version text. Overrides: _ALEV_RUBY_COLOR / _ALEV_RUBY_ANSI.
  RUBY                     '#EA6060 203 69 9 3 | #B52F35 125 48 1 1'
  # PHP runtime icon and version text. Overrides: _ALEV_PHP_COLOR / _ALEV_PHP_ANSI.
  PHP                      '#8993BE 104 38 7 7 | #465887 60 17 4 4'
  # Lua runtime icon and version text. Overrides: _ALEV_LUA_COLOR / _ALEV_LUA_ANSI.
  LUA                      '#7E7EFF 105 39 7 7 | #4836A8 61 17 4 4'
  # Swift runtime icon and version text. Overrides: _ALEV_SWIFT_COLOR / _ALEV_SWIFT_ANSI.
  SWIFT                    '#FA7343 203 68 9 3 | #B74716 94 48 1 1'
  # Dart/Flutter runtime icon and version text. Overrides: _ALEV_DART_COLOR / _ALEV_DART_ANSI.
  DART                     '#00B4AB 37 25 6 6 | #006E67 23 6 6 6'
  # R runtime icon and version text. Overrides: _ALEV_R_COLOR / _ALEV_R_ANSI.
  R                        '#5B90D1 74 38 6 6 | #285E9C 25 22 4 4'

  # Command feedback
  # Nonzero exit status or decoded signal notice. Overrides: _ALEV_EXIT_COLOR / _ALEV_EXIT_ANSI.
  EXIT                     '#F15A6B 203 69 9 1 | #B42D43 125 48 1 1'
  # Stderr foreground for the explicit wrapper and optional automatic filter. Overrides: _ALEV_STDERR_COLOR
  # / _ALEV_STDERR_ANSI (256) and the corresponding depth-specific overrides.
  STDERR                   '#FF87AF 210 69 9 1 | #A52A58 125 48 1 1'
  # System uptime digits (not bold). Overrides: _ALEV_UPTIME_COLOR / _ALEV_UPTIME_ANSI.
  UPTIME                   '#49B85B 71 24 2 2 | #176B35 22 2 2 2'
  # Default duration color below the first threshold or with dynamic colors disabled. Overrides:
  # _ALEV_TIME_IDLE_COLOR / _ALEV_TIME_IDLE_ANSI.
  TIME_IDLE                '#A8A8A8 248 84 7 7 | #5D5D5D 59 81 0 0'
  # Duration color when the corresponding SHORT threshold is selected. Overrides: _ALEV_TIME_SHORT_COLOR /
  # _ALEV_TIME_SHORT_ANSI.
  TIME_SHORT               '#5FFF87 84 45 10 2 | #17723D 23 81 2 2'
  # Duration color when the corresponding MEDIUM threshold is selected. Overrides: _ALEV_TIME_MEDIUM_COLOR
  # / _ALEV_TIME_MEDIUM_ANSI.
  TIME_MEDIUM              '#FFD75F 221 73 11 3 | #805A00 94 3 3 3'
  # Duration color when the corresponding LONG threshold is selected. Overrides: _ALEV_TIME_LONG_COLOR /
  # _ALEV_TIME_LONG_ANSI.
  TIME_LONG                '#FFAF00 214 72 11 3 | #A04D00 94 32 3 3'
  # Duration color when the corresponding VERY_LONG threshold is selected. Overrides:
  # _ALEV_TIME_VERY_LONG_COLOR / _ALEV_TIME_VERY_LONG_ANSI.
  TIME_VERY_LONG           '#FF875F 209 69 9 3 | #A34522 94 32 1 1'
  # Duration color when the corresponding EXTREME threshold is selected. Overrides:
  # _ALEV_TIME_EXTREME_COLOR / _ALEV_TIME_EXTREME_ANSI.
  TIME_EXTREME             '#FF5F87 204 69 9 3 | #B12E55 125 49 1 1'
)

# Keep thresholds nonnegative and in ascending order; comparisons run from EXTREME down to SHORT.
# Command duration thresholds (seconds).
# Minimum elapsed seconds (inclusive) for TIME_SHORT coloring, when dynamic colors are enabled. Higher
# tiers take precedence.
: ${_ALEV_TIME_SHORT_SECONDS:=1}
# Minimum elapsed seconds (inclusive) for TIME_MEDIUM coloring, when dynamic colors are enabled. Higher
# tiers take precedence.
: ${_ALEV_TIME_MEDIUM_SECONDS:=10}
# Minimum elapsed seconds (inclusive) for TIME_LONG coloring, when dynamic colors are enabled. Higher
# tiers take precedence.
: ${_ALEV_TIME_LONG_SECONDS:=60}
# Minimum elapsed seconds (inclusive) for TIME_VERY_LONG coloring, when dynamic colors are enabled. Higher
# tiers take precedence.
: ${_ALEV_TIME_VERY_LONG_SECONDS:=600}
# Minimum elapsed seconds (inclusive) for TIME_EXTREME coloring, when dynamic colors are enabled. Higher
# tiers take precedence.
: ${_ALEV_TIME_EXTREME_SECONDS:=3600}

# Prompt visibility
# Show the current username on the first line; false hides only the name, not root styling.
: ${_ALEV_SHOW_USER:=true}
# Show the hostname or configured box name on the first line; false hides that field.
: ${_ALEV_SHOW_HOST:=true}
# Show the working directory on the first line; false hides it without changing $PWD or project detection.
: ${_ALEV_SHOW_PATH:=true}
# Use the first line of ~/.box-name if nonempty instead of the hostname; false uses the hostname.
: ${_ALEV_USE_BOX_NAME:=true}               # ~/.box-name overrides hostname
# Show SSH context when SSH_CONNECTION, SSH_CLIENT or SSH_TTY is set; false hides the SSH input icon and
# root SSH notice.
: ${_ALEV_SSH_ENABLED:=true}                # SSH icon and root "over SSH"
# Enable local Git status queries and Git prompt indicators; false disables both, including the root+Git
# icon.
: ${_ALEV_GIT_ENABLED:=true}                # master switch: query + ref + icons
# Show the Git reference and permitted counters on the first line; false leaves Git queries and input icon
# enabled.
: ${_ALEV_GIT_SHOW_STATUS:=true}            # first-line Git section
# Allow a Git-specific input-line icon (including root+Git); false selects the normal context icon
# instead.
: ${_ALEV_GIT_SHOW_INPUT_ICON:=true}        # Git icon on the input line
# Use the dedicated root+Git icon when both Git and its input icon are enabled; false uses the ordinary
# root icon.
: ${_ALEV_GIT_ROOT_ICON_ENABLED:=true}      # dedicated root+Git symbol
# Show nonzero Git counters; false hides all counters but still queries Git and preserves clean/dirty
# reference coloring.
: ${_ALEV_GIT_SHOW_COUNTERS:=true}         # master switch for visible counts
# Show local commits ahead of the configured upstream tracking reference; false hides this count, without
# fetching.
: ${_ALEV_GIT_SHOW_AHEAD:=true}
# Show local commits behind the configured upstream tracking reference; false hides this count, without
# fetching.
: ${_ALEV_GIT_SHOW_BEHIND:=true}
# Show the count of ordinary/renamed entries with index changes; false hides the count only.
: ${_ALEV_GIT_SHOW_STAGED:=true}
# Show the count of unmerged Git porcelain records; false hides the count only.
: ${_ALEV_GIT_SHOW_CONFLICTS:=true}
# Show unstaged modified, type-changed, renamed or copied entries; false hides the count only.
: ${_ALEV_GIT_SHOW_MODIFIED:=true}
# Show entries deleted in the index or working tree; false hides the count only.
: ${_ALEV_GIT_SHOW_DELETED:=true}
# Show the count of untracked files reported by Git; false hides the count only.
: ${_ALEV_GIT_SHOW_UNTRACKED:=true}

# Command duration and exit notifications
# Measure elapsed wall-clock time from preexec to precmd; false disables measurement and the duration
# display.
: ${_ALEV_COMMAND_TIME_COUNT:=true}        # false = do not measure or show time
# Display the measured duration as "took ..." when it fits; false hides it but does not disable
# measurement.
: ${_ALEV_COMMAND_TIME_ENABLED:=true}      # false = measure but hide took
# Select duration colors using the thresholds below; false always uses the TIME_IDLE color.
: ${_ALEV_COMMAND_TIME_DYNAMIC_COLORS:=true}
# Print an exit notice for a nonzero command status; false suppresses the notice and uses normal prompt
# spacing.
: ${_ALEV_EXIT_NOTIFICATION_ENABLED:=true}
# Try to label status 128+N using signal N; false always prints EXIT CODE. A matching numeric exit is
# ambiguous.
: ${_ALEV_EXIT_DECODE_SIGNALS:=true}
# Number of blank lines before a failure notice (nonnegative integer); 0 removes this vertical gap.
: ${_ALEV_EXIT_PADDING_BEFORE:=1}          # blank lines, never horizontal padding
# Number of blank lines after a failure notice (nonnegative integer); 0 removes this vertical gap.
: ${_ALEV_EXIT_PADDING_AFTER:=2}
# Number of blank lines before subsequent normal prompts, including empty Enter; 0 removes this vertical
# gap.
: ${_ALEV_PROMPT_PADDING:=1}
# Create the interactive help alias for Zsh's run-help at theme load. False leaves aliases untouched.
# Existing help commands are preserved; the default run-help=man alias is replaced with native run-help.
: ${_ALEV_ZSH_HELP_ALIAS_ENABLED:=true}
# Color terminal-bound command stderr automatically between preexec and precmd.
# Experimental: stderr becomes a pipe; output can arrive late, and interactive tools may behave differently.
# False preserves native stderr; _alev_stderr remains available for individual commands.
: ${_ALEV_STDERR_AUTO_ENABLED:=false}

# Language / environment visibility
# Master switch for runtime and environment display; false disables runtime detection/queries and hides
# the entire using line.
: ${_ALEV_LANGUAGES_ENABLED:=true}         # master switch for the using line
# Show an active Python virtual environment (VIRTUAL_ENV); false hides it. Does not scan for Python
# projects or interpreter versions.
: ${_ALEV_PYTHON_ENABLED:=true}            # active virtualenv only
# Show the active Conda-compatible environment when CONDA_PREFIX is set; false hides it independently of
# Python virtualenv.
: ${_ALEV_CONDA_ENABLED:=true}             # active Conda/Mamba/Micromamba
# Show an active Conda environment named base; false hides base only, not other environments.
: ${_ALEV_CONDA_SHOW_BASE:=true}
# Detect Node.js context and query/display its version; false skips its runtime detection and version
# lookup.
: ${_ALEV_NODEJS_ENABLED:=true}
# Detect Java context and query/display its version; false skips its runtime detection and version lookup.
: ${_ALEV_JAVA_ENABLED:=true}
# Detect Kotlin context and query/display its version; false skips its runtime detection and version
# lookup.
: ${_ALEV_KOTLIN_ENABLED:=true}
# Detect Go context and query/display its version; false skips its runtime detection and version lookup.
: ${_ALEV_GO_ENABLED:=true}
# Recognize regular *.go source files in the current directory or searched parents.
# False requires an explicit Go project marker instead; never scans child directories.
: ${_ALEV_GO_DETECT_SOURCE_FILES:=true}
# Detect Rust context and query/display its version; false skips its runtime detection and version lookup.
: ${_ALEV_RUST_ENABLED:=true}
# Detect .NET context and query/display its version; false skips its runtime detection and version lookup.
: ${_ALEV_DOTNET_ENABLED:=true}
# Detect Ruby context and query/display its version; false skips its runtime detection and version lookup.
# An active Ruby manager can also trigger detection outside a marked project.
: ${_ALEV_RUBY_ENABLED:=true}
# Detect PHP context and query/display its version; false skips its runtime detection and version lookup.
: ${_ALEV_PHP_ENABLED:=true}
# Detect regular *.php or *.phtml files in $PWD or permitted parents, without recursion.
# False requires an explicit project marker.
: ${_ALEV_PHP_DETECT_SOURCE_FILES:=true}
# Show detected PHP context when the runtime version cannot be queried.
: ${_ALEV_PHP_SHOW_WITHOUT_VERSION:=true}
# Per-command timeout in milliseconds (requires enabled GNU timeout support).
: ${_ALEV_PHP_VERSION_QUERY_TIMEOUT_MS:=1500}
# Detect Lua context and query/display its version; false skips its runtime detection and version lookup.
: ${_ALEV_LUA_ENABLED:=true}
# Detect regular *.lua files in $PWD or permitted parents, without recursion.
# False requires an explicit project marker.
: ${_ALEV_LUA_DETECT_SOURCE_FILES:=true}
# Show detected LUA context when the runtime version cannot be queried.
: ${_ALEV_LUA_SHOW_WITHOUT_VERSION:=true}
# Per-command timeout in milliseconds (requires enabled GNU timeout support).
: ${_ALEV_LUA_VERSION_QUERY_TIMEOUT_MS:=1500}
# Detect Swift context and query/display its version; false skips its runtime detection and version
# lookup.
: ${_ALEV_SWIFT_ENABLED:=true}
# Detect regular *.swift files in $PWD or permitted parents, without recursion.
# False requires an explicit project marker.
: ${_ALEV_SWIFT_DETECT_SOURCE_FILES:=true}
# Show detected SWIFT context when the runtime version cannot be queried.
: ${_ALEV_SWIFT_SHOW_WITHOUT_VERSION:=true}
# Per-command timeout in milliseconds (requires enabled GNU timeout support).
: ${_ALEV_SWIFT_VERSION_QUERY_TIMEOUT_MS:=1500}
# Detect Dart/Flutter context and query/display its version; false skips its runtime detection and version
# lookup.
: ${_ALEV_DART_ENABLED:=true}
# Recognize regular *.dart files in the current directory or searched parents, without recursion.
# False requires an explicit Dart/Flutter project marker.
: ${_ALEV_DART_DETECT_SOURCE_FILES:=true}
# Show Dart even if its SDK is missing or the version query fails; never infer a version.
: ${_ALEV_DART_SHOW_WITHOUT_VERSION:=true}
# Dart version-query timeout in milliseconds; 0 disables it when GNU timeout is available.
# The global version timeout must be enabled to use this override.
: ${_ALEV_DART_VERSION_QUERY_TIMEOUT_MS:=1500}
# Detect R context and query/display its version; false skips its runtime detection and version lookup.
: ${_ALEV_R_ENABLED:=true}
# Detect regular *.R, *.r, *.Rmd or *.rmd files in $PWD or permitted parents, without recursion.
# False requires an explicit project marker.
: ${_ALEV_R_DETECT_SOURCE_FILES:=true}
# Show detected R context when the runtime version cannot be queried.
: ${_ALEV_R_SHOW_WITHOUT_VERSION:=true}
# Per-command timeout in milliseconds (requires enabled GNU timeout support).
: ${_ALEV_R_VERSION_QUERY_TIMEOUT_MS:=1500}

# Project detection: 0 = current directory, 3 = current + 3 parents.
# "inherit" follows the global setting, even after changing it at runtime.
# Python/Conda use the active environment, not an upward project search.
# Maximum number of parent-directory steps upward from $PWD; 0 checks only $PWD, 3 checks $PWD and up to 3
# parents.
# Never searches child directories; stops at / or an enabled Git-root boundary. Larger values can increase
# scan cost.
: ${_ALEV_DETECTION_MAX_DEPTH:=3}
# Stop the upward marker search after checking a directory containing .git (file, directory or symlink);
# false allows crossing it.
# The depth limit and filesystem root still apply; this does not limit every runtime-specific version
# lookup.
: ${_ALEV_DETECTION_STOP_AT_GIT_ROOT:=true}
# Maximum upward parent steps for Node.js project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks
# only $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_NODEJS_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for Java project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks only
# $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_JAVA_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for Kotlin project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks
# only $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_KOTLIN_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for Go project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks only
# $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_GO_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for Rust project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks only
# $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_RUST_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for .NET project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks only
# $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_DOTNET_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for Ruby project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks only
# $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_RUBY_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for PHP project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks only
# $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_PHP_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for Lua project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks only
# $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_LUA_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for Swift project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks only
# $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_SWIFT_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for Dart/Flutter project detection; inherit uses DETECTION_MAX_DEPTH, 0
# checks only $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_DART_DETECTION_MAX_DEPTH:=inherit}
# Maximum upward parent steps for R project detection; inherit uses DETECTION_MAX_DEPTH, 0 checks only
# $PWD.
# A nonnegative integer overrides the global depth; the Git-root boundary still applies.
: ${_ALEV_R_DETECTION_MAX_DEPTH:=inherit}

# Performance and caching
# Opt in to Alev ZLE widgets, descriptor callbacks and resize hooks (requires a fresh shell).
# False isolates history and completion: all queries and rendering occur between commands.
# True restores experimental live integration, which may conflict with editor plugins.
: ${_ALEV_ZLE_INTEGRATION:=false}
# Run queries in background workers only when ZLE integration is enabled.
# Otherwise queries run synchronously and may delay the next prompt.
: ${_ALEV_ASYNC:=true}
# Allow live prompt refresh on an idle, empty primary line in opt-in ZLE mode.
# Has no effect when ZLE integration is disabled.
: ${_ALEV_LIVE_REDRAW:=true}
# Runtime-version cache freshness in seconds; 0 makes cached results immediately eligible for a new query.
# An expired result may remain visible while its background replacement is pending.
: ${_ALEV_VERSION_CACHE_TTL_SECONDS:=60}
# Per-command version query timeout in milliseconds; 0 disables it. Requires GNU timeout with fractional
# durations.
# Initialized when sourcing the theme; timed-out commands may receive a further 1-second kill grace
# period.
: ${_ALEV_VERSION_QUERY_TIMEOUT_MS:=500}   # GNU timeout, if available
# Maximum number of runtime-context cache entries before the entire cache is cleared on the next
# insertion.
# Use a positive integer; 0 clears previous entries on every insertion, but still stores the new result.
: ${_ALEV_VERSION_CACHE_MAX_ENTRIES:=64}
# Maximum file size in bytes accepted by the bounded project-configuration reader; larger files are
# skipped.
# 0 permits only empty files; this is not a global limit on all runtime reads or subprocess output.
: ${_ALEV_SCAN_MAX_BYTES:=131072}

# Markers are relative to each inspected directory; globs support *, ? and [. Quote glob patterns in
# arrays.
# The nearest matching directory wins. A marker array is not a recursive descendant scan or a runtime
# installation check.
# Override each language array before sourcing to broaden or narrow detection. Specialized checks may also apply.
if (( ! ${+_ALEV_NODEJS_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_NODEJS_DETECTION_MARKERS=(
    node_modules package.json package-lock.json npm-shrinkwrap.json .npmrc .npmignore
    .nvmrc .node-version yarn.lock .yarnrc .yarnrc.yml .pnp.cjs .pnp.js .pnp.loader.mjs
    pnpm-lock.yaml pnpm-workspace.yaml .pnpmfile.cjs bun.lock bun.lockb bunfig.toml
    vite.config.ts vite.config.js vite.config.mjs vite.config.cjs vite.config.mts vite.config.cts
    nuxt.config.ts nuxt.config.js nuxt.config.mjs
    .prettierignore .prettierrc .prettierrc.json .prettierrc.yaml .prettierrc.yml
    .prettierrc.js .prettierrc.mjs .prettierrc.cjs .prettierrc.toml
    prettier.config.js prettier.config.mjs prettier.config.cjs
    eslint.config.js eslint.config.mjs eslint.config.cjs eslint.config.ts eslint.config.mts eslint.config.cts
    .eslintrc .eslintrc.js .eslintrc.cjs .eslintrc.json .eslintrc.yaml .eslintrc.yml .eslintignore
    tsconfig.json jsconfig.json tsconfig.app.json tsconfig.node.json tsconfig.build.json tsconfig.base.json
  )
fi
if (( ! ${+_ALEV_JAVA_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_JAVA_DETECTION_MARKERS=(
    pom.xml .mvn mvnw mvnw.cmd build.gradle build.gradle.kts settings.gradle settings.gradle.kts
    gradle.properties gradlew gradlew.bat .gradle gradle/wrapper/gradle-wrapper.properties
    .java-version build.xml ivy.xml ivysettings.xml src/main/java src/test/java
    .classpath .settings/org.eclipse.jdt.core.prefs
  )
fi
if (( ! ${+_ALEV_KOTLIN_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_KOTLIN_DETECTION_MARKERS=(
    src/main/kotlin src/test/kotlin src/commonMain/kotlin src/commonTest/kotlin
    src/jvmMain/kotlin src/jvmTest/kotlin src/androidMain/kotlin src/androidUnitTest/kotlin
    src/iosMain/kotlin src/iosTest/kotlin src/jsMain/kotlin src/jsTest/kotlin
    src/wasmJsMain/kotlin src/nativeMain/kotlin .kotlin
  )
fi
# Go project markers identify modules, workspaces and tool configuration. Source files are checked separately.
# Override before sourcing; _ALEV_GO_DETECT_SOURCE_FILES controls the independent *.go check.
# The prompt reports the bundled local toolchain version without attempting downloads.
if (( ! ${+_ALEV_GO_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_GO_DETECTION_MARKERS=(
    go.mod go.sum go.work go.work.sum vendor/modules.txt .go-version
    .golangci.yml .golangci.yaml .golangci.toml .golangci.json .goreleaser.yml .goreleaser.yaml
    Gopkg.toml Gopkg.lock glide.yaml glide.lock Godeps/Godeps.json
  )
fi
if (( ! ${+_ALEV_RUST_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_RUST_DETECTION_MARKERS=(Cargo.toml Cargo.lock rust-toolchain rust-toolchain.toml
    .cargo/config .cargo/config.toml rustfmt.toml .rustfmt.toml clippy.toml .clippy.toml build.rs)
fi
if (( ! ${+_ALEV_DOTNET_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_DOTNET_DETECTION_MARKERS=(
    '*.csproj' '*.csproj.user' '*.sln' '*.slnx' '*.slnf' '*.csx' '*.razor' '*.cshtml' '*.nuspec'
    global.json Directory.Build.props Directory.Build.targets Directory.Packages.props
    Directory.Solution.props Directory.Solution.targets NuGet.Config nuget.config packages.config
    packages.lock.json .config/dotnet-tools.json dotnet-tools.json obj/project.assets.json Properties/launchSettings.json
  )
fi
if (( ! ${+_ALEV_RUBY_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_RUBY_DETECTION_MARKERS=(Gemfile Gemfile.lock gems.rb gems.locked '*.gemspec'
    .ruby-version .ruby-gemset .rvmrc .bundle/config vendor/bundle bin/rails script/rails
    Rakefile .rspec .rubocop.yml .rubocop_todo.yml .reek.yml .yardopts config.ru)
fi
# PHP project marker array: any matching relative file/directory or supported glob can identify a project.
# Override the whole array before sourcing; add/remove entries to broaden/narrow detection. Specialized
# checks may also apply.
if (( ! ${+_ALEV_PHP_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_PHP_DETECTION_MARKERS=(composer.json composer.lock composer.phar vendor/composer vendor/autoload.php
    phpunit.xml phpunit.xml.dist phpstan.neon phpstan.neon.dist psalm.xml psalm.xml.dist
    .php-cs-fixer.php .php-cs-fixer.dist.php phpcs.xml phpcs.xml.dist .php-version .user.ini php.ini
    wp-config.php wp-config-sample.php wp-includes wp-content artisan symfony.lock)
fi
# Lua project marker array: any matching relative file/directory or supported glob can identify a project.
# Override the whole array before sourcing; add/remove entries to broaden/narrow detection. Specialized
# checks may also apply.
if (( ! ${+_ALEV_LUA_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_LUA_DETECTION_MARKERS=('*.rockspec' luarocks.lock .luarocks .luacheckrc .luarc.json .luarc.jsonc .lua-version .luajit-version .busted stylua.toml .stylua.toml)
fi
if (( ! ${+_ALEV_SWIFT_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_SWIFT_DETECTION_MARKERS=(Package.swift 'Package@swift-*.swift' Package.resolved .swiftpm .swift-version .swiftlint.yml .swiftlint.yaml .swiftformat .swift-format)
fi
if (( ! ${+_ALEV_DART_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_DART_DETECTION_MARKERS=(pubspec.yaml pubspec.lock pubspec_overrides.yaml .dart_tool .packages .dart-version analysis_options.yaml dart_test.yaml
    .flutter-plugins .flutter-plugins-dependencies .fvmrc .fvm/fvm_config.json .fvm/flutter_sdk flutter_launcher_icons.yaml flutter_native_splash.yaml)
fi
# R project marker array: any matching relative file/directory or supported glob can identify a project.
# Override the whole array before sourcing; add/remove entries to broaden/narrow detection. Specialized
# checks may also apply.
if (( ! ${+_ALEV_R_DETECTION_MARKERS} )); then
  typeset -ga _ALEV_R_DETECTION_MARKERS=('*.Rproj' .Rproj.user renv.lock renv/activate.R renv/settings.json
    packrat/packrat.lock packrat/init.R .Rprofile .Renviron .Rbuildignore .lintr _targets.R _drake.R _bookdown.yml)
fi


# ============================================================================
# END OF USER SETTINGS — INTERNAL IMPLEMENTATION: DO NOT EDIT BELOW
# ============================================================================

# Private icon sets: Nerd Fonts (NF), Unicode and ASCII.
__ALEV_GIT_BRANCH_SYMBOL_NF=''
__ALEV_GIT_BRANCH_SYMBOL_UNICODE='⎇'
__ALEV_GIT_BRANCH_SYMBOL_ASCII=''
__ALEV_GIT_TAG_SYMBOL_NF=''
__ALEV_GIT_TAG_SYMBOL_UNICODE='◇'
__ALEV_GIT_TAG_SYMBOL_ASCII='@'
__ALEV_GIT_SYMBOL_NF=''
__ALEV_GIT_SYMBOL_UNICODE='◇'
__ALEV_GIT_SYMBOL_ASCII='%'
__ALEV_HOME_SYMBOL_NF=''
__ALEV_HOME_SYMBOL_UNICODE='○'
__ALEV_HOME_SYMBOL_ASCII='~'
__ALEV_FOLDER_SYMBOL_NF=''
__ALEV_FOLDER_SYMBOL_UNICODE='○'
__ALEV_FOLDER_SYMBOL_ASCII='>'
__ALEV_ROOT_SYMBOL_NF=''
__ALEV_ROOT_SYMBOL_UNICODE='#'
__ALEV_ROOT_SYMBOL_ASCII='#'
__ALEV_GIT_ROOT_SYMBOL_NF=''
__ALEV_GIT_ROOT_SYMBOL_UNICODE='◆'
__ALEV_GIT_ROOT_SYMBOL_ASCII='#'
__ALEV_SSH_SYMBOL_NF=''
__ALEV_SSH_SYMBOL_UNICODE='⇌'
__ALEV_SSH_SYMBOL_ASCII='@'
__ALEV_GIT_STAGED_SYMBOL_NF=''
__ALEV_GIT_STAGED_SYMBOL_UNICODE='⊕'
__ALEV_GIT_STAGED_SYMBOL_ASCII='+'
__ALEV_GIT_CONFLICT_SYMBOL_NF=''
__ALEV_GIT_CONFLICT_SYMBOL_UNICODE='!'
__ALEV_GIT_CONFLICT_SYMBOL_ASCII='!'
__ALEV_GIT_MODIFIED_SYMBOL_NF=''
__ALEV_GIT_MODIFIED_SYMBOL_UNICODE='◈'
__ALEV_GIT_MODIFIED_SYMBOL_ASCII='~'
__ALEV_GIT_DELETED_SYMBOL_NF=''
__ALEV_GIT_DELETED_SYMBOL_UNICODE='⊖'
__ALEV_GIT_DELETED_SYMBOL_ASCII='-'
__ALEV_GIT_UNTRACKED_SYMBOL_NF=''
__ALEV_GIT_UNTRACKED_SYMBOL_UNICODE='⊙'
__ALEV_GIT_UNTRACKED_SYMBOL_ASCII='?'
__ALEV_GIT_AHEAD_SYMBOL_NF='↑'
__ALEV_GIT_AHEAD_SYMBOL_UNICODE='↑'
__ALEV_GIT_AHEAD_SYMBOL_ASCII='^'
__ALEV_GIT_BEHIND_SYMBOL_NF='↓'
__ALEV_GIT_BEHIND_SYMBOL_UNICODE='↓'
__ALEV_GIT_BEHIND_SYMBOL_ASCII='v'
__ALEV_PYTHON_SYMBOL_NF=''
__ALEV_PYTHON_SYMBOL_UNICODE='Py'
__ALEV_PYTHON_SYMBOL_ASCII='Py'
__ALEV_NODEJS_SYMBOL_NF=''
__ALEV_NODEJS_SYMBOL_UNICODE='Node'
__ALEV_NODEJS_SYMBOL_ASCII='Node'
__ALEV_JAVA_SYMBOL_NF=''
__ALEV_JAVA_SYMBOL_UNICODE='Java'
__ALEV_JAVA_SYMBOL_ASCII='Java'
__ALEV_KOTLIN_SYMBOL_NF=''
__ALEV_KOTLIN_SYMBOL_UNICODE='Kt'
__ALEV_KOTLIN_SYMBOL_ASCII='Kt'
__ALEV_GO_SYMBOL_NF=''
__ALEV_GO_SYMBOL_UNICODE='Go'
__ALEV_GO_SYMBOL_ASCII='Go'
__ALEV_RUST_SYMBOL_NF=''
__ALEV_RUST_SYMBOL_UNICODE='Rs'
__ALEV_RUST_SYMBOL_ASCII='Rs'
__ALEV_DOTNET_SYMBOL_NF=''
__ALEV_DOTNET_SYMBOL_UNICODE='.NET'
__ALEV_DOTNET_SYMBOL_ASCII='.NET'
__ALEV_RUBY_SYMBOL_NF=''
__ALEV_RUBY_SYMBOL_UNICODE='Rb'
__ALEV_RUBY_SYMBOL_ASCII='Rb'
__ALEV_PHP_SYMBOL_NF=''
__ALEV_PHP_SYMBOL_UNICODE='PHP'
__ALEV_PHP_SYMBOL_ASCII='PHP'
__ALEV_LUA_SYMBOL_NF=''
__ALEV_LUA_SYMBOL_UNICODE='Lua'
__ALEV_LUA_SYMBOL_ASCII='Lua'
__ALEV_SWIFT_SYMBOL_NF=''
__ALEV_SWIFT_SYMBOL_UNICODE='Swift'
__ALEV_SWIFT_SYMBOL_ASCII='Swift'
__ALEV_DART_SYMBOL_NF=''
__ALEV_DART_SYMBOL_UNICODE='Dart'
__ALEV_DART_SYMBOL_ASCII='Dart'
__ALEV_R_SYMBOL_NF='󰟔'
__ALEV_R_SYMBOL_UNICODE='R'
__ALEV_R_SYMBOL_ASCII='R'
__ALEV_TREE_TOP_SYMBOL_NF='╭──'
__ALEV_TREE_TOP_SYMBOL_UNICODE='╭──'
__ALEV_TREE_TOP_SYMBOL_ASCII='+--'
__ALEV_TREE_MIDDLE_SYMBOL_NF='├──'
__ALEV_TREE_MIDDLE_SYMBOL_UNICODE='├──'
__ALEV_TREE_MIDDLE_SYMBOL_ASCII='|--'
__ALEV_TREE_CORNER_SYMBOL_NF='╰'
__ALEV_TREE_CORNER_SYMBOL_UNICODE='╰'
__ALEV_TREE_CORNER_SYMBOL_ASCII='`'
__ALEV_TREE_DASH_SYMBOL_NF='─'
__ALEV_TREE_DASH_SYMBOL_UNICODE='─'
__ALEV_TREE_DASH_SYMBOL_ASCII='--'
__ALEV_TREE_ROOT_DASH_SYMBOL_NF='╴'
__ALEV_TREE_ROOT_DASH_SYMBOL_UNICODE='╴'
__ALEV_TREE_ROOT_DASH_SYMBOL_ASCII='--'
__ALEV_TREE_VERTICAL_SYMBOL_NF='│'
__ALEV_TREE_VERTICAL_SYMBOL_UNICODE='│'
__ALEV_TREE_VERTICAL_SYMBOL_ASCII='|'
__ALEV_SEPARATOR_SYMBOL_NF='·'
__ALEV_SEPARATOR_SYMBOL_UNICODE='·'
__ALEV_SEPARATOR_SYMBOL_ASCII='|'
__ALEV_UPTIME_SYMBOL_NF='󱫡'
__ALEV_UPTIME_SYMBOL_UNICODE='up'
__ALEV_UPTIME_SYMBOL_ASCII='up'
__ALEV_CONTINUATION_SYMBOL_NF='  ├─'
__ALEV_CONTINUATION_SYMBOL_UNICODE='  ├─'
__ALEV_CONTINUATION_SYMBOL_ASCII='  |--'
__ALEV_EXIT_OPEN_SYMBOL_NF='【'
__ALEV_EXIT_OPEN_SYMBOL_UNICODE='【'
__ALEV_EXIT_OPEN_SYMBOL_ASCII='['
__ALEV_EXIT_CLOSE_SYMBOL_NF='】'
__ALEV_EXIT_CLOSE_SYMBOL_UNICODE='】'
__ALEV_EXIT_CLOSE_SYMBOL_ASCII=']'
__ALEV_GIT_NF_COUNTER_GAP=' '
__ALEV_GIT_SUPERSCRIPT_DIGITS_SYMBOL_NF='⁰¹²³⁴⁵⁶⁷⁸⁹'
__ALEV_GIT_SUPERSCRIPT_DIGITS_SYMBOL_UNICODE='⁰¹²³⁴⁵⁶⁷⁸⁹'
__ALEV_GIT_SUPERSCRIPT_DIGITS_SYMBOL_ASCII='0123456789'
__ALEV_GIT_SUBSCRIPT_DIGITS_SYMBOL_NF='₀₁₂₃₄₅₆₇₈₉'
__ALEV_GIT_SUBSCRIPT_DIGITS_SYMBOL_UNICODE='₀₁₂₃₄₅₆₇₈₉'
__ALEV_GIT_SUBSCRIPT_DIGITS_SYMBOL_ASCII='0123456789'
__ALEV_PATH_ELLIPSIS_NF='···'
__ALEV_PATH_ELLIPSIS_UNICODE='···'
__ALEV_PATH_ELLIPSIS_ASCII='...'

# Select the five-column tuple for each role before initializing public color overrides.
typeset -g __alev_color_dark_theme=$_ALEV_DARK_THEME
typeset -ga __alev_color_background_rgb=(37 39 41)
typeset -g __alev_color_palette_role __alev_color_palette_pair
if [[ $__alev_color_dark_theme != true ]]; then
  __alev_color_background_rgb=(245 245 245)
fi
for __alev_color_palette_role in "${(@k)__alev_color_palette_defaults}"; do
  __alev_color_palette_pair=${__alev_color_palette_defaults[$__alev_color_palette_role]}
  if [[ $__alev_color_dark_theme == true ]]; then
    __alev_color_palette_defaults[$__alev_color_palette_role]=${__alev_color_palette_pair%% \| *}
  else
    __alev_color_palette_defaults[$__alev_color_palette_role]=${__alev_color_palette_pair#* \| }
  fi
done
unset __alev_color_palette_role __alev_color_palette_pair

# Nominal 16-color RGB reference for reduced palettes and the color utility.
typeset -ga __alev_color_ansi16_reference_rgb=(000000 B21818 18B218 B26818 1818B2 B218B2 18B2B2 B2B2B2 686868 FF5454 54FF54 FFFF54 5454FF FF54FF 54FFFF FFFFFF)
# Light reference assumes conventional dark ANSI base slots; it does not reprogram the terminal.
if [[ $__alev_color_dark_theme != true ]]; then
  __alev_color_ansi16_reference_rgb=(000000 800000 008000 808000 000080 800080 008080 C0C0C0 808080 FF0000 00FF00 FFFF00 0000FF FF00FF 00FFFF FFFFFF)
fi

# ============================================================================
# INTERNAL INITIALIZATION
# ============================================================================

# Initialize all public per-role RGB and indexed-color overrides.
__alev_color_initialize_palette() {
  emulate -L zsh
  local id entry color_var ansi_var suffix
  for id in "${(@k)__alev_color_palette_defaults}"; do
    entry=${__alev_color_palette_defaults[$id]}
    color_var="_ALEV_${id}_COLOR"
    [[ -n ${(P)color_var} ]] || typeset -g "$color_var=${entry%% *}"
    for suffix in ANSI ANSI_88 ANSI_16 ANSI_8; do
      ansi_var="_ALEV_${id}_${suffix}"
      [[ -n ${(P)ansi_var} ]] || typeset -g "$ansi_var=auto"
    done
  done
  return 0
}
__alev_color_initialize_palette

autoload -Uz add-zsh-hook
zmodload zsh/datetime 2>/dev/null || true
zmodload zsh/mathfunc 2>/dev/null || true
zmodload zsh/stat 2>/dev/null || true
zmodload zsh/parameter 2>/dev/null || true
zmodload zsh/terminfo 2>/dev/null || true

# Preserve other hooks; a reload will not register duplicates.
if (( $+functions[__alev_stderr_restore] )); then
  __alev_stderr_restore
fi
if (( $+functions[__alev_worker_cancel_all] )); then
  __alev_worker_cancel_all
fi

# Command lifecycle and rendered prompt.
typeset -gF __alev_command_started_at=0 __alev_command_elapsed_seconds=0
typeset -gi __alev_command_was_executed=0 __alev_prompt_has_been_shown=0
typeset -gi __alev_stderr_saved_fd=-1
typeset -gi __alev_prompt_render_columns=0
typeset -g __alev_prompt_rendered_text=''
typeset -g __alev_path_visible_prefix='' __alev_path_omission_marker='' __alev_path_visible_suffix=''

# Worker descriptors, context keys and runtime cache.
typeset -gi __alev_git_worker_fd=-1 __alev_runtime_worker_fd=-1
typeset -g __alev_git_status_record='' __alev_runtime_version_records='' __alev_git_context_key=''
typeset -g __alev_git_worker_context_key='' __alev_runtime_worker_context_signature=''
typeset -g __alev_runtime_context_signature='' __alev_runtime_cached_context_signature=''
typeset -g __alev_query_timeout_seconds=''
typeset -gA __alev_runtime_version_cache __alev_runtime_version_cache_timestamps
typeset -ga __alev_runtime_ids=(NODEJS JAVA KOTLIN GO RUST DOTNET RUBY PHP LUA SWIFT DART R)

# Use a timeout only if its GNU-style fractional duration is supported.
if (( $+commands[timeout] )) && [[ $_ALEV_VERSION_QUERY_TIMEOUT_MS == <-> ]] && (( _ALEV_VERSION_QUERY_TIMEOUT_MS > 0 )); then
  if [[ $(command timeout --version 2>/dev/null) == *'GNU coreutils'* ]]; then
    printf -v __alev_query_timeout_seconds '%d.%03d' $(( _ALEV_VERSION_QUERY_TIMEOUT_MS / 1000 )) $(( _ALEV_VERSION_QUERY_TIMEOUT_MS % 1000 ))
  fi
fi

# ---------------- Terminal capabilities ----------------
# No terminal input is read by a worker. No OSC probes, sudo or installs.
typeset -g __alev_icon_mode=ascii __alev_color_depth=8
typeset -gi __alev_terminal_capability_worker_fd=-1 __alev_zle_active=0 __alev_terminal_capabilities_checked=0
typeset -gF __alev_terminal_capabilities_checked_at=0
typeset -g __alev_terminal_capability_config_key=''
typeset -gA __alev_color_cache
typeset -ga __alev_icon_category_ids=(
  GIT_BRANCH GIT_TAG GIT HOME FOLDER ROOT GIT_ROOT SSH
  GIT_STAGED GIT_CONFLICT GIT_MODIFIED GIT_DELETED GIT_UNTRACKED GIT_AHEAD GIT_BEHIND
  PYTHON NODEJS JAVA KOTLIN GO RUST DOTNET RUBY PHP LUA SWIFT DART R
  TREE_TOP TREE_MIDDLE TREE_CORNER TREE_DASH TREE_ROOT_DASH TREE_VERTICAL
  SEPARATOR UPTIME CONTINUATION EXIT_OPEN EXIT_CLOSE GIT_SUPERSCRIPT_DIGITS GIT_SUBSCRIPT_DIGITS
)

# Select a private glyph for the requested or active icon mode.
__alev_icon_get_symbol() {
  local mode=${2:-$__alev_icon_mode} key
  key="__ALEV_${1}_SYMBOL_${(U)mode}"
  REPLY=${(P)key}
}

# Check whether the current locale advertises UTF-8.
__alev_locale_is_utf8() {
  local encoding
  if (( $+commands[locale] )); then
    encoding=$(command locale charmap 2>/dev/null)
  else
    encoding=${LC_ALL:-${LC_CTYPE:-${LANG:-}}}
  fi
  [[ ${(L)encoding} == *utf-8* || ${(L)encoding} == *utf8* ]]
}

# Run an external query with an optional timeout and no terminal input.
__alev_run_bounded_command() {
  if [[ -n $__alev_query_timeout_seconds ]]; then
    command timeout -k 1 "$__alev_query_timeout_seconds" "$@" </dev/null
  else
    command "$@" </dev/null
  fi
}

# Identify a native Linux virtual console, not a graphical pseudoterminal.
__alev_linux_console_is_native() {
  [[ $OSTYPE == linux* && ${TTY:-} == /dev/tty<-> ]]
}

# Use a local Konsole session hint only for color detection.
__alev_konsole_is_local_client() {
  [[ -z ${SSH_CONNECTION:-}${SSH_TTY:-}${SSH_CLIENT:-}${TMUX:-}${STY:-} ]] &&
    ! __alev_linux_console_is_native &&
    [[ -n ${KONSOLE_DBUS_SERVICE:-}${KONSOLE_DBUS_SESSION:-}${KONSOLE_VERSION:-} ]]
}

# Choose the requested icon set, falling back to ASCII on basic consoles or non-UTF-8 locales.
__alev_detect_icons() {
  local requested_mode=$_ALEV_ICON_MODE
  REPLY=ascii
  case $requested_mode in
    nf|unicode) ;;
    *) return 0 ;;
  esac
  [[ ${TERM:-dumb} != dumb ]] || return 0
  __alev_linux_console_is_native && return 0
  __alev_locale_is_utf8 || return 0
  REPLY=$requested_mode
}

# Select one of the five supported color depths from reported capabilities.
__alev_select_color_depth() {
  emulate -L zsh
  local n=${1:-0} hint=${2:-}
  [[ $n == <-> ]] || n=0
  if ! __alev_linux_console_is_native && [[ $_ALEV_TRUECOLOR != false ]] && { [[ $hint == truecolor || $hint == 24bit ]] || (( n >= 16777216 )); }; then
    REPLY=truecolor
  elif (( n >= 256 )); then
    REPLY=256
  elif (( n >= 88 )); then
    REPLY=88
  elif (( n >= 16 )); then
    REPLY=16
  else
    REPLY=8
  fi
}

# Determine color depth; quick mode skips the external terminfo query.
__alev_detect_colors() {
  emulate -L zsh
  setopt extendedglob
  local n=${terminfo[colors]:-0} info='' hint=${COLORTERM:-}
  hint=${(L)hint}
  # A multiplexer may not forward direct color; prefer its own terminfo.
  [[ ${TERM:-} == (screen*|tmux*) ]] && hint=''
  case $_ALEV_COLOR_DEPTH in
    truecolor|256|88|16|8) REPLY=$_ALEV_COLOR_DEPTH; return 0 ;;
  esac
  [[ $n == <-> ]] || n=0
  if [[ ${TERM:-dumb} == dumb ]]; then
    REPLY=8
    return 0
  fi
  if [[ ${1:-} != quick ]] && (( $+commands[infocmp] )); then
    info=$(__alev_run_bounded_command infocmp -1 -x "$TERM" 2>/dev/null) || info=''
    # terminfo descriptions are local declarations, not proof of display fidelity.
    local line
    for line in ${(f)info}; do
      line=${line//[[:space:]]/}
      if [[ $line == colors\#* ]]; then
        local val=${line#colors\#}; val=${val%,}
        if [[ $val == 0x[0-9a-fA-F]## ]]; then
          n=$((16#${val#0x}))
        elif [[ $val == <-> ]]; then
          n=$val
        fi
      fi
      [[ $line == RGB, || $line == RGB\#* || $line == Tc, ]] && hint=truecolor
    done
  fi
  # A local Konsole PTY may deliberately advertise TERM=linux; allow users to retain that limit.
  if [[ $_ALEV_KONSOLE_RGB_HINT == true && ${TERM:-} == linux ]] && __alev_konsole_is_local_client; then
    hint=truecolor
    (( n < 256 )) && n=256
  fi
  __alev_select_color_depth "$n" "$hint"
}

# Return the independent icon mode and color depth as one record.
__alev_terminal_query_capabilities() {
  local icon depth
  __alev_detect_icons
  icon=$REPLY
  __alev_detect_colors
  depth=$REPLY
  print -r -- "$icon $depth"
}

# Validate and apply detected capabilities, clearing stale color mappings.
__alev_terminal_apply_capabilities() {
  local icon=${1%% *} depth=${1##* }
  [[ $icon == nf || $icon == unicode || $icon == ascii ]] || return 1
  case $depth in
    truecolor|256|88|16|8) ;;
    *) return 1 ;;
  esac
  local previous_color_depth=$__alev_color_depth
  if [[ $icon != $__alev_icon_mode || $depth != $__alev_color_depth ]]; then
    __alev_icon_mode=$icon
    __alev_color_depth=$depth
    __alev_color_cache=()
  fi
  [[ $previous_color_depth == "$depth" ]] || __alev_autosuggest_apply_style
  return 0
}

# Start an asynchronous terminal capability query.
__alev_terminal_start_capability_worker() {
  local delay=${1:-0}
  (( __alev_zle_active )) && [[ $_ALEV_ZLE_INTEGRATION == true && $_ALEV_ASYNC == true ]] || return 0
  (( __alev_terminal_capability_worker_fd < 0 )) || return 0
  exec {__alev_terminal_capability_worker_fd}< <( if (( delay > 0 )); then command sleep "$delay"; fi; __alev_terminal_query_capabilities )
  if ! zle -F -w "$__alev_terminal_capability_worker_fd" __alev_terminal_capability_worker_ready 2>/dev/null; then
    __alev_worker_close_fd $__alev_terminal_capability_worker_fd
    __alev_terminal_capability_worker_fd=-1
  fi
}

# Consume a capability result, redraw if changed and schedule refresh.
__alev_terminal_capability_worker_ready() {
  local -i fd=$1
  local line old="$__alev_icon_mode $__alev_color_depth"
  if IFS= read -r -u "$fd" line; then
    __alev_terminal_apply_capabilities "$line"
  fi
  __alev_worker_close_fd "$fd"
  __alev_terminal_capability_worker_fd=-1
  if [[ $old != "$__alev_icon_mode $__alev_color_depth" ]]; then
    __alev_zle_try_redraw
  fi
  if [[ $_ALEV_CAPABILITIES_AUTO_REFRESH == true && $_ALEV_CAPABILITIES_REFRESH_INTERVAL_SECONDS == <-> ]] && (( _ALEV_CAPABILITIES_REFRESH_INTERVAL_SECONDS > 0 )); then
    __alev_terminal_start_capability_worker "$_ALEV_CAPABILITIES_REFRESH_INTERVAL_SECONDS"
  fi
  return 0
}

# Refresh capabilities between commands or through explicitly enabled ZLE workers.
__alev_terminal_refresh_capabilities() {
  if (( __alev_zle_active )) && [[ $_ALEV_ZLE_INTEGRATION == true && $_ALEV_ASYNC == true && -o interactive ]]; then
    __alev_terminal_start_capability_worker 0
    return 0
  fi
  local config_key="$_ALEV_ICON_MODE|$_ALEV_COLOR_DEPTH|$_ALEV_TRUECOLOR|$_ALEV_KONSOLE_RGB_HINT|${TERM:-}|${COLORTERM:-}|${TTY:-}|${LANG:-}|${LC_ALL:-}|${LC_CTYPE:-}"
  local -F now=${EPOCHREALTIME:-${EPOCHSECONDS:-0}}
  if (( __alev_terminal_capabilities_checked )) && [[ $config_key == "$__alev_terminal_capability_config_key" ]]; then
    [[ $_ALEV_CAPABILITIES_AUTO_REFRESH == true && $_ALEV_CAPABILITIES_REFRESH_INTERVAL_SECONDS == <-> ]] || return 0
    (( _ALEV_CAPABILITIES_REFRESH_INTERVAL_SECONDS > 0 )) || return 0
    (( now < __alev_terminal_capabilities_checked_at || now-__alev_terminal_capabilities_checked_at >= _ALEV_CAPABILITIES_REFRESH_INTERVAL_SECONDS )) || return 0
  fi
  if __alev_terminal_apply_capabilities "$(__alev_terminal_query_capabilities)"; then
    __alev_terminal_capabilities_checked=1
    __alev_terminal_capabilities_checked_at=${EPOCHREALTIME:-${EPOCHSECONDS:-0}}
    __alev_terminal_capability_config_key=$config_key
  fi
  return 0
}

# Report effective iconography, color depth and width budget.
_alev_capabilities() {
  print -r -- 'Icon policy: explicit selection with ASCII fallback'
  print -r -- "Requested iconography: $_ALEV_ICON_MODE"
  print -r -- "Iconography: $__alev_icon_mode"
  print -r -- "Color depth: $__alev_color_depth"
  print -r -- "Terminal: ${TERM:-unknown} (${TTY:-unknown})"
  __alev_terminal_columns
  print -r -- "Columns: ${COLUMNS:-0} (effective $REPLY)"
  __alev_terminal_width_budget "$REPLY"; print -r -- "Prompt width budget: $REPLY"
  print -r -- "ZLE integration: $([[ $__alev_zle_active == 1 && $_ALEV_ZLE_INTEGRATION == true ]] && print enabled || print disabled)"
  print -r -- "Effective user ID: $EUID"
  print -r -- "Root mode: $(__alev_is_root && print yes || print no)"
  if (( $+commands[whoami] )); then
    print -r -- "Effective username: $(command whoami 2>/dev/null)"
  fi
  print -r -- "Native Linux console: $(__alev_linux_console_is_native && print yes || print no)"
  print -r -- "Automatic stderr coloring: $_ALEV_STDERR_AUTO_ENABLED"
  print -r -- "Konsole client: $(__alev_konsole_is_local_client && print yes || print no)"
  print -r -- "Konsole RGB hint: $_ALEV_KONSOLE_RGB_HINT"
}

# Change the active icon mode and request a refresh.
_alev_icons() {
  case ${1:-} in nf|unicode|ascii) _ALEV_ICON_MODE=$1 ;; *) print -u2 'Usage: _alev_icons nf|unicode|ascii'; return 2 ;; esac
  __alev_worker_close_fd $__alev_terminal_capability_worker_fd
  __alev_terminal_capability_worker_fd=-1
  __alev_terminal_capabilities_checked=0
  __alev_terminal_refresh_capabilities
  __alev_prompt_render
}

# Calculate WCAG relative luminance for an RGB triple using linearized sRGB.
__alev_color_rgb_luminance() {
  local -F channel linear total=0.0
  local -a weights=(0.2126 0.7152 0.0722)
  local -i k=1
  for channel in "$@"; do
    (( linear=channel/255.0 ))
    if (( linear <= 0.04045 )); then
      (( linear=linear/12.92 ))
    else
      (( linear=((linear+0.055)/1.055)**2.4 ))
    fi
    (( total += weights[k]*linear, ++k ))
  done
  REPLY=$total
  return 0
}

# Convert an index in a nominal terminal palette to RGB.
__alev_color_palette_index_to_rgb() {
  local -i palette_index=$1 palette_depth=$2 cube_offset cube_side cube_stride gray_level
  local -a cube_levels gray_levels=(46 92 115 139 162 185 208 231)
  if (( palette_index < 16 )); then
    REPLY="#${__alev_color_ansi16_reference_rgb[palette_index+1]}"
    return 0
  fi
  if (( palette_depth == 256 )); then
    cube_levels=(0 95 135 175 215 255)
    cube_side=6
  else
    cube_levels=(0 139 205 255)
    cube_side=4
  fi
  cube_offset=$((palette_index-16))
  cube_stride=$((cube_side*cube_side))
  if (( cube_offset < cube_stride*cube_side )); then
    printf -v REPLY '#%02X%02X%02X' \
      "${cube_levels[cube_offset/cube_stride+1]}" \
      "${cube_levels[cube_offset/cube_side%cube_side+1]}" \
      "${cube_levels[cube_offset%cube_side+1]}"
  else
    if (( palette_depth == 256 )); then
      gray_level=$((8+10*(palette_index-232)))
    else
      gray_level=${gray_levels[palette_index-79]}
    fi
    printf -v REPLY '#%02X%02X%02X' "$gray_level" "$gray_level" "$gray_level"
  fi
}

# Quantize RGB by weighted distance, optionally excluding low-contrast foregrounds.
__alev_color_find_palette_index() {
  emulate -L zsh
  setopt extendedglob
  local hex=${1#\#} ansi=$2 depth=$3 policy=${4:-raw} candidate_rgb
  local key="$1:$2:$3:$policy:$__alev_color_dark_theme"
  local -i neutral_index=7
  [[ $__alev_color_dark_theme == true ]] || neutral_index=0
  [[ $hex == [0-9a-fA-F]## && ${#hex} == 6 ]] || { REPLY=$neutral_index; return 0; }
  if [[ -n ${__alev_color_cache[$key]:-} ]]; then
    REPLY=${__alev_color_cache[$key]}
    return 0
  fi
  if [[ $ansi == <-> && ${#ansi} -le 3 ]] && (( 10#$ansi < depth )); then
    REPLY=$((10#$ansi))
    return 0
  fi
  local -i r=$((16#${hex[1,2]})) g=$((16#${hex[3,4]})) b=$((16#${hex[5,6]}))
  local -i i rr gg bb idx=$neutral_index start=0 lim=$depth
  local -F dist best=1e12 mean bg_lum threshold
  if [[ $policy == contrast ]]; then
    __alev_color_rgb_luminance "${__alev_color_background_rgb[@]}"
    bg_lum=$REPLY
    (( threshold=(depth == 8 || (depth == 16 && bg_lum > 0.5)) ? 3.0 : 4.5 ))
    (( depth >= 88 )) && start=16
  fi
  for (( i=start; i<lim; ++i )); do
    __alev_color_palette_index_to_rgb "$i" "$depth"
    candidate_rgb=${REPLY#\#}
    rr=$((16#${candidate_rgb[1,2]}))
    gg=$((16#${candidate_rgb[3,4]}))
    bb=$((16#${candidate_rgb[5,6]}))
    if [[ $policy == contrast ]]; then
      __alev_color_rgb_luminance "$rr" "$gg" "$bb"
      if (( bg_lum > 0.5 )); then
        (( (bg_lum+0.05) >= threshold*(REPLY+0.05) )) || continue
      else
        (( (REPLY+0.05) >= threshold*(bg_lum+0.05) )) || continue
      fi
    fi
    (( mean=(r+rr)/2.0 ))
    (( dist=(2.0+mean/256.0)*(r-rr)**2+4.0*(g-gg)**2+(2.0+(255.0-mean)/256.0)*(b-bb)**2 ))
    if (( dist < best )); then
      best=$dist
      idx=$i
    fi
  done
  REPLY=$idx
  __alev_color_cache[$key]=$idx
}

# ---------------- Prompt text formatting ----------------
# Dynamic prompt data is escaped, never recursively evaluated as shell code.

# Escape literal prompt text and replace control characters.
__alev_prompt_escape_text() {
  emulate -L zsh
  local value=$1
  value=${value//[[:cntrl:]]/?}
  REPLY=${value//\%/%%}
}

# Encode the foreground explicitly in the selected terminal color format.
__alev_color_foreground_sgr() {
  emulate -L zsh
  local hex=${1#\#} ansi=$2
  REPLY=''
  if [[ $__alev_color_depth == truecolor ]]; then
    if [[ $hex != [[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]] ]]; then
      local default_text=${__alev_color_palette_defaults[TEXT]}
      hex=${default_text%% *}
      hex=${hex#\#}
    fi
    printf -v REPLY '\033[38;2;%d;%d;%dm' \
      "$((16#${hex[1,2]}))" "$((16#${hex[3,4]}))" "$((16#${hex[5,6]}))"
  elif [[ $__alev_color_depth == 256 || $__alev_color_depth == 88 ]]; then
    __alev_color_find_palette_index "#$hex" "$ansi" "$__alev_color_depth"
    REPLY=$'\e[38;5;'"${REPLY}m"
  else
    __alev_color_find_palette_index "#$hex" "$ansi" "$__alev_color_depth"
    if (( REPLY < 8 )); then
      REPLY=$'\e['"$((30+REPLY))m"
    else
      REPLY=$'\e['"$((90+REPLY-8))m"
    fi
  fi
}

# Mark foreground escape bytes as zero-width for ZLE.
__alev_color_prompt_escape() {
  __alev_color_foreground_sgr "$1" "$2"
  [[ -n $REPLY ]] && REPLY="%{${REPLY}%}"
  return 0
}

# Render literal text with the requested color and optional bold styling.
__alev_color_render_text() {
  local value=$1 hex=$2 ansi=$3 bold=${4:-false} prefix
  __alev_prompt_escape_text "$value"
  value=$REPLY
  __alev_color_prompt_escape "$hex" "$ansi"
  prefix=$REPLY
  local suffix=''; [[ -n $prefix ]] && suffix=$'%{\e[39m%}'
  if [[ $bold == true ]]; then
    REPLY="%B${prefix}${value}${suffix}%b"
  else
    REPLY="${prefix}${value}${suffix}"
  fi
}

# Resolve the configured RGB and requested-depth fallback into the caller's variables (defaults to active depth).
__alev_color_resolve_role() {
  local name=$1 hexvar="_ALEV_${1}_COLOR" ansivar="_ALEV_${1}_ANSI"
  local depth=${2:-$__alev_color_depth}
  local -a entries
  local -i column=2
  local default=${__alev_color_palette_defaults[$name]}
  entries=( ${=default} )
  hex=${(P)hexvar}
  case $depth in
    88) ansivar+=_88; column=3 ;;
    16) ansivar+=_16; column=4 ;;
    8) ansivar+=_8; column=5 ;;
    truecolor) ansi=auto; return 0 ;;
  esac
  ansi=${(P)ansivar}
  if [[ $ansi == auto || -z $ansi ]]; then
    if [[ ${(U)hex} == ${(U)entries[1]} ]]; then
      ansi=${entries[column]}
    else
      __alev_color_find_palette_index "$hex" auto "$depth" contrast
      ansi=$REPLY
    fi
  elif [[ $ansi != <-> || ${#ansi} -gt 3 ]] || (( 10#$ansi >= depth )); then
    __alev_color_find_palette_index "$hex" auto "$depth" contrast
    ansi=$REPLY
  fi
  return 0
}

# Apply the configured suggestion color without modifying ZLE widgets or registering hooks.
__alev_autosuggest_apply_style() {
  emulate -L zsh
  [[ -o interactive && $_ALEV_AUTOSUGGEST_OVERRIDE == true ]] || return 0
  local depth=$__alev_color_depth reported_colors=${terminfo[colors]:-0}
  local hex ansi
  # ZLE enforces the reported limit for palette indices; RGB is handled by Zsh itself.
  if [[ $depth != truecolor ]]; then
    [[ $reported_colors == <-> ]] || reported_colors=0
    if (( reported_colors < 16 )); then
      depth=8
    elif (( reported_colors < 88 && depth > 16 )); then
      depth=16
    elif (( reported_colors < 256 && depth > 88 )); then
      depth=88
    fi
  fi
  __alev_color_resolve_role AUTOSUGGEST "$depth"
  if [[ $depth == truecolor ]]; then
    if [[ $hex != '#'[[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]] ]]; then
      local default_suggestion=${__alev_color_palette_defaults[AUTOSUGGEST]}
      hex=${default_suggestion%% *}
    fi
    typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$hex"
  else
    typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$ansi"
  fi
  return 0
}

# Resolve a named palette role and render its text.
__alev_color_render_role() {
  local hex ansi
  __alev_color_resolve_role "$1"
  __alev_color_render_text "$2" "$hex" "$ansi" "${3:-false}"
}

# Convert Git counter digits to superscript or subscript when supported.
__alev_git_format_counter_digits() {
  emulate -L zsh
  local git_count_text=$1 git_digit_mode=$2 git_digit_symbols git_formatted_count='' git_digit
  local -i git_digit_index
  if [[ $git_digit_mode == sub ]]; then
    __alev_icon_get_symbol GIT_SUBSCRIPT_DIGITS; git_digit_symbols=$REPLY
  else
    __alev_icon_get_symbol GIT_SUPERSCRIPT_DIGITS; git_digit_symbols=$REPLY
  fi
  [[ ${#git_digit_symbols} == 10 ]] || { REPLY=$git_count_text; return 0; }
  for (( git_digit_index=1; git_digit_index<=${#git_count_text}; ++git_digit_index )); do
    git_digit=${git_count_text[git_digit_index]}
    if [[ $git_digit == [0-9] ]]; then
      git_formatted_count+=${git_digit_symbols[$((git_digit+1))]}
    else
      git_formatted_count+=$git_digit
    fi
  done
  REPLY=$git_formatted_count
}

# Render a nonzero Git counter with its symbol and palette role.
__alev_git_render_counter() {
  local git_count=$1 git_counter_symbol=$2 git_counter_color_role=$3 git_digit_mode=${4:-super} git_counter_gap=''
  REPLY=''; (( git_count > 0 )) || return 0
  if [[ $__alev_icon_mode == nf && -n $git_counter_symbol ]]; then
    case $git_counter_color_role in
      GIT_STAGED|GIT_CONFLICT|GIT_MODIFIED|GIT_DELETED|GIT_UNTRACKED) git_counter_gap=$__ALEV_GIT_NF_COUNTER_GAP ;;
    esac
  fi
  __alev_git_format_counter_digits "$git_count" "$git_digit_mode"
  __alev_color_render_role "$git_counter_color_role" "${git_counter_symbol}${git_counter_gap}${REPLY}"
}

# Format elapsed seconds as a compact human-readable duration.
__alev_command_format_duration() {
  emulate -L zsh
  local -F elapsed=$1
  local -i secs days hours mins
  (( elapsed < 0 )) && elapsed=0
  if (( elapsed < 60 )); then
    LC_NUMERIC=C printf -v REPLY '%.2fs' "$elapsed"
    [[ $REPLY == 60.00s ]] && REPLY='1m0s'
  else
    secs=$(( int(elapsed) ))
    days=$(( secs / 86400 ))
    hours=$(( secs / 3600 % 24 ))
    mins=$(( secs / 60 % 60 ))
    secs=$(( secs % 60 ))
    if (( days )); then
      REPLY="${days}d${hours}h${mins}m${secs}s"
    elif (( hours )); then
      REPLY="${hours}h${mins}m${secs}s"
    else
      REPLY="${mins}m${secs}s"
    fi
  fi
  return 0
}

# Color the duration according to configured elapsed-time thresholds.
__alev_command_render_duration() {
  local value id=TIME_IDLE
  __alev_command_format_duration "$__alev_command_elapsed_seconds"
  value=$REPLY
  if [[ $_ALEV_COMMAND_TIME_DYNAMIC_COLORS == true ]]; then
    if (( __alev_command_elapsed_seconds >= _ALEV_TIME_EXTREME_SECONDS )); then
      id=TIME_EXTREME
    elif (( __alev_command_elapsed_seconds >= _ALEV_TIME_VERY_LONG_SECONDS )); then
      id=TIME_VERY_LONG
    elif (( __alev_command_elapsed_seconds >= _ALEV_TIME_LONG_SECONDS )); then
      id=TIME_LONG
    elif (( __alev_command_elapsed_seconds >= _ALEV_TIME_MEDIUM_SECONDS )); then
      id=TIME_MEDIUM
    elif (( __alev_command_elapsed_seconds >= _ALEV_TIME_SHORT_SECONDS )); then
      id=TIME_SHORT
    fi
  fi
  __alev_color_render_role "$id" "$value"
}

# Read system uptime without spawning a process on Linux. On BSD/macOS use boot time.
# Return failure when no supported source is available; never display a fabricated zero.
__alev_uptime_seconds() {
  emulate -L zsh
  local value rest boot stamp
  REPLY=''
  if [[ -r /proc/uptime ]]; then
    IFS=' ' read -r value rest < /proc/uptime || return 1
    value=${value%%.*}
    [[ $value == <-> ]] || return 1
    REPLY=$value
  elif [[ $OSTYPE == (darwin*|*bsd*|dragonfly*) ]] && (( $+commands[sysctl] )); then
    boot=$(LC_ALL=C command sysctl -n kern.boottime 2>/dev/null) || return 1
    # BSD may return a bare epoch value or a structure containing sec = ... .
    if [[ $boot == <-> ]]; then
      stamp=$boot
    elif [[ $boot == *'sec = '* ]]; then
      stamp=${boot#*sec = }
      stamp=${stamp%%[^0-9]*}
    else
      return 1
    fi
    [[ $stamp == <-> && ${EPOCHSECONDS:-0} == <-> ]] || return 1
    (( EPOCHSECONDS >= 10#$stamp && 10#$stamp > 0 )) || return 1
    REPLY=$(( EPOCHSECONDS - 10#$stamp ))
  else
    return 1
  fi
  return 0
}

# SS, MM:SS, HH:MM:SS or D:HH:MM:SS (days are never zero-padded).
__alev_uptime_format() {
  emulate -L zsh
  [[ $1 == <-> ]] || { REPLY=''; return 1; }
  local -i secs=$(( 10#$1 )) days hours mins
  days=$(( secs / 86400 ))
  hours=$(( secs / 3600 % 24 ))
  mins=$(( secs / 60 % 60 ))
  secs=$(( secs % 60 ))
  if (( days > 0 )); then
    printf -v REPLY '%d:%02d:%02d:%02d' "$days" "$hours" "$mins" "$secs"
  elif (( hours > 0 )); then
    printf -v REPLY '%02d:%02d:%02d' "$hours" "$mins" "$secs"
  elif (( mins > 0 )); then
    printf -v REPLY '%02d:%02d' "$mins" "$secs"
  else
    printf -v REPLY '%02d' "$secs"
  fi
  return 0
}

# ---------------- Git ----------------
# Porcelain v2 uses NUL-delimited records; renames have an extra record.

# Read local Git porcelain status and build a compact state record.
__alev_git_query_status() {
  emulate -L zsh
  local git_status_record git_branch_name='' git_commit_oid='' git_change_flags git_reference git_tag_name git_reference_icon_id
  local -i git_ahead_count=0 git_behind_count=0 git_staged_count=0 git_conflict_count=0 git_modified_count=0 git_deleted_count=0 git_untracked_count=0
  if [[ $_ALEV_GIT_ENABLED != true ]] || (( ! $+commands[git] )); then
    print -r -- '0'
    return 0
  fi
  while IFS= read -r -d '' git_status_record; do
    case $git_status_record in
      ('# branch.head '*) git_branch_name=${git_status_record#\# branch.head } ;;
      ('# branch.oid '*) git_commit_oid=${git_status_record#\# branch.oid } ;;
      ('# branch.ab '*)
        local git_upstream_counts=${git_status_record#\# branch.ab } git_ahead_field git_behind_field
        git_ahead_field=${git_upstream_counts%% *}
        git_behind_field=${git_upstream_counts##* }
        git_ahead_field=${git_ahead_field#+}
        git_behind_field=${git_behind_field#-}
        [[ $git_ahead_field == <-> ]] && git_ahead_count=$git_ahead_field
        [[ $git_behind_field == <-> ]] && git_behind_count=$git_behind_field ;;
      ('1 '*|'2 '*)
        git_change_flags=${git_status_record[3,4]}
        [[ ${git_change_flags[1]} != . ]] && (( ++git_staged_count ))
        [[ ${git_change_flags[2]} == [MTRC] ]] && (( ++git_modified_count ))
        [[ $git_change_flags == *D* ]] && (( ++git_deleted_count ))
        [[ $git_status_record == '2 '* ]] && IFS= read -r -d '' git_status_record ;;
      ('u '*) (( ++git_conflict_count )) ;;
      ('? '*) (( ++git_untracked_count )) ;;
    esac
  done < <(GIT_OPTIONAL_LOCKS=0 GIT_TERMINAL_PROMPT=0 GIT_NO_LAZY_FETCH=1 command git --no-optional-locks status --porcelain=v2 --branch --untracked-files=all --ignore-submodules=all -z 2>/dev/null)
  [[ -n $git_branch_name ]] || { print -r -- '0'; return 0; }
  git_reference_icon_id=GIT_BRANCH
  git_reference=$git_branch_name
  if [[ $git_branch_name == '(detached)' ]]; then
    git_tag_name=$(GIT_OPTIONAL_LOCKS=0 GIT_NO_LAZY_FETCH=1 GIT_TERMINAL_PROMPT=0 command git describe --tags --exact-match HEAD 2>/dev/null)
    if [[ -n $git_tag_name ]]; then
      git_reference_icon_id=GIT_TAG
      git_reference=$git_tag_name
    else
      git_reference="${git_commit_oid[1,7]}"
    fi
    git_ahead_count=0
    git_behind_count=0
  fi
  # Git reference names cannot contain tabs or control characters; no eval.
  printf '1\t%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n' "$git_reference_icon_id" "$git_reference" "$git_ahead_count" "$git_behind_count" "$git_staged_count" "$git_conflict_count" "$git_modified_count" "$git_deleted_count" "$git_untracked_count"
}

# Render Git references, cleanliness and enabled counters.
__alev_git_render_status() {
  emulate -L zsh
  local -a git_status_fields git_change_segments
  local -a git_counter_roles=(GIT_AHEAD GIT_BEHIND GIT_STAGED GIT_CONFLICT GIT_MODIFIED GIT_DELETED GIT_UNTRACKED)
  local -a git_counter_settings=(_ALEV_GIT_SHOW_AHEAD _ALEV_GIT_SHOW_BEHIND _ALEV_GIT_SHOW_STAGED
    _ALEV_GIT_SHOW_CONFLICTS _ALEV_GIT_SHOW_MODIFIED _ALEV_GIT_SHOW_DELETED _ALEV_GIT_SHOW_UNTRACKED)
  local git_reference_symbol git_reference git_reference_color_role=GIT_CLEAN git_status_segment git_sync_segment=''
  local git_counter_role git_counter_setting git_counter_symbol git_counter_digit_mode
  local -i git_counter_index git_counter_count
  git_status_fields=( "${(@ps:\t:)1}" )
  [[ ${git_status_fields[1]} == 1 && ${#git_status_fields} == 10 ]] || { REPLY='0'; return 0; }
  __alev_icon_get_symbol "${git_status_fields[2]}"
  git_reference_symbol=$REPLY
  git_reference=${git_status_fields[3]}
  [[ -n $git_reference_symbol ]] && git_reference="$git_reference_symbol $git_reference"
  for (( git_counter_index=6; git_counter_index<=10; ++git_counter_index )); do
    if (( git_status_fields[git_counter_index] )); then
      git_reference_color_role=GIT_DIRTY
      break
    fi
  done
  __alev_color_render_role "$git_reference_color_role" "$git_reference" true
  git_status_segment=$REPLY
  __alev_color_render_role TEXT " on "
  git_status_segment="${REPLY}${git_status_segment}"
  if [[ $_ALEV_GIT_SHOW_COUNTERS != true ]]; then
    REPLY="1${git_status_segment}"
    return 0
  fi
  for (( git_counter_index=1; git_counter_index<=${#git_counter_roles}; ++git_counter_index )); do
    git_counter_role=${git_counter_roles[git_counter_index]}
    git_counter_setting=${git_counter_settings[git_counter_index]}
    [[ ${(P)git_counter_setting} == true ]] || continue
    git_counter_count=${git_status_fields[git_counter_index+3]}
    (( git_counter_count > 0 )) || continue
    __alev_icon_get_symbol "$git_counter_role"
    git_counter_symbol=$REPLY
    git_counter_digit_mode=super
    [[ $git_counter_role == GIT_BEHIND ]] && git_counter_digit_mode=sub
    __alev_git_render_counter "$git_counter_count" "$git_counter_symbol" "$git_counter_role" "$git_counter_digit_mode"
    if (( git_counter_index <= 2 )); then
      git_sync_segment+=$REPLY
    else
      git_change_segments+=("$REPLY")
    fi
  done
  [[ -n $git_sync_segment ]] && git_status_segment+="  $git_sync_segment"
  (( ${#git_change_segments} )) && git_status_segment+="  ${(j: :)git_change_segments}"
  REPLY="1${git_status_segment}"
}

# ---------------- Project detection ----------------

# Enumerate the current directory and permitted parent directories.
__alev_project_parent_directories() {
  emulate -L zsh
  local -i max=$1 i=0
  local dir=$PWD
  reply=()
  (( max < 0 )) && max=0
  while (( i <= max )); do
    reply+=("$dir")
    [[ $dir == / ]] && break
    if [[ $_ALEV_DETECTION_STOP_AT_GIT_ROOT == true && ( -e $dir/.git || -L $dir/.git ) ]]; then
      break
    fi
    dir=${dir:h}; (( ++i ))
  done
  return 0
}

# Resolve an individual runtime search depth or inherit the global value.
__alev_project_resolve_search_depth() {
  local key="_ALEV_${1}_DETECTION_MAX_DEPTH" value
  value=${(P)key}; [[ $value == <-> ]] || value=$_ALEV_DETECTION_MAX_DEPTH
  [[ $value == <-> ]] || value=3
  REPLY=$value
}

# Check a directory for literal or glob-based project markers.
__alev_project_directory_has_markers() {
  emulate -L zsh
  setopt extendedglob
  local dir=$1 marker; shift
  local -a hits
  for marker in "$@"; do
    if [[ $marker == *'*'* || $marker == *'?'* || $marker == *'['* ]]; then
      hits=("$dir"/${~marker}(N))
      (( ${#hits} )) && return 0
    elif [[ -e $dir/$marker || -L $dir/$marker ]]; then
      return 0
    fi
  done
  return 1
}

# Read a project file only when its size is within the configured limit.
__alev_project_read_bounded_file() {
  emulate -L zsh
  local file=$1
  local -A st
  REPLY=''
  [[ -f $file && -r $file ]] || return 1
  # Avoid reading arbitrarily large project configuration files.
  if ! zstat -H st -- "$file" 2>/dev/null; then
    return 1
  fi
  (( st[size] <= _ALEV_SCAN_MAX_BYTES )) || return 1
  REPLY=$(<"$file")
}

# Check for regular non-hidden source files of a given extension in one directory.
__alev_project_directory_has_source_files() {
  emulate -L zsh
  local project_directory=$1 source_extension=$2
  local -a source_files
  source_files=("$project_directory"/*.$source_extension(N-.))
  (( ${#source_files} > 0 ))
}

# Check enabled runtime source extensions using the same rule for detection and caching.
__alev_project_has_runtime_sources() {
  local runtime_id=$1 project_directory=$2 source_setting="_ALEV_${1}_DETECT_SOURCE_FILES" source_extension
  local -a source_extensions
  [[ ${(P)source_setting} == true ]] || return 1
  case $runtime_id in
    GO|DART|LUA|SWIFT) source_extensions=( "${(L)runtime_id}" ) ;;
    PHP) source_extensions=( php phtml ) ;;
    R) source_extensions=( R r Rmd rmd ) ;;
    *) return 1 ;;
  esac
  for source_extension in "${source_extensions[@]}"; do
    __alev_project_directory_has_source_files "$project_directory" "$source_extension" && return 0
  done
  return 1
}

# Detect Kotlin projects from markers and literal build declarations.
__alev_kotlin_detect_project() {
  emulate -L zsh
  local dir=$1 file content
  local re='org\.jetbrains\.kotlin\.(jvm|android|multiplatform|js|plugin\.|kapt)|kotlin-maven-plugin|kotlin[[:space:]]*\([[:space:]]*"(jvm|multiplatform|android|js|plugin\.[^"]+)"|(^|[[:space:]])kotlin[[:space:]=:]'
  __alev_project_directory_has_markers "$dir" "${_ALEV_KOTLIN_DETECTION_MARKERS[@]}" && return 0
  for file in build.gradle build.gradle.kts settings.gradle settings.gradle.kts pom.xml gradle/libs.versions.toml .sdkmanrc .tool-versions; do
    __alev_project_read_bounded_file "$dir/$file" || continue
    content=$REPLY
    [[ $content =~ $re ]] && return 0
  done
  return 1
}

# Detect Swift projects, including Xcode configuration files.
__alev_swift_detect_project() {
  emulate -L zsh
  local dir=$1 file
  __alev_project_directory_has_markers "$dir" "${_ALEV_SWIFT_DETECTION_MARKERS[@]}" && return 0
  for file in "$dir"/*.xcodeproj/project.pbxproj(N); do
    __alev_project_read_bounded_file "$file" || continue
    [[ $REPLY == *SWIFT_VERSION* || $REPLY == *sourcecode.swift* ]] && return 0
  done
  return 1
}

# Detect R projects and package metadata.
__alev_r_detect_project() {
  local dir=$1
  __alev_project_directory_has_markers "$dir" "${_ALEV_R_DETECTION_MARKERS[@]}" && return 0
  if [[ -f $dir/DESCRIPTION && -f $dir/NAMESPACE ]]; then
    __alev_project_read_bounded_file "$dir/DESCRIPTION" && [[ $REPLY == *'Package:'* ]] && return 0
  fi
  return 1
}

# Find the closest matching project within the configured search depth.
__alev_project_find_root() {
  emulate -L zsh
  local id=$1 name="_ALEV_${1}_DETECTION_MARKERS" dir
  local -a markers dirs reply
  markers=( "${(@P)name}" )
  __alev_project_resolve_search_depth "$id"; __alev_project_parent_directories "$REPLY"; dirs=("${reply[@]}")
  REPLY=''
  for dir in "${dirs[@]}"; do
    case $id in
      JAVA)
        if ! __alev_project_directory_has_markers "$dir" "${markers[@]}"; then
          local java_re='(^|[[:space:]])java[[:space:]=]+[^[:space:]]+' file matched=false
          for file in .sdkmanrc .tool-versions; do
            if __alev_project_read_bounded_file "$dir/$file" && [[ $REPLY =~ $java_re ]]; then
              matched=true
              break
            fi
          done
          [[ $matched == true ]] || continue
        fi ;;
      KOTLIN) __alev_kotlin_detect_project "$dir" || continue ;;
      GO|DART|PHP|LUA)
        __alev_project_directory_has_markers "$dir" "${markers[@]}" ||
          __alev_project_has_runtime_sources "$id" "$dir" || continue ;;
      SWIFT) __alev_swift_detect_project "$dir" || __alev_project_has_runtime_sources "$id" "$dir" || continue ;;
      R) __alev_r_detect_project "$dir" || __alev_project_has_runtime_sources "$id" "$dir" || continue ;;
      *) __alev_project_directory_has_markers "$dir" "${markers[@]}" || continue ;;
    esac
    REPLY=$dir
    return 0
  done
  return 1
}

# ---------------- Runtime version lookup ----------------

# Run a version query with an optional timeout and no terminal input.
__alev_runtime_run_version_command() {
  __alev_run_bounded_command "$@" 2>&1
}

# Extract a version number from runtime output.
__alev_runtime_parse_version() {
  emulate -L zsh
  local str=$1 re='[0-9]+\.[0-9]+(\.[0-9]+)?([+-][[:alnum:].-]+)?'
  REPLY=''
  if [[ $str =~ $re ]]; then
    REPLY=$MATCH
    return 0
  fi
  return 1
}

# Compare SDK version components and prerelease identifiers.
__alev_sdk_newer() {
  emulate -L zsh
  local left=$1 right=$2 lbase=${1%%-*} rbase=${2%%-*} a b lp rp
  local -a la ra lpre rpre
  local -i i n
  [[ -z $right ]] && return 0
  la=( ${(s:.:)lbase} )
  ra=( ${(s:.:)rbase} )
  n=$(( ${#la} > ${#ra} ? ${#la} : ${#ra} ))
  for (( i=1; i<=n; ++i )); do
    a=${la[i]:-0}
    b=${ra[i]:-0}
    (( 10#$a > 10#$b )) && return 0
    (( 10#$a < 10#$b )) && return 1
  done
  [[ $left != *-* && $right == *-* ]] && return 0
  [[ $left == *-* && $right != *-* ]] && return 1
  [[ $left != *-* ]] && return 1
  lp=${left#*-}
  rp=${right#*-}
  lpre=( ${(s:.:)lp} )
  rpre=( ${(s:.:)rp} )
  n=$(( ${#lpre} > ${#rpre} ? ${#lpre} : ${#rpre} ))
  for (( i=1; i<=n; ++i )); do
    (( i > ${#lpre} )) && return 1
    (( i > ${#rpre} )) && return 0
    a=$lpre[i]
    b=$rpre[i]; [[ $a == $b ]] && continue
    if [[ $a == <-> && $b == <-> ]]; then
      (( 10#$a > 10#$b ))
      return $?
    elif [[ $a == <-> ]]; then
      return 1
    elif [[ $b == <-> ]]; then
      return 0
    else
      [[ $a > $b ]]
      return $?
    fi
  done
  return 1
}

# Resolve the selected .NET SDK or the newest installed fallback.
__alev_dotnet_query_version() {
  emulate -L zsh
  local dotnet_command_output dotnet_output_line dotnet_sdk_version dotnet_newest_sdk_version='' dotnet_version_pattern='^[0-9]+\.[0-9]+\.[0-9]+(-[[:alnum:].-]+)?$'
  REPLY=''
  (( $+commands[dotnet] )) || return 1
  if dotnet_command_output=$(DOTNET_CLI_TELEMETRY_OPTOUT=1 DOTNET_NOLOGO=1 DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1 DOTNET_CLI_WORKLOAD_UPDATE_NOTIFY_DISABLE=true __alev_runtime_run_version_command dotnet --version); then
    for dotnet_output_line in "${(@f)dotnet_command_output}"; do
      [[ $dotnet_output_line =~ $dotnet_version_pattern ]] && { REPLY=$dotnet_output_line; return 0; }
    done
  fi
  dotnet_command_output=$(DOTNET_CLI_TELEMETRY_OPTOUT=1 DOTNET_NOLOGO=1 DOTNET_CLI_WORKLOAD_UPDATE_NOTIFY_DISABLE=true __alev_runtime_run_version_command dotnet --list-sdks) || return 1
  for dotnet_output_line in "${(@f)dotnet_command_output}"; do
    dotnet_sdk_version=${dotnet_output_line%% *}; [[ $dotnet_sdk_version =~ $dotnet_version_pattern ]] || continue
    __alev_sdk_newer "$dotnet_sdk_version" "$dotnet_newest_sdk_version" && dotnet_newest_sdk_version=$dotnet_sdk_version
  done
  [[ -n $dotnet_newest_sdk_version ]] || return 1
  REPLY="${dotnet_newest_sdk_version}~"  # ~ explicitly denotes fallback, not selected SDK
}

# Read a declared Kotlin version or query the installed compiler.
__alev_kotlin_query_version() {
  emulate -L zsh
  local kotlin_config_file kotlin_config_content kotlin_output_line
  local kotlin_plugin_version_pattern='(kotlin\("[^"]+"\)|id\("org\.jetbrains\.kotlin[^"]*"\)|id[[:space:]]+['"'"'"]org\.jetbrains\.kotlin[^'"'"'"]*['"'"'"])[[:space:]]+version[[:space:]]*\(?[[:space:]]*['"'"'"]([0-9]+\.[0-9]+\.[0-9]+([-.][[:alnum:].-]+)?)['"'"'"]'
  local kotlin_property_version_pattern='(^|[[:space:]])(kotlin\.version|kotlinVersion|kotlin)[[:space:]]*=[[:space:]]*"?([0-9]+\.[0-9]+\.[0-9]+([-.][[:alnum:].-]+)?)'
  local kotlin_xml_version_pattern='<kotlin.version>([0-9]+\.[0-9]+\.[0-9]+([-.][[:alnum:].-]+)?)</kotlin.version>'
  # Only literal versions in recognizable declarations; do not evaluate Gradle/Maven.
  local -a reply kotlin_parent_directories
  local kotlin_parent_directory
  __alev_project_resolve_search_depth KOTLIN; __alev_project_parent_directories "$REPLY"; kotlin_parent_directories=("${reply[@]}")
  for kotlin_parent_directory in "${kotlin_parent_directories[@]}"; do
    for kotlin_config_file in build.gradle.kts build.gradle settings.gradle.kts settings.gradle gradle.properties gradle/libs.versions.toml .sdkmanrc pom.xml; do
      __alev_project_read_bounded_file "$kotlin_parent_directory/$kotlin_config_file" || continue
      kotlin_config_content=$REPLY
      if [[ $kotlin_config_content =~ $kotlin_plugin_version_pattern ]]; then
        REPLY=${match[2]}
        return 0
      fi
      if [[ $kotlin_config_content =~ $kotlin_property_version_pattern ]]; then
        REPLY=${match[3]}
        return 0
      fi
      if [[ $kotlin_config_content =~ $kotlin_xml_version_pattern ]]; then
        REPLY=${match[1]}
        return 0
      fi
    done
  done
  if (( $+commands[kotlinc] )); then
    kotlin_config_content=$(__alev_runtime_run_version_command kotlinc -version) || return 1
    for kotlin_output_line in "${(@f)kotlin_config_content}"; do
      [[ $kotlin_output_line == *kotlinc* ]] && { __alev_runtime_parse_version "${kotlin_output_line#*kotlinc}"; return $?; }
    done
  fi
  return 1
}

# Query an installed Rust compiler without installing toolchains.
__alev_rust_query_version() {
  emulate -L zsh
  local rust_command_output rust_compiler_path rust_active_toolchain rust_installed_toolchains rust_toolchain_line
  (( $+commands[rustc] )) || return 1
  rust_compiler_path=$commands[rustc]
  # For rustup proxies, resolve an installed toolchain first, then execute its
  # actual compiler; do not invoke the proxy to install a missing toolchain.
  if (( $+commands[rustup] )) && [[ ${rust_compiler_path:A} == ${commands[rustup]:A} || $rust_compiler_path == ${CARGO_HOME:-$HOME/.cargo}/bin/rustc ]]; then
    rust_active_toolchain=$(RUSTUP_AUTO_INSTALL=0 __alev_runtime_run_version_command rustup show active-toolchain) || return 1
    rust_active_toolchain=${rust_active_toolchain%%[[:space:]]*}; [[ -n $rust_active_toolchain ]] || return 1
    rust_installed_toolchains=$(RUSTUP_AUTO_INSTALL=0 __alev_runtime_run_version_command rustup toolchain list) || return 1
    local rust_toolchain_found=false
    for rust_toolchain_line in "${(@f)rust_installed_toolchains}"; do [[ ${rust_toolchain_line%%[[:space:]]*} == $rust_active_toolchain ]] && { rust_toolchain_found=true; break; }; done
    [[ $rust_toolchain_found == true ]] || return 1
    rust_compiler_path=$(RUSTUP_AUTO_INSTALL=0 __alev_runtime_run_version_command rustup which --toolchain "$rust_active_toolchain" rustc) || return 1
    [[ -x $rust_compiler_path ]] || return 1
  fi
  rust_command_output=$(RUSTUP_AUTO_INSTALL=0 __alev_runtime_run_version_command "$rust_compiler_path" --version) || return 1
  __alev_runtime_parse_version "$rust_command_output"
}

# Locate an already installed Flutter Dart executable without invoking Flutter.
__alev_flutter_find_dart_executable() {
  local flutter_executable flutter_root
  REPLY=''
  if [[ -n ${FLUTTER_ROOT:-} && -x $FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart ]]; then
    REPLY=$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart
  elif (( $+commands[flutter] )); then
    flutter_executable=${commands[flutter]:A}
    flutter_root=${flutter_executable:h:h}
    [[ -x $flutter_root/bin/cache/dart-sdk/bin/dart ]] && REPLY=$flutter_root/bin/cache/dart-sdk/bin/dart
  fi
  [[ -n $REPLY ]]
}

# Resolve Dart from the project Flutter/FVM SDK or an installed runtime.
__alev_dart_query_version() {
  emulate -L zsh
  local dart_parent_directory dart_command_output dart_version_line dart_candidate_path dart_sdk_root='' dart_executable_path='' flutter_project_detected=false flutter_fvm_detected=false
  local __alev_query_timeout_seconds=$__alev_query_timeout_seconds
  REPLY=''
  if [[ -n $__alev_query_timeout_seconds && $_ALEV_DART_VERSION_QUERY_TIMEOUT_MS == <-> ]]; then
    if (( _ALEV_DART_VERSION_QUERY_TIMEOUT_MS == 0 )); then
      __alev_query_timeout_seconds=''
    else
      builtin printf -v __alev_query_timeout_seconds '%d.%03d' $(( _ALEV_DART_VERSION_QUERY_TIMEOUT_MS / 1000 )) $(( _ALEV_DART_VERSION_QUERY_TIMEOUT_MS % 1000 ))
    fi
  fi
  local -a reply dart_parent_directories
  __alev_project_resolve_search_depth DART; __alev_project_parent_directories "$REPLY"; dart_parent_directories=("${reply[@]}")
  for dart_parent_directory in "${dart_parent_directories[@]}"; do
    if [[ -e $dart_parent_directory/.fvm/flutter_sdk || -L $dart_parent_directory/.fvm/flutter_sdk || -f $dart_parent_directory/.fvmrc || -f $dart_parent_directory/.fvm/fvm_config.json ]]; then
      flutter_project_detected=true
      flutter_fvm_detected=true
      [[ -x $dart_parent_directory/.fvm/flutter_sdk/bin/cache/dart-sdk/bin/dart ]] && dart_executable_path=$dart_parent_directory/.fvm/flutter_sdk/bin/cache/dart-sdk/bin/dart
      break
    fi
    if [[ -f $dart_parent_directory/.flutter-plugins || -f $dart_parent_directory/.flutter-plugins-dependencies || -f $dart_parent_directory/flutter_launcher_icons.yaml || -f $dart_parent_directory/flutter_native_splash.yaml ]]; then
      flutter_project_detected=true
    fi
    if __alev_project_read_bounded_file "$dart_parent_directory/pubspec.yaml"; then
      local flutter_project_pattern='sdk:[[:space:]]*["'"'"']?flutter|flutter:[[:space:]]*[^[:space:]]*'
      [[ $REPLY =~ $flutter_project_pattern ]] && flutter_project_detected=true
    fi
  done
  if [[ $flutter_project_detected == true && -z $dart_executable_path ]]; then
    [[ $flutter_fvm_detected == true ]] && return 1  # do not report unrelated global Dart
    if __alev_flutter_find_dart_executable; then
      dart_executable_path=$REPLY
    fi
    [[ -n $dart_executable_path ]] || return 1
  elif [[ -z $dart_executable_path && -n ${DART_SDK:-} && -x $DART_SDK/bin/dart ]]; then
    dart_executable_path=$DART_SDK/bin/dart
  elif [[ -z $dart_executable_path ]] && (( $+commands[dart] )); then
    dart_executable_path=$commands[dart]
    dart_candidate_path=${dart_executable_path:A}
    dart_sdk_root=${dart_candidate_path:h:h}
    # Do not run Flutter's Dart wrapper, which can bootstrap its SDK.
    if [[ -f $dart_sdk_root/bin/internal/shared.sh ]]; then
      dart_executable_path=$dart_sdk_root/bin/cache/dart-sdk/bin/dart
      [[ -x $dart_executable_path ]] || return 1
    fi
  fi
  # A standalone Dart project may use the already-installed Flutter Dart SDK.
  if [[ -z $dart_executable_path && $flutter_project_detected != true ]]; then
    if __alev_flutter_find_dart_executable; then
      dart_executable_path=$REPLY
    fi
  fi
  [[ -n $dart_executable_path ]] || return 1
  dart_command_output=$(__alev_runtime_run_version_command "$dart_executable_path" --version) || return 1
  for dart_version_line in "${(@f)dart_command_output}"; do
    [[ $dart_version_line == 'Dart SDK version: '* ]] || continue
    __alev_runtime_parse_version "${dart_version_line#Dart SDK version: }"
    return $?
  done
  return 1
}

# Query the bundled Go toolchain offline, using GOVERSION before the legacy version command.
__alev_go_query_version() {
  emulate -L zsh
  local go_version_output go_version_line
  local go_env_version_pattern='^go[0-9]+\.[0-9]+(\.[0-9]+)?((rc|beta)[0-9]+)?$'
  local go_command_version_pattern='^go version[[:space:]]+go[0-9]+\.[0-9]+'
  REPLY=''
  (( $+commands[go] )) || return 1
  if go_version_output=$(GOTOOLCHAIN=local GOPROXY=off GOSUMDB=off __alev_runtime_run_version_command go env GOVERSION); then
    for go_version_line in "${(@f)go_version_output}"; do
      if [[ $go_version_line =~ $go_env_version_pattern ]]; then
        REPLY=${go_version_line#go}
        return 0
      fi
    done
  fi
  go_version_output=$(GOTOOLCHAIN=local GOPROXY=off GOSUMDB=off __alev_runtime_run_version_command go version) || return 1
  for go_version_line in "${(@f)go_version_output}"; do
    [[ $go_version_line =~ $go_command_version_pattern ]] || continue
    local go_version_token=${go_version_line#go version }
    go_version_token=${go_version_token%%[[:space:]]*}
    if [[ $go_version_token =~ $go_env_version_pattern ]]; then
      REPLY=${go_version_token#go}
      return 0
    fi
  done
  return 1
}

# Report installed Lua and LuaJIT versions independently; neither masks the other.
__alev_lua_query_version() {
  emulate -L zsh
  local lua_executable lua_output lua_line lua_version='' luajit_version=''
  local lua_version_prefix='^Lua[[:space:]]+[0-9]' luajit_version_prefix='^LuaJIT[[:space:]]+[0-9]'
  for lua_executable in lua luajit; do
    (( $+commands[$lua_executable] )) || continue
    lua_output=$(__alev_runtime_run_version_command "$lua_executable" -v) || continue
    for lua_line in "${(@f)lua_output}"; do
      if [[ $lua_line =~ $luajit_version_prefix ]]; then
        __alev_runtime_parse_version "$lua_line" && luajit_version=$REPLY
        break
      elif [[ $lua_line =~ $lua_version_prefix && $lua_executable == lua ]]; then
        __alev_runtime_parse_version "$lua_line" && lua_version=$REPLY
        break
      fi
    done
  done
  REPLY=''
  if [[ -n $lua_version && -n $luajit_version ]]; then
    REPLY="$lua_version / LuaJIT v$luajit_version"
  elif [[ -n $luajit_version ]]; then
    REPLY="LuaJIT v$luajit_version"
  else
    REPLY=$lua_version
  fi
  [[ -n $REPLY ]]
}

# Query R or Rscript without loading project code; accept their distinct version banners.
__alev_r_query_version() {
  emulate -L zsh
  local r_executable r_output r_line r_prefix='^(R version|Rscript( \(R\))? version)[[:space:]]+[0-9]'
  for r_executable in R Rscript; do
    (( $+commands[$r_executable] )) || continue
    r_output=$(__alev_runtime_run_version_command "$r_executable" --version) || continue
    for r_line in "${(@f)r_output}"; do
      [[ $r_line =~ $r_prefix ]] || continue
      __alev_runtime_parse_version "$r_line" && return 0
    done
  done
  REPLY=''
  return 1
}

# Dispatch to a runtime-specific version query and parser.
__alev_runtime_version() {
  emulate -L zsh
  local id=$1 out line
  local timeout_setting="_ALEV_${1}_VERSION_QUERY_TIMEOUT_MS" timeout_ms
  local __alev_query_timeout_seconds=$__alev_query_timeout_seconds
  timeout_ms=${(P)timeout_setting}
  if [[ -n $__alev_query_timeout_seconds && $id != DART && $timeout_ms == <-> ]]; then
    if (( timeout_ms == 0 )); then
      __alev_query_timeout_seconds=''
    else
      builtin printf -v __alev_query_timeout_seconds '%d.%03d' $(( timeout_ms / 1000 )) $(( timeout_ms % 1000 ))
    fi
  fi
  REPLY=''
  case $id in
    NODEJS) (( $+commands[node] )) || return 1; out=$(__alev_runtime_run_version_command node --version) || return 1 ;;
    JAVA) (( $+commands[javac] )) || return 1; out=$(__alev_runtime_run_version_command javac -version) || return 1 ;;
    KOTLIN) __alev_kotlin_query_version; return $? ;;
    GO) __alev_go_query_version; return $? ;;
    RUST) __alev_rust_query_version; return $? ;;
    DOTNET) __alev_dotnet_query_version; return $? ;;
    RUBY) (( $+commands[ruby] )) || return 1; out=$(__alev_runtime_run_version_command ruby --version) || return 1 ;;
    PHP)
      (( $+commands[php] )) || return 1
      if out=$(__alev_runtime_run_version_command php -n -r 'echo PHP_VERSION, PHP_EOL;'); then
        local php_version_pattern='^[0-9]+\.[0-9]+\.[0-9]+'
        for line in "${(@f)out}"; do
          [[ $line =~ $php_version_pattern ]] || continue
          __alev_runtime_parse_version "$line" && return 0
        done
      fi
      out=$(__alev_runtime_run_version_command php -n --version) || return 1 ;;
    LUA) __alev_lua_query_version; return $? ;;
    SWIFT) (( $+commands[swift] )) || return 1; out=$(__alev_runtime_run_version_command swift --version) || return 1 ;;
    DART) __alev_dart_query_version; return $? ;;
    R) __alev_r_query_version; return $? ;;
    *) return 1 ;;
  esac
  local prefix_re
  case $id in
    NODEJS) prefix_re='^v[0-9]' ;;
    JAVA) prefix_re='^javac[[:space:]]' ;;
    RUBY) prefix_re='^(ruby|jruby|truffleruby)[[:space:]]' ;;
    PHP) prefix_re='^PHP[[:space:]]' ;;
    SWIFT) prefix_re='^(Apple )?Swift version[[:space:]]' ;;
  esac
  for line in "${(@f)out}"; do
    [[ $line =~ $prefix_re ]] || continue
    __alev_runtime_parse_version "$line"
    return $?
  done
  return 1
}

# Detect an explicitly active Ruby version-manager environment.
__alev_ruby_manager_is_active() {
  # Merely installing RVM or rbenv is not an active environment.
  [[ -n ${rvm_ruby_string:-} && $rvm_ruby_string != system ]] || [[ -n ${RBENV_VERSION:-} && $RBENV_VERSION != system ]] || [[ -n ${RUBY_VERSION:-} && -n ${GEM_HOME:-} ]]
}

# Check whether any project runtime detector is enabled.
__alev_runtime_any_project_enabled() {
  [[ $_ALEV_LANGUAGES_ENABLED == true ]] || return 1
  local id key
  for id in "${__alev_runtime_ids[@]}"; do
    key="_ALEV_${id}_ENABLED"; [[ ${(P)key} == true ]] && return 0
  done
  return 1
}

# Detect enabled runtime contexts and serialize their versions.
__alev_runtime_query_versions() {
  emulate -L zsh
  [[ $_ALEV_LANGUAGES_ENABLED == true ]] || { print -r -- ''; return 0; }
  local id enabled version show_without_version_setting
  # Pipe-separated records on a SINGLE line, no shell eval or serialization code.
  local -a result
  for id in "${__alev_runtime_ids[@]}"; do
    enabled="_ALEV_${id}_ENABLED"; [[ ${(P)enabled} == true ]] || continue
    if ! __alev_project_find_root "$id"; then
      [[ $id == RUBY ]] && __alev_ruby_manager_is_active || continue
    fi
    if __alev_runtime_version "$id"; then
      version=$REPLY
    elif [[ $id == GO ]] && (( $+commands[go] )); then
      # Keep the detected Go context visible without inventing a version.
      version=unknown
    else
      show_without_version_setting="_ALEV_${id}_SHOW_WITHOUT_VERSION"
      [[ ${(P)show_without_version_setting} == true ]] || continue
      # Keep explicitly detected context visible without claiming an installed version.
      version=unknown
    fi
    [[ -n $version ]] || continue
    # Version parser only supplies bounded, printable version text.
    result+=("${id}=${version}")
  done
  print -r -- "${(j:|:)result}"
}

# ---------------- Caching and async ----------------

# Fingerprint project context, configuration and runtime executables.
__alev_runtime_build_context_signature() {
  emulate -L zsh
  local dir file id marker max=$_ALEV_DETECTION_MAX_DEPTH
  local -a reply dirs bits files selection=(global.json go.mod go.work rust-toolchain rust-toolchain.toml Cargo.toml
    .nvmrc .node-version package.json .ruby-version .ruby-gemset .rvmrc Gemfile .java-version .sdkmanrc .tool-versions
    build.gradle build.gradle.kts settings.gradle settings.gradle.kts gradle.properties gradle/libs.versions.toml pom.xml
    .php-version .lua-version .luajit-version .swift-version .dart-version pubspec.yaml .fvmrc .fvm/fvm_config.json .fvm/flutter_sdk renv.lock
    composer.json composer.lock .luacheckrc Package.swift Package.resolved DESCRIPTION NAMESPACE .Rprofile .Renviron)
  local -A st
  [[ $max == <-> ]] || max=3
  for id in "${__alev_runtime_ids[@]}"; do __alev_project_resolve_search_depth "$id"; (( REPLY > max )) && max=$REPLY; done
  __alev_project_parent_directories "$max"; dirs=("${reply[@]}")
  bits=("$PWD" "$PATH" "${VIRTUAL_ENV:-}" "${CONDA_PREFIX:-}" "${JAVA_HOME:-}" "${RUSTUP_TOOLCHAIN:-}" "${RUSTUP_HOME:-}" "${GOTOOLCHAIN:-}" "${RBENV_VERSION:-}" "${rvm_ruby_string:-}" "${GEM_HOME:-}" "${RUBY_VERSION:-}" "${FLUTTER_ROOT:-}" "${DART_SDK:-}" "${DOTNET_ROOT:-}" "${DOTNET_ROOT_X64:-}" "${MISE_ENV:-}" "${ASDF_DATA_DIR:-}")
  for id in "${__alev_runtime_ids[@]}"; do
    local enabled_name="_ALEV_${id}_ENABLED"
    __alev_project_resolve_search_depth "$id"; bits+=("$id:${(P)enabled_name}:$REPLY")
  done
  bits+=("$_ALEV_DETECTION_STOP_AT_GIT_ROOT")
  local runtime_source_setting runtime_show_setting runtime_timeout_setting runtime_marker_setting runtime_enabled_setting
  local -a source_runtime_ids=(GO DART PHP LUA SWIFT R)
  for id in "${source_runtime_ids[@]}"; do
    runtime_enabled_setting="_ALEV_${id}_ENABLED"
    [[ ${(P)runtime_enabled_setting} == true ]] || continue
    runtime_source_setting="_ALEV_${id}_DETECT_SOURCE_FILES"
    runtime_show_setting="_ALEV_${id}_SHOW_WITHOUT_VERSION"
    runtime_timeout_setting="_ALEV_${id}_VERSION_QUERY_TIMEOUT_MS"
    runtime_marker_setting="_ALEV_${id}_DETECTION_MARKERS"
    bits+=("$id:sources:${(P)runtime_source_setting}:show:${(P)runtime_show_setting}:timeout:${(P)runtime_timeout_setting}" "${(@P)runtime_marker_setting}")
  done
  for dir in "${dirs[@]}"; do
    for id in "${source_runtime_ids[@]}"; do
      runtime_enabled_setting="_ALEV_${id}_ENABLED"
      [[ ${(P)runtime_enabled_setting} == true ]] || continue
      if __alev_project_has_runtime_sources "$id" "$dir"; then
        bits+=("$dir:$id-source-present")
      fi
    done
    files=("$dir")
    for marker in "${selection[@]}"; do files+=("$dir/$marker"); done
    for file in "${files[@]}"; do
      [[ -e $file || -L $file ]] || continue
      if zstat -H st -- "$file" 2>/dev/null; then
        bits+=("$file:${st[mtime]}:${st[ctime]}:${st[size]}:${st[inode]}")
      fi
    done
  done
  # Include executable timestamps; a replacement on the same PATH invalidates cache.
  for id in node javac kotlinc go rustc rustup dotnet ruby php lua luajit swift dart flutter R Rscript; do
    (( $+commands[$id] )) || continue
    file=$commands[$id]
    if zstat -H st -- "$file" 2>/dev/null; then
      bits+=("$file:${st[mtime]}:${st[ctime]}:${st[inode]}")
    fi
  done
  REPLY="${(j:|:)bits}"
}

# Return the current epoch timestamp.
__alev_clock_epoch_seconds() {
  REPLY=${EPOCHREALTIME:-${EPOCHSECONDS:-0}}
}

# Cache a runtime result with its timestamp and enforce the entry limit.
__alev_runtime_store_cache_entry() {
  local key=$1 value=$2
  if (( ${#__alev_runtime_version_cache} >= _ALEV_VERSION_CACHE_MAX_ENTRIES )); then
    __alev_runtime_version_cache=()
    __alev_runtime_version_cache_timestamps=()
  fi
  __alev_clock_epoch_seconds
  __alev_runtime_version_cache[$key]=$value; __alev_runtime_version_cache_timestamps[$key]=$REPLY
}

# Apply a runtime result to the active context and its cache.
__alev_runtime_apply_result() {
  __alev_runtime_version_records=$1
  __alev_runtime_cached_context_signature=$__alev_runtime_context_signature
  __alev_runtime_store_cache_entry "$__alev_runtime_cached_context_signature" "$1"
}

# Unregister and close a worker descriptor without changing shell stderr.
__alev_worker_close_fd() {
  local -i fd=$1
  (( fd >= 0 )) || return 0
  zle -F "$fd" 2>/dev/null || true
  # exec without a command changes descriptors in the parent shell.
  # Never redirect stderr here: it would silence user commands and plugins.
  exec {fd}<&- || true
}

# Close all pending background worker descriptors.
__alev_worker_cancel_all() {
  __alev_worker_close_fd $__alev_git_worker_fd
  __alev_git_worker_fd=-1
  __alev_worker_close_fd $__alev_runtime_worker_fd
  __alev_runtime_worker_fd=-1
  __alev_worker_close_fd ${__alev_terminal_capability_worker_fd:--1}
  __alev_terminal_capability_worker_fd=-1
}

# Apply a current Git worker result and redraw the prompt.
__alev_git_worker_ready() {
  local -i fd=$1
  local line='' old=$__alev_git_status_record
  if IFS= read -r -u "$fd" line && [[ $__alev_git_worker_context_key == $__alev_git_context_key ]]; then
    __alev_git_status_record=$line
  fi
  __alev_worker_close_fd "$fd"
  __alev_git_worker_fd=-1
  if [[ $old != "$__alev_git_status_record" ]]; then
    __alev_zle_try_redraw
  fi
  return 0
}

# Apply and cache a current runtime worker result, then redraw.
__alev_runtime_worker_ready() {
  local -i fd=$1
  local line='' old=$__alev_runtime_version_records
  if IFS= read -r -u "$fd" line && [[ $__alev_runtime_worker_context_signature == $__alev_runtime_context_signature ]]; then
    __alev_runtime_apply_result "$line"
  fi
  __alev_worker_close_fd "$fd"
  __alev_runtime_worker_fd=-1
  if [[ $old != "$__alev_runtime_version_records" ]]; then
    __alev_zle_try_redraw
  fi
  return 0
}

# Refresh Git and language state with caching and optional background workers.
__alev_prompt_refresh_context() {
  emulate -L zsh
  local old_key=$__alev_git_context_key cached_time now
  __alev_git_context_key="$PWD|${GIT_DIR:-}|${GIT_WORK_TREE:-}|${GIT_INDEX_FILE:-}"
  if [[ $__alev_git_context_key != $old_key ]]; then
    __alev_worker_close_fd $__alev_git_worker_fd
    __alev_git_worker_fd=-1
    __alev_git_status_record=''
  fi
  if [[ $_ALEV_GIT_ENABLED != true ]]; then
    __alev_worker_close_fd $__alev_git_worker_fd
    __alev_git_worker_fd=-1
    __alev_git_status_record=''
  fi
  if __alev_runtime_any_project_enabled; then
    __alev_runtime_build_context_signature
    __alev_runtime_context_signature=$REPLY
  else
    __alev_runtime_context_signature=''; __alev_runtime_version_records=''; __alev_runtime_cached_context_signature=''
    __alev_worker_close_fd $__alev_runtime_worker_fd
    __alev_runtime_worker_fd=-1
  fi
  local need_lang=false
  if [[ -n $__alev_runtime_context_signature ]]; then
    if [[ $__alev_runtime_context_signature != $__alev_runtime_worker_context_signature ]]; then
      __alev_worker_close_fd $__alev_runtime_worker_fd
      __alev_runtime_worker_fd=-1
    fi
    if [[ $__alev_runtime_context_signature != $__alev_runtime_cached_context_signature ]]; then
      __alev_runtime_version_records=''
    fi
    if (( ${+__alev_runtime_version_cache[$__alev_runtime_context_signature]} )); then
      __alev_runtime_version_records=${__alev_runtime_version_cache[$__alev_runtime_context_signature]}
      __alev_runtime_cached_context_signature=$__alev_runtime_context_signature
    fi
    cached_time=${__alev_runtime_version_cache_timestamps[$__alev_runtime_context_signature]:-0}; __alev_clock_epoch_seconds
    now=$REPLY
    need_lang=true
    if (( ${+__alev_runtime_version_cache[$__alev_runtime_context_signature]} )) && (( now >= cached_time && now-cached_time < _ALEV_VERSION_CACHE_TTL_SECONDS )); then
      need_lang=false
    fi
  fi
  if (( __alev_zle_active )) && [[ $_ALEV_ZLE_INTEGRATION == true && $_ALEV_ASYNC == true && -o interactive ]]; then
    if [[ $_ALEV_GIT_ENABLED == true ]] && (( __alev_git_worker_fd < 0 )); then
      __alev_git_worker_context_key=$__alev_git_context_key
      exec {__alev_git_worker_fd}< <(__alev_git_query_status 2>/dev/null)
      if ! zle -F -w "$__alev_git_worker_fd" __alev_git_worker_ready 2>/dev/null; then
        __alev_worker_close_fd $__alev_git_worker_fd
        __alev_git_worker_fd=-1
        __alev_git_status_record=$(__alev_git_query_status)
      fi
    fi
    if [[ $need_lang == true ]] && (( __alev_runtime_worker_fd < 0 )); then
      __alev_runtime_worker_context_signature=$__alev_runtime_context_signature
      exec {__alev_runtime_worker_fd}< <(__alev_runtime_query_versions 2>/dev/null)
      if ! zle -F -w "$__alev_runtime_worker_fd" __alev_runtime_worker_ready 2>/dev/null; then
        __alev_worker_close_fd $__alev_runtime_worker_fd
        __alev_runtime_worker_fd=-1
        __alev_runtime_apply_result "$(__alev_runtime_query_versions)"
      fi
    fi
  else
    if [[ $_ALEV_GIT_ENABLED == true ]]; then
      __alev_git_status_record=$(__alev_git_query_status)
    fi
    if [[ $need_lang == true ]]; then
      __alev_runtime_apply_result "$(__alev_runtime_query_versions)"
    fi
  fi
  return 0
}

# ---------------- Prompt rendering ----------------

# Render active virtualenv and Conda environments.
__alev_python_render_environment_segment() {
  emulate -L zsh
  setopt extendedglob
  [[ $_ALEV_LANGUAGES_ENABLED == true ]] || { REPLY=''; return 0; }
  local conda_environment_name='' python_virtualenv_name='' python_environment_symbol python_environment_segment='' python_virtualenv_parent='' separator
  __alev_icon_get_symbol PYTHON
  python_environment_symbol=$REPLY
  if (( $# >= 3 )); then
    [[ $_ALEV_PYTHON_ENABLED == true ]] && python_virtualenv_name=$1
    [[ $_ALEV_CONDA_ENABLED == true ]] && conda_environment_name=$2
    [[ $_ALEV_CONDA_SHOW_BASE != true && $conda_environment_name == base ]] && conda_environment_name=''
  else
    if [[ $_ALEV_CONDA_ENABLED == true && -n ${CONDA_PREFIX:-} ]]; then
      conda_environment_name=${CONDA_DEFAULT_ENV:-${CONDA_PREFIX:t}}
      [[ $conda_environment_name == /* ]] && conda_environment_name=${conda_environment_name:t}
      [[ $_ALEV_CONDA_SHOW_BASE != true && $conda_environment_name == base ]] && conda_environment_name=''
    fi
    if [[ $_ALEV_PYTHON_ENABLED == true && -n ${VIRTUAL_ENV:-} ]]; then
      if [[ -f $VIRTUAL_ENV/__name__ && -r $VIRTUAL_ENV/__name__ ]]; then
        IFS= read -r python_virtualenv_name < "$VIRTUAL_ENV/__name__" || true
      fi
      if [[ -z $python_virtualenv_name ]]; then
        python_virtualenv_name=${VIRTUAL_ENV:t}; [[ $python_virtualenv_name == __ ]] && { python_virtualenv_parent=${VIRTUAL_ENV:h}; python_virtualenv_name=${python_virtualenv_parent:t}; }
      fi
    fi
  fi
  if [[ -n $conda_environment_name ]]; then
    __alev_color_render_role CONDA "$python_environment_symbol $conda_environment_name"
    python_environment_segment=$REPLY
    if [[ -n $python_virtualenv_name ]]; then
      # Parentheses only when pyvenv.cfg identifies a Conda-based interpreter.
      local line k v home='' executable='' python_virtualenv_is_nested=false conda_prefix_path
      if (( $# >= 3 )); then
        python_virtualenv_is_nested=$3
      elif [[ -r $VIRTUAL_ENV/pyvenv.cfg ]]; then
        conda_prefix_path=${CONDA_PREFIX:A}
        while IFS= read -r line; do
          k=${line%%=*}
          k=${k//[[:space:]]/}
          v=${line#*=}
          v=${v##[[:space:]]#}
          v=${v%%[[:space:]]#}
          # Trim without requiring extendedglob for the simple common format.
          v=${v# }
          v=${v% }
          case $k in home) home=$v ;; executable) executable=$v ;; esac
        done < "$VIRTUAL_ENV/pyvenv.cfg"
        [[ -n $home && ( ${home:A} == "$conda_prefix_path" || ${home:A} == "$conda_prefix_path"/* ) ]] && python_virtualenv_is_nested=true
        [[ -n $executable && ( ${executable:A} == "$conda_prefix_path" || ${executable:A} == "$conda_prefix_path"/* ) ]] && python_virtualenv_is_nested=true
      fi
      if [[ $python_virtualenv_is_nested == true ]]; then
        __alev_color_render_role PYTHON_VIRTUALENV "($python_virtualenv_name)"; python_environment_segment+=" $REPLY"
      else
        # Simultaneously set variables do not prove nesting.
        __alev_icon_get_symbol SEPARATOR
        __alev_color_render_role SEPARATOR "$REPLY"; separator=" $REPLY "
        __alev_color_render_role PYTHON "$python_environment_symbol"; python_environment_segment+="${separator}${REPLY}"
        __alev_color_render_role PYTHON_VIRTUALENV "$python_virtualenv_name"; python_environment_segment+=" $REPLY"
      fi
    fi
  elif [[ -n $python_virtualenv_name ]]; then
    __alev_color_render_role PYTHON "$python_environment_symbol"; python_environment_segment=$REPLY; __alev_color_render_role PYTHON_VIRTUALENV "$python_virtualenv_name"; python_environment_segment+=" $REPLY"
  fi
  REPLY=$python_environment_segment
}

# Measure terminal width using Zsh and the PTY when available.
__alev_terminal_columns() {
  emulate -L zsh
  local -i cols=${COLUMNS:-0}
  local size tty_cols
  if [[ $_ALEV_WIDTH_CHECK_TTY == true && -o interactive && -n ${TTY:-} && -t 1 ]] && (( $+commands[stty] )); then
    size=$(command stty size 2>/dev/null < "$TTY") || size=''
    tty_cols=${size##* }
    if [[ $tty_cols == <-> ]] && (( tty_cols > 0 && (cols <= 0 || tty_cols < cols) )); then
      cols=$tty_cols
    fi
  fi
  REPLY=$cols
}

# Deduct the configured safety margin from terminal width.
__alev_terminal_width_budget() {
  local -i cols=$1 margin=2
  [[ $_ALEV_WIDTH_MARGIN == <-> ]] && margin=$_ALEV_WIDTH_MARGIN
  if (( cols <= 0 )); then
    REPLY=0
  elif (( cols <= margin )); then
    REPLY=1
  else
    REPLY=$((cols-margin))
  fi
}

# Measure visible prompt cells without counting formatting escapes.
__alev_prompt_visible_width() {
  emulate -L zsh
  setopt multibyte
  local s=$1 plain='' chunk end='%}'
  while [[ $s == *%* ]]; do
    chunk=${s%%\%*}
    plain+=$chunk
    s=${s#"$chunk"}
    case $s in
      ('%%'*) plain+='%'; s=${s[3,-1]} ;;
      ('%{'*'%}'*) s=${s#*"$end"} ;;
      ('%B'*|'%b'*) s=${s[3,-1]} ;;
      (*) plain+='%'; s=${s[2,-1]} ;;
    esac
  done
  plain+=$s
  REPLY=${(m)#plain}
}

# Choose the omission marker, including ASCII spacing.
__alev_path_select_omission_marker() {
  case $__alev_icon_mode in
    nf) REPLY=$__ALEV_PATH_ELLIPSIS_NF ;;
    unicode) REPLY=$__ALEV_PATH_ELLIPSIS_UNICODE ;;
    *) REPLY=" $__ALEV_PATH_ELLIPSIS_ASCII " ;;
  esac
}

# Omit a minimal contiguous path span while preserving root and final directory.
__alev_path_shorten() {
  emulate -L zsh
  setopt multibyte
  local original=$1 body root_prefix piece clean marker
  local -i budget=$2 full n k i j w balance left right marker_w
  local -i best_i=0 best_j=0 best_w=0 best_balance=2147483647
  local -i short_i=0 short_j=0 short_w short_balance=2147483647
  local -a parts sums
  REPLY=$original
  __alev_path_visible_prefix=$original; __alev_path_omission_marker=''; __alev_path_visible_suffix=''
  clean=${original//[[:cntrl:]]/?}
  full=${(m)#clean}
  (( full > budget )) || return 0
  case $original in
    ('~/'*) root_prefix='~/'; body=${original#\~/} ;;
    (/*) root_prefix='/'; body=${original#/} ;;
    (*) return 0 ;;
  esac
  [[ -n $body ]] || return 0
  parts=( "${(@s:/:)body}" )
  n=${#parts}
  (( n > 1 )) || return 0
  __alev_path_select_omission_marker
  marker=$REPLY
  marker_w=${(m)#marker}
  REPLY=$original
  sums=(0)
  for piece in "${parts[@]}"; do
    clean=${piece//[[:cntrl:]]/?}
    sums+=( "$(( sums[-1] + ${(m)#clean} ))" )
  done
  short_w=$full
  for (( k=1; k<n; ++k )); do
    best_i=0
    best_balance=2147483647
    best_w=0
    for (( i=1; i<=n-k; ++i )); do
      j=$((i+k-1))
      w=$(( full - (sums[j+1]-sums[i]) - (k-1) + marker_w ))
      (( w < full )) || continue
      left=$((i-1))
      right=$((n-j))
      balance=$((left-right))
      (( balance < 0 )) && balance=$((-balance))
      if (( w < short_w )); then
        short_i=$i
        short_j=$j
        short_w=$w
        short_balance=$balance
      elif (( w == short_w && short_i > 0 && k == short_j-short_i+1 && balance < short_balance )); then
        short_i=$i
        short_j=$j
        short_balance=$balance
      fi
      if (( w <= budget )); then
        if (( best_i == 0 || balance < best_balance || (balance == best_balance && w > best_w) )); then
          best_i=$i
          best_j=$j
          best_w=$w
          best_balance=$balance
        fi
      fi
    done
    (( best_i > 0 )) && break
  done
  if (( best_i == 0 )); then
    best_i=$short_i
    best_j=$short_j
  fi
  (( best_i > 0 )) || return 0
  __alev_path_visible_prefix=$root_prefix
  for (( i=1; i<best_i; ++i )); do
    (( i > 1 )) && __alev_path_visible_prefix+='/'
    __alev_path_visible_prefix+=${parts[i]}
  done
  __alev_path_omission_marker=$marker
  __alev_path_visible_suffix=''
  (( best_i > 1 )) && __alev_path_visible_prefix+='/'
  __alev_path_visible_suffix='/'
  for (( i=best_j+1; i<=n; ++i )); do
    (( i > best_j+1 )) && __alev_path_visible_suffix+='/'
    __alev_path_visible_suffix+=${parts[i]}
  done
  REPLY="${__alev_path_visible_prefix}${__alev_path_omission_marker}${__alev_path_visible_suffix}"
  return 0
}

# Render a shortened path with a distinct omission-marker color.
__alev_path_render_shortened() {
  local result
  if [[ -z $__alev_path_omission_marker ]]; then
    __alev_color_render_role PATH "$__alev_path_visible_prefix" true
    return
  fi
  __alev_color_render_role PATH "$__alev_path_visible_prefix" true
  result=$REPLY
  __alev_color_render_role PATH_ELLIPSIS "$__alev_path_omission_marker" true
  result+=$REPLY
  __alev_color_render_role PATH "$__alev_path_visible_suffix" true; REPLY="${result}${REPLY}"
}

# Interpolate RGB tree colors between the first and final prompt rows.
__alev_tree_render_gradient() {
  emulate -L zsh
  local value=$1 from=${2#\#} to=${3#\#} mixed
  local -i step=$4 steps=$5 i a b channel
  if [[ ${#from} != 6 || ${#to} != 6 || $from == *[^[:xdigit:]]* || $to == *[^[:xdigit:]]* ]] || (( steps <= 0 )); then
    __alev_color_render_role TREE "$value"
    return 0
  fi
  (( step < 0 )) && step=0
  (( step > steps )) && step=steps
  local -a channels
  for i in 1 3 5; do
    a=$((16#${from[i,i+1]}))
    b=$((16#${to[i,i+1]}))
    channel=$(( (a*(steps-step) + b*step + steps/2) / steps ))
    channels+=("$channel")
  done
  printf -v mixed '#%02X%02X%02X' "${channels[@]}"
  __alev_color_render_text "$value" "$mixed" auto
}

# Choose the privileged input symbol, including the root Git variant.
__alev_git_select_root_input_symbol() {
  local git_snapshot=$1 corner=$2 dash=$3 rootdash=$4
  if [[ $_ALEV_GIT_ENABLED == true && $_ALEV_GIT_ROOT_ICON_ENABLED == true && $_ALEV_GIT_SHOW_INPUT_ICON == true && $git_snapshot == 1* ]]; then
    __alev_icon_get_symbol GIT_ROOT
    REPLY="${corner}${dash}${REPLY}"
  else
    __alev_icon_get_symbol ROOT
    REPLY="${corner}${rootdash}${REPLY}"
  fi
}

# Identify root by effective UID, independently of the displayed username or glyph coverage.
__alev_is_root() {
  (( EUID == 0 ))
}

# Assemble the responsive multiline prompt from context and runtime segments.
__alev_prompt_render() {
  emulate -L zsh
  local user_name=${USERNAME:-${USER:-?}} host_name=${SHORT_HOST:-$HOST} custom path_text tree user_seg host_seg path_seg
  local bottom context first second='' sep id item version symbol key prefix label
  local -i sep_width first_using_width continuation_width
  local is_root=false
  __alev_is_root && is_root=true
  local corner_hex=$_ALEV_FOLDER_CORNER_COLOR ssh=false line_text=''
  local -i row=0 total=0
  local -a using_lines
  local -a segments entries
  local top middle corner dash rootdash vertical dot
  __alev_icon_get_symbol TREE_TOP; top=$REPLY
  __alev_icon_get_symbol TREE_MIDDLE; middle=$REPLY
  __alev_icon_get_symbol TREE_CORNER; corner=$REPLY
  __alev_icon_get_symbol TREE_DASH; dash=$REPLY
  __alev_icon_get_symbol TREE_ROOT_DASH; rootdash=$REPLY
  __alev_icon_get_symbol TREE_VERTICAL; vertical=$REPLY
  __alev_icon_get_symbol SEPARATOR; dot=$REPLY
  __alev_color_render_role SEPARATOR "$dot"; sep=" $REPLY "
  __alev_prompt_visible_width "$sep"; sep_width=$REPLY
  first_using_width=$(( ${(m)#middle} + 7 ))
  continuation_width=$(( ${(m)#vertical} + 9 ))
  if [[ $_ALEV_USE_BOX_NAME == true && -r $HOME/.box-name && -f $HOME/.box-name ]]; then
    IFS= read -r custom < "$HOME/.box-name" || true; [[ -n $custom ]] && host_name=$custom
  fi
  path_text=$PWD
  if [[ $PWD == "$HOME" ]]; then
    path_text='~'
  elif [[ $PWD == "$HOME"/* && $HOME != / ]]; then
    path_text="~${PWD#$HOME}"
  fi
  if [[ $_ALEV_SSH_ENABLED == true && ( -n ${SSH_CONNECTION:-} || -n ${SSH_CLIENT:-} || -n ${SSH_TTY:-} ) ]]; then
    ssh=true
  fi
  # Optional preview context: display path, username, root, SSH, venv, Conda, nesting.
  if (( $# >= 7 )); then
    [[ -n $1 ]] && path_text=$1
    user_name=$2
    is_root=$3
    ssh=$4
  fi
  if [[ $is_root == true ]]; then
    corner_hex=$_ALEV_ROOT_USER_COLOR
    __alev_color_render_role ROOT_USER "$top"
    tree=$REPLY
    __alev_color_render_role ROOT_USER "$user_name" true
    user_seg=$REPLY
    __alev_color_render_role ROOT_HOST "$host_name" true
    host_seg=$REPLY
    __alev_git_select_root_input_symbol "$__alev_git_status_record" "$corner" "$dash" "$rootdash"
    __alev_color_render_role ROOT_USER "$REPLY"
    bottom=$REPLY
  else
    __alev_color_render_role TREE "$top"
    tree=$REPLY
    __alev_color_render_role USER "$user_name" true
    user_seg=$REPLY
    __alev_color_render_role HOST "$host_name" true
    host_seg=$REPLY
    if [[ $ssh == true ]]; then
      corner_hex=$_ALEV_SSH_CORNER_COLOR
      __alev_icon_get_symbol SSH
      context=$REPLY
      __alev_color_render_role SSH_CORNER "$corner"
      bottom=$REPLY
      __alev_color_render_role SSH_DASH "$dash"
      bottom+=$REPLY
      __alev_color_render_role SSH "$context"
      bottom+=$REPLY
    elif [[ $_ALEV_GIT_ENABLED == true && $_ALEV_GIT_SHOW_INPUT_ICON == true && $__alev_git_status_record == 1* ]]; then
      corner_hex=$_ALEV_GIT_CORNER_COLOR
      __alev_icon_get_symbol GIT
      context=$REPLY
      __alev_color_render_role GIT_CORNER "$corner"
      bottom=$REPLY
      __alev_color_render_role GIT_DASH "$dash"
      bottom+=$REPLY
      __alev_color_render_role GIT_ICON "$context"
      bottom+=$REPLY
    else
      __alev_color_render_role FOLDER_CORNER "$corner"
      bottom=$REPLY
      __alev_color_render_role FOLDER_DASH "$dash"
      bottom+=$REPLY
      if [[ $path_text == "~" ]]; then
        __alev_icon_get_symbol HOME
        context=$REPLY
        if [[ $__alev_icon_mode == unicode ]]; then
          __alev_color_render_role HOME_UNICODE_ICON "$context"
        else
          __alev_color_render_role HOME_ICON "$context"
        fi
      else
        __alev_icon_get_symbol FOLDER
        context=$REPLY
        __alev_color_render_role FOLDER_ICON "$context"
      fi
      bottom+=$REPLY
    fi
  fi
  # Assemble the first line from independent segments before printing.
  # Timing segments are expendable; the user, host, Git status and root SSH notice are not.
  local first_prefix="$tree" identity=''
  if [[ $_ALEV_SHOW_USER == true ]]; then
    identity=$user_seg
  fi
  if [[ $_ALEV_SHOW_HOST == true ]]; then
    if [[ -n $identity ]]; then
      __alev_color_render_role TEXT " at "; identity+=$REPLY
    fi
    identity+=$host_seg
  fi
  if [[ $_ALEV_SHOW_PATH == true && -n $identity ]]; then
    __alev_color_render_role TEXT " in "; identity+=$REPLY
  fi
  first_prefix+=$identity
  local git_seg='' uptime_seg='' time_seg='' ssh_seg='' uptime_value
  local -i columns=0 budget=0 path_budget
  __alev_terminal_columns
  columns=$REPLY
  __alev_terminal_width_budget "$columns"
  budget=$REPLY
  if [[ $_ALEV_GIT_ENABLED == true && $_ALEV_GIT_SHOW_STATUS == true && $__alev_git_status_record == 1* ]]; then
    __alev_git_render_status "$__alev_git_status_record"
    git_seg=${REPLY#1}
  fi
  if [[ $_ALEV_UPTIME_ENABLED == true ]]; then
    if (( $# >= 8 )); then
      uptime_value=$8
    elif __alev_uptime_seconds; then
      uptime_value=$REPLY
    fi
    if __alev_uptime_format "$uptime_value"; then
      __alev_color_render_role UPTIME "$REPLY" false
      label=$REPLY
      __alev_icon_get_symbol UPTIME
      __alev_color_render_role TEXT " $REPLY" false
      uptime_seg="${sep}${label}${REPLY}"
    fi
  fi
  if [[ $_ALEV_COMMAND_TIME_ENABLED == true && $_ALEV_COMMAND_TIME_COUNT == true ]]; then
    __alev_command_render_duration
    label=$REPLY
    __alev_color_render_role TEXT "took "
    time_seg="${sep}${REPLY}${label}"
  fi
  if [[ $is_root == true && $ssh == true ]]; then
    __alev_color_render_role SSH SSH
    label=$REPLY
    __alev_color_render_role TEXT "over "
    ssh_seg="${sep}${REPLY}${label}"
  fi
  path_seg=''
  if [[ $_ALEV_SHOW_PATH == true ]]; then
    __alev_color_render_role PATH "$path_text" true
    path_seg=$REPLY
  fi
  # Clear any shortened-path metadata from a previous render.
  __alev_path_visible_prefix=$path_text; __alev_path_omission_marker=''; __alev_path_visible_suffix=''
  first="${first_prefix}${path_seg}${git_seg}${uptime_seg}${time_seg}${ssh_seg}"
  if (( budget > 0 )); then
    __alev_prompt_visible_width "$first"
    if (( REPLY > budget )); then
      first="${first_prefix}${path_seg}${git_seg}${uptime_seg}${ssh_seg}"
      __alev_prompt_visible_width "$first"
      if (( REPLY > budget )); then
        first="${first_prefix}${path_seg}${git_seg}${ssh_seg}"
        __alev_prompt_visible_width "$first"
      fi
      if [[ $_ALEV_SHOW_PATH == true && $_ALEV_PATH_SHORTEN_ENABLED == true ]] && (( REPLY > budget )); then
        __alev_prompt_visible_width "${first_prefix}${git_seg}${ssh_seg}"
        path_budget=$((budget-REPLY))
        __alev_path_shorten "$path_text" "$path_budget"
        __alev_path_render_shortened
        path_seg=$REPLY
        first="${first_prefix}${path_seg}${git_seg}${ssh_seg}"
      fi
    fi
  fi
  if (( $# >= 7 )); then
    __alev_python_render_environment_segment "$5" "$6" "$7"
  else
    __alev_python_render_environment_segment
  fi
  [[ -n $REPLY ]] && segments+=("$REPLY")
  # Worker delimiter is a literal pipe, not an eval-able data structure.
  entries=( "${(@s:|:)__alev_runtime_version_records}" )
  for item in "${entries[@]}"; do
    id=${item%%=*}
    version=${item#*=}
    [[ -n $id && -n $version && $id != $item && $_ALEV_LANGUAGES_ENABLED == true ]] || continue
    key="_ALEV_${id}_ENABLED"; [[ ${(P)key} == true ]] || continue
    __alev_icon_get_symbol "$id"
    symbol=$REPLY
    [[ -n $symbol ]] || continue
    if [[ $version == unknown ]]; then
      # Use the textual symbol as the language label when a version is unavailable.
      local runtime_label
      __alev_icon_get_symbol "$id" ascii
      runtime_label=$REPLY
      [[ -z $runtime_label || $symbol == "$runtime_label" ]] || symbol+=" $runtime_label"
      __alev_color_render_role "$id" "$symbol"
    else
      if [[ $id != DOTNET && $version != LuaJIT* ]]; then
        version="v$version"
      fi
      if [[ $id == LUA && $symbol == Lua && $version == LuaJIT* ]]; then
        __alev_color_render_role "$id" "$version"
      else
        __alev_color_render_role "$id" "$symbol $version"
      fi
    fi
    segments+=("$REPLY")
  done
  if (( ${#segments} )); then
    # Pack segments first, so the gradient spans every physical using row.
    local -i used=$first_using_width n=0 width=0
    for item in "${segments[@]}"; do
      __alev_prompt_visible_width "$item"
      width=$REPLY
      if (( n )); then
        if [[ $_ALEV_WRAP_USING == true ]] && (( budget > 0 && used+sep_width+width > budget )); then
          using_lines+=("$line_text")
          line_text=$item
          used=$((continuation_width+width))
        else
          line_text+="${sep}${item}"
          used=$((used+sep_width+width))
        fi
      else
        line_text=$item
        used=$((used+width))
      fi
      (( ++n ))
    done
    using_lines+=("$line_text")
    total=$(( ${#using_lines} + 1 ))
    for item in "${using_lines[@]}"; do
      (( ++row ))
      if (( row == 1 )); then
        context=$middle
        __alev_color_render_role TEXT " using "; prefix=$REPLY
      else
        context=$vertical
        prefix='         '
      fi
      if [[ $is_root == true ]]; then
        __alev_color_render_role ROOT_USER "$context"
      elif [[ $__alev_color_depth == truecolor && $_ALEV_TREE_GRADIENT_ENABLED == true ]]; then
        __alev_tree_render_gradient "$context" "$_ALEV_TREE_COLOR" "$corner_hex" "$row" "$total"
      else
        # Keep the established ANSI palette and fallback behavior.
        __alev_color_render_role TREE "$context"
      fi
      second+="${REPLY}${prefix}${item}"$'\n'
    done
  fi
  __alev_icon_get_symbol CONTINUATION
  __alev_color_render_role CONTINUATION "$REPLY"
  PS2="$REPLY "
  __alev_prompt_rendered_text="${first}"$'\n'"${second}${bottom} "
  __alev_prompt_render_columns=${COLUMNS:-0}
  return 0
}

# Permit redraws only on empty primary lines with no completion, search or queued input.
__alev_zle_redraw_allowed() {
  [[ $_ALEV_LIVE_REDRAW == true && -z $1 && $2 == start ]] || return 1
  case $3 in
    main|emacs|viins|vicmd) ;;
    *) return 1 ;;
  esac
  case $4 in
    *complet*|*menu*|*history*|*search*|*predict*) return 1 ;;
  esac
  [[ ${5:-0} == 0 && ${6:-0} == 0 && ${7:-0} == 0 ]]
}

# Keep worker results but defer unsafe visual updates until the next precmd.
__alev_zle_try_redraw() {
  (( __alev_zle_active )) && [[ $_ALEV_ZLE_INTEGRATION == true ]] || return 0
  [[ -n ${CONTEXT:-} ]] || return 0
  __alev_zle_redraw_allowed "${BUFFER-}" "$CONTEXT" "${KEYMAP-}" "${LASTWIDGET-}" \
    "${PENDING:-0}" "${KEYS_QUEUED_COUNT:-0}" "${ZLE_RECURSIVE:-0}" || return 0
  __alev_prompt_render
  zle reset-prompt 2>/dev/null || true
  # FD widgets require explicit redisplay; the pre-redraw hook is already redrawing.
  if [[ ${1:-worker} != resize ]]; then
    zle -R 2>/dev/null || true
  fi
  return 0
}

# Reflow on resize only when doing so cannot interrupt an active edit.
__alev_zle_resize_redraw() {
  (( COLUMNS != __alev_prompt_render_columns )) || return 0
  __alev_zle_try_redraw resize
  return 0
}

# ---------------- Optional stderr presentation ----------------
# Explicit wrapping is scoped to one command; optional automatic mode restores fd 2 before the prompt.

# Resolve stderr through the same five-depth role palette as the prompt.
__alev_stderr_sgr() {
  emulate -L zsh
  local hex ansi
  __alev_color_resolve_role STDERR
  __alev_color_foreground_sgr "$hex" "$ansi"
}

# Color stderr text lines without adding a missing final newline.
__alev_stderr_filter() {
  emulate -L zsh
  local prefix=$1 line
  while true; do
    if IFS= read -r line; then
      printf '%s%s\033[39m\n' "$prefix" "$line"
    else
      [[ -n $line ]] && printf '%s%s\033[39m' "$prefix" "$line"
      break
    fi
  done
  return 0
}

# Print an error to stderr and return its optional status (default 1), or run a wrapped command.
_alev_stderr() {
  emulate -L zsh
  local REPLY prefix code
  local -i exit_code=1
  if [[ ${1-} == --run ]]; then
    shift
    __alev_stderr_run "$@"
    return $?
  fi
  if [[ ${1-} == <-> ]]; then
    code=$1
    shift
    # Normalize leading zeroes before decimal conversion; reject oversized values.
    while [[ $code == 0?* ]]; do code=${code#0}; done
    if (( ${#code} > 3 )) || (( 10#$code > 255 )); then
      builtin print -u2 -r -- 'Invalid exit code: expected an integer from 0 to 255.'
      return 2
    fi
    exit_code=$(( 10#$code ))
  elif [[ ${1-} == -<-> ]]; then
    builtin print -u2 -r -- 'Invalid exit code: expected an integer from 0 to 255.'
    return 2
  fi
  [[ ${1-} == -- ]] && shift
  (( $# )) || { builtin print -u2 -r -- 'Usage: _alev_stderr [exit_code] [--] message... | --run command [args...]'; return 2; }
  if [[ -t 2 ]]; then
    __alev_stderr_sgr
    prefix=$REPLY
  fi
  if [[ -n $prefix ]]; then
    builtin printf '%s\n' "$*" | __alev_stderr_filter "$prefix" >&2
  else
    builtin print -u2 -r -- "$*"
  fi
  return "$exit_code"
}

# Run a command with opt-in stderr coloring and preserve its actual status.
__alev_stderr_run() {
  emulate -L zsh
  local REPLY prefix
  local -a results
  (( $# )) || { print -u2 -r -- 'Usage: _alev_stderr --run command [args...]'; return 2; }
  __alev_stderr_sgr
  prefix=$REPLY
  if [[ ! -t 2 || -z $prefix ]]; then
    "$@"
    return $?
  fi
  # Wait for the filter via a pipeline; preserve the wrapped command status.
  # FD 3 is scoped to this group, and stdout bypasses the filter.
  {
    { "$@" 2>&1 1>&3 3>&-; } | __alev_stderr_filter "$prefix" >&2
    results=( "${pipestatus[@]}" )
  } 3>&1
  return "${results[1]}"
}

# Restore the shell's original stderr and release its saved descriptor.
__alev_stderr_restore() {
  (( __alev_stderr_saved_fd >= 0 )) || return 0
  # Never attach a diagnostic redirection to a bare exec: it would persist.
  exec 2>&${__alev_stderr_saved_fd} || return 1
  exec {__alev_stderr_saved_fd}>&- || return 1
  __alev_stderr_saved_fd=-1
  return 0
}

# Optionally route terminal-bound stderr through a text filter for one editing cycle.
__alev_stderr_start() {
  [[ $_ALEV_STDERR_AUTO_ENABLED == true && -o interactive && -t 2 ]] || return 0
  (( __alev_stderr_saved_fd < 0 )) || return 0
  local REPLY prefix
  __alev_stderr_sgr
  prefix=$REPLY
  [[ -n $prefix ]] || return 0
  exec {__alev_stderr_saved_fd}>&2 || { __alev_stderr_saved_fd=-1; return 1; }
  if ! exec 2> >(__alev_stderr_filter "$prefix" >&${__alev_stderr_saved_fd}); then
    __alev_stderr_restore
    return 1
  fi
  return 0
}

# ---------------- Command lifecycle ----------------

# Record command start state and suspend capability polling.
__alev_zsh_preexec() {
  if [[ $_ALEV_COMMAND_TIME_COUNT == true ]]; then
    __alev_command_started_at=${EPOCHREALTIME:-${EPOCHSECONDS:-0}}
  else
    __alev_command_started_at=0
  fi
  __alev_command_was_executed=1
  __alev_worker_close_fd $__alev_terminal_capability_worker_fd
  __alev_terminal_capability_worker_fd=-1
  __alev_stderr_start
  return 0
}

# Emit the configured number of empty lines without horizontal padding.
__alev_prompt_print_blank_lines() {
  local -i i count=$1
  for (( i=0; i<count; ++i )); do print -r -- ''; done
  return 0
}

# Display a nonzero exit code or inferred signal with configured spacing.
__alev_command_print_exit_notice() {
  emulate -L zsh
  local -i code=$1 sig
  local message="EXIT CODE $code" name=''
  if [[ $_ALEV_EXIT_DECODE_SIGNALS == true ]] && (( code > 128 )); then
    sig=$((code-128))
    # Zsh's signal names are platform-specific; exclude numeric/unknown replies.
    name=$(builtin kill -l "$sig" 2>/dev/null) || name=''
    name=${name#SIG}
    if [[ $name == [A-Z]* && $name != *[[:space:]]* && $name != *[^A-Z0-9+-]* ]]; then
      message="EXIT SIG$name"
    fi
  fi
  __alev_prompt_print_blank_lines "$_ALEV_EXIT_PADDING_BEFORE"
  local open close
  __alev_icon_get_symbol EXIT_OPEN; open=$REPLY
  __alev_icon_get_symbol EXIT_CLOSE; close=$REPLY
  __alev_color_render_role EXIT "${open}${message}${close}" true
  print -P -r -- "$REPLY"
  __alev_prompt_print_blank_lines "$_ALEV_EXIT_PADDING_AFTER"
  return 0
}

# Capture command status, refresh state and render the next prompt.
__alev_zsh_precmd() {
  # Must be captured BEFORE emulate, local assignments that run commands, etc.
  local -i last_exit=$?
  local -F finished=${EPOCHREALTIME:-${EPOCHSECONDS:-0}}
  __alev_stderr_restore
  emulate -L zsh
  if (( __alev_command_was_executed )); then
    if [[ $_ALEV_COMMAND_TIME_COUNT == true ]] && (( __alev_command_started_at > 0 )); then
      __alev_command_elapsed_seconds=$(( finished-__alev_command_started_at )); (( __alev_command_elapsed_seconds < 0 )) && __alev_command_elapsed_seconds=0
    else
      __alev_command_elapsed_seconds=0
    fi
    __alev_command_was_executed=0
    if (( last_exit != 0 )) && [[ $_ALEV_EXIT_NOTIFICATION_ENABLED == true ]]; then
      __alev_command_print_exit_notice "$last_exit"
    else
      __alev_prompt_print_blank_lines "$_ALEV_PROMPT_PADDING"
    fi
    # Refresh Git after every executed command; never reuse a running old query.
    __alev_worker_close_fd $__alev_git_worker_fd
    __alev_git_worker_fd=-1
  elif (( __alev_prompt_has_been_shown )); then
    # Enter on empty buffer or Ctrl+C in ZLE: no error, keep previous time.
    __alev_prompt_print_blank_lines "$_ALEV_PROMPT_PADDING"
  fi
  __alev_prompt_has_been_shown=1
  __alev_terminal_refresh_capabilities
  __alev_prompt_refresh_context
  __alev_prompt_render
  PROMPT='${__alev_prompt_rendered_text}'
  RPROMPT=''; RPS2=''
  return 0
}

# ---------------- Public utilities ----------------

# Install help as a session-local alias without overriding an existing help command.
_alev_enable_help_alias() {
  emulate -L zsh
  if builtin whence -w 'help' >/dev/null 2>&1; then
    return 0
  fi
  # Zsh normally aliases run-help to man; keep custom aliases but prefer native help over that default.
  if [[ ${aliases[run-help]-} == man ]]; then
    builtin unalias 'run-help' || return 1
  fi
  if (( ! $+aliases[run-help] && ! $+functions[run-help] )); then
    autoload -Uz run-help || return 1
  fi
  builtin alias 'help=run-help'
}

# Return literal text colored by a nominal ANSI-256 index in the active depth.
_alev_paint_color() {
  emulate -L zsh
  local value=$1 index=$2
  [[ $index == <-> ]] && (( 10#$index <= 255 )) || return 1
  index=$((10#$index))
  __alev_color_palette_index_to_rgb "$index" 256
  local target_index=auto
  [[ $__alev_color_depth == 256 ]] && target_index=$index
  __alev_color_render_text "$value" "$REPLY" "$target_index"
  print -r -- "$REPLY"
}

# Print the nominal ANSI-256 reference using the active color encoding.
_alev_show_colors() {
  emulate -L zsh
  local -i i
  local code target_index
  for (( i=0; i<256; ++i )); do
    printf -v code '%03d' "$i"
    __alev_color_palette_index_to_rgb "$i" 256
    target_index=auto
    [[ $__alev_color_depth == 256 ]] && target_index=$i
    __alev_color_render_text "$code" "$REPLY" "$target_index"
    print -P -n -r -- "$REPLY "
    (( i % 16 == 15 )) && print -r -- ''
  done
  return 0
}

# Print diagnostic text with the active palette role and color depth.
__alev_diagnostic_print_colored_text() {
  local hex ansi REPLY
  __alev_color_resolve_role "$1"
  __alev_color_foreground_sgr "$hex" "$ansi"
  builtin printf '%s%s\033[39m' "$REPLY" "$2"
}

# Display raw symbols for visual inspection, without querying fonts or applying fallback.
__alev_show_symbols() {
  emulate -L zsh
  local mode=$1 id value REPLY
  local -a ids=( "${__alev_icon_category_ids[@]}" PATH_ELLIPSIS )
  [[ $mode == nf ]] && ids+=(GIT_NF_COUNTER_GAP)
  builtin printf 'Requested: %s | Effective: %s | Preview: %s\n' "$_ALEV_ICON_MODE" "$__alev_icon_mode" "$mode"
  print -r -- 'Raw symbols; inspect their shapes visually.'
  for id in "${ids[@]}"; do
    case $id in
      PATH_ELLIPSIS) local key="__ALEV_PATH_ELLIPSIS_${(U)mode}"; value=${(P)key} ;;
      GIT_NF_COUNTER_GAP) value=$__ALEV_GIT_NF_COUNTER_GAP ;;
      *) __alev_icon_get_symbol "$id" "$mode"; value=$REPLY ;;
    esac
    __alev_diagnostic_print_colored_text TEXT "$(builtin printf '%-27s' "$id:")"
    builtin printf '[ %s ]\n' "$value"
  done
  return 0
}

# Display all Nerd Fonts symbols without fallback.
_alev_show_nf_symbols() {
  __alev_show_symbols nf
}

# Display all Unicode symbols without fallback.
_alev_show_unicode_symbols() {
  __alev_show_symbols unicode
}

# ---------------- Visual previews (simulated, no runtime or Git queries) ----------------

# Return representative runtime records; these are examples, not installed versions.
__alev_preview_versions() {
  emulate -L zsh
  local -A examples=(
    NODEJS 24.0.0 JAVA 25.0.0 KOTLIN 2.2.0 GO 1.25.0 RUST 1.90.0
    DOTNET 10.0.100 RUBY 3.4.0 PHP 8.4.0 LUA 5.4.8 SWIFT 6.2.0 DART 3.9.0 R 4.5.2
  )
  local runtime_id
  local -a records
  for runtime_id in "${__alev_runtime_ids[@]}"; do
    [[ $1 == all || $1 == "$runtime_id" ]] || continue
    records+=("${runtime_id}=${examples[$runtime_id]}")
  done
  REPLY="${(j:|:)records}"
}

# Render one isolated sample using the current palette, symbols and physical width.
__alev_preview_case() (
  emulate -L zsh
  setopt prompt_percent
  unsetopt prompt_subst prompt_bang
  local title_text=$1 preview_root=$2 preview_ssh=$3 preview_git=$4 preview_lang=$5
  local preview_venv=${6-} preview_conda=${7-} preview_nested=${8:-false} preview_path=${9-}
  local preview_uptime=${11:-3660}
  local preview_duration=${10:-0.01} preview_user=${USERNAME:-${USER:-user}} setting runtime_id
  # Enable every display feature in the child shell so disabled features can be inspected.
  for setting in _ALEV_SHOW_USER _ALEV_SHOW_HOST _ALEV_SHOW_PATH _ALEV_SSH_ENABLED \
    _ALEV_GIT_ENABLED _ALEV_GIT_SHOW_STATUS _ALEV_GIT_SHOW_INPUT_ICON _ALEV_GIT_ROOT_ICON_ENABLED \
    _ALEV_GIT_SHOW_COUNTERS _ALEV_GIT_SHOW_AHEAD _ALEV_GIT_SHOW_BEHIND _ALEV_GIT_SHOW_STAGED \
    _ALEV_GIT_SHOW_CONFLICTS _ALEV_GIT_SHOW_MODIFIED _ALEV_GIT_SHOW_DELETED _ALEV_GIT_SHOW_UNTRACKED \
    _ALEV_UPTIME_ENABLED _ALEV_COMMAND_TIME_COUNT _ALEV_COMMAND_TIME_ENABLED _ALEV_LANGUAGES_ENABLED \
    _ALEV_PYTHON_ENABLED _ALEV_CONDA_ENABLED _ALEV_CONDA_SHOW_BASE _ALEV_PATH_SHORTEN_ENABLED; do
    typeset "$setting=true"
  done
  for runtime_id in "${__alev_runtime_ids[@]}"; do
    typeset "_ALEV_${runtime_id}_ENABLED=true"
  done
  if [[ $preview_root == true ]]; then
    preview_user=root
  elif __alev_is_root; then
    preview_user=user
  fi
  case $preview_git in
    clean) __alev_git_status_record=$'1\tGIT_BRANCH\tmaster\t0\t0\t0\t0\t0\t0\t0' ;;
    sync) __alev_git_status_record=$'1\tGIT_BRANCH\tmaster\t12\t3\t0\t0\t0\t0\t0' ;;
    dirty) __alev_git_status_record=$'1\tGIT_BRANCH\tmaster\t12\t3\t4\t2\t7\t1\t2' ;;
    tag) __alev_git_status_record=$'1\tGIT_TAG\tv6.2.0\t0\t0\t0\t0\t0\t0\t0' ;;
    detached) __alev_git_status_record=$'1\tGIT_BRANCH\ta1b2c3d\t0\t0\t0\t0\t0\t0\t0' ;;
    *) __alev_git_status_record=0 ;;
  esac
  __alev_runtime_version_records=$preview_lang
  __alev_command_elapsed_seconds=$preview_duration
  __alev_prompt_render "$preview_path" "$preview_user" "$preview_root" "$preview_ssh" \
    "$preview_venv" "$preview_conda" "$preview_nested" "$preview_uptime"
  __alev_diagnostic_print_colored_text SSH "$title_text (simulated)"
  print -r -- ''
  print -P -r -- "$__alev_prompt_rendered_text"
  print -r -- ''
  return 0
)

# Preview a single language/environment or all supported language examples.
_alev_show_language() {
  emulate -L zsh
  local language_id=${(U)${1:-all}} runtime_id REPLY
  case $language_id in
    ALL)
      _alev_show_language python
      _alev_show_language conda
      _alev_show_language nested
      for runtime_id in "${__alev_runtime_ids[@]}"; do _alev_show_language "$runtime_id"; done
      _alev_show_language luajit
      _alev_show_language flutter
      ;;
    PYTHON|PY|VENV|PYTHON_VIRTUALENV) __alev_preview_case 'Python virtualenv' false false none '' datascience ;;
    CONDA|MAMBA|MICROMAMBA) __alev_preview_case 'Conda environment' false false none '' '' analytics ;;
    NESTED) __alev_preview_case 'Conda with nested virtualenv' false false none '' datascience analytics true ;;
    LUAJIT) __alev_preview_case 'LuaJIT' false false none 'LUA=LuaJIT v2.1.0' ;;
    FLUTTER) __alev_preview_versions DART; __alev_preview_case 'Flutter project (Dart SDK)' false false none "$REPLY" ;;
    NODE.JS|NODE|.NET|CSHARP|GOLANG|RS|RB|KT)
      case $language_id in
        NODE.JS|NODE) runtime_id=NODEJS ;;
        .NET|CSHARP) runtime_id=DOTNET ;;
        GOLANG) runtime_id=GO ;;
        RS) runtime_id=RUST ;;
        RB) runtime_id=RUBY ;;
        KT) runtime_id=KOTLIN ;;
      esac
      _alev_show_language "$runtime_id" ;;
    *)
      __alev_preview_versions "$language_id"
      if [[ -z $REPLY ]]; then
        print -u2 -r -- 'Usage: _alev_show_language [all|python|conda|nested|node|java|kotlin|go|rust|dotnet|ruby|php|lua|luajit|swift|dart|flutter|r]'
        return 2
      fi
      __alev_preview_case "$language_id" false false none "$REPLY" ;;
  esac
}

# Preview every supported language and environment individually.
_alev_show_languages() {
  _alev_show_language all
}

# Preview clean, synchronized/ahead-behind, dirty, tagged and detached Git states.
_alev_show_git() {
  __alev_preview_case 'Git: clean branch' false false clean ''
  __alev_preview_case 'Git: ahead and behind' false false sync ''
  __alev_preview_case 'Git: all change counters' false false dirty ''
  __alev_preview_case 'Git: exact tag' false false tag ''
  __alev_preview_case 'Git: detached HEAD' false false detached ''
}

# Preview root in ordinary, Git and SSH contexts without changing privileges.
_alev_show_root() {
  __alev_preview_case 'Root: home' true false none '' '' '' false '~'
  __alev_preview_case 'Root: directory' true false none '' '' '' false '/opt/project'
  __alev_preview_case 'Root: Git' true false dirty ''
  __alev_preview_case 'Root: SSH' true true none ''
  __alev_preview_case 'Root: Git over SSH' true true clean ''
}

# Preview ordinary and Git SSH sessions with the current terminal settings.
_alev_show_ssh() {
  __alev_preview_case 'SSH: directory' false true none ''
  __alev_preview_case 'SSH: Git' false true dirty ''
}

# Preview current, home and long synthetic paths without changing directory.
_alev_show_path() {
  emulate -L zsh
  local long_path='~/alev-preview' component
  for component in {01..14}; do long_path+="/directory-${component}-example"; done
  long_path+='/actual'
  __alev_preview_case 'Path: current directory' false false none ''
  __alev_preview_case 'Path: home' false false none '' '' '' false '~'
  __alev_preview_case 'Path: responsive shortening' false false none '' '' '' false "$long_path"
}

# Preview representative elapsed-time thresholds with the normal renderer.
_alev_show_time() {
  local duration
  for duration in 0.01 2 15 65 605 3605; do
    __alev_preview_case "Duration: ${duration}s" false false none '' '' '' false '~' "$duration"
  done
}

# Preview uptime format boundaries using simulated system uptime.
_alev_show_uptime() {
  local seconds
  for seconds in 2 12 60 3660 86400 90061; do
    __alev_preview_case "Uptime: ${seconds}s" false false clean '' '' '' false '~' 0.01 "$seconds"
  done
}

# Preview error notices and the continuation prompt without failing or signaling a command.
_alev_show_exit() (
  emulate -L zsh
  setopt prompt_percent
  unsetopt prompt_subst prompt_bang
  __alev_diagnostic_print_colored_text SSH 'Exit and signal notices (simulated)'
  print -r -- ''
  __alev_command_print_exit_notice 1
  __alev_command_print_exit_notice 127
  __alev_command_print_exit_notice 143
  __alev_icon_get_symbol CONTINUATION
  __alev_color_render_role CONTINUATION "$REPLY"
  __alev_diagnostic_print_colored_text SSH 'Continuation prompt (simulated)'
  print -r -- ''
  print -P -r -- "$REPLY "
  return 0
)

# Preview combined and individual features without changing the real shell context.
_alev_show_all() {
  emulate -L zsh
  local REPLY
  print -r -- "Alev visual previews | icons=$__alev_icon_mode | colors=$__alev_color_depth"
  print -r -- 'Simulated data; display switches enabled only in previews; no runtime or Git commands are run.'
  print -r -- ''
  __alev_preview_versions all
  __alev_preview_case 'All runtimes and Git counters' false false dirty "$REPLY" datascience analytics true
  _alev_show_path
  _alev_show_languages
  _alev_show_git
  _alev_show_root
  _alev_show_ssh
  _alev_show_time
  _alev_show_uptime
  _alev_show_exit
  return 0
}

# List all public Alev functions with their arguments and purpose.
_alev_help() {
  emulate -L zsh
  builtin print -r -- "Alev (Ale Evolved) — public commands"
  builtin print -r -- ''
  builtin print -r -- 'Visual previews'
  builtin printf '  %-39s %s\n' '_alev_show_all' 'Preview all features using simulated data.'
  builtin printf '  %-39s %s\n' '_alev_show_languages' 'Preview each supported language and environment.'
  builtin printf '  %-39s %s\n' '_alev_show_language [name|all]' 'Preview one language or all languages.'
  builtin printf '  %-39s %s\n' '_alev_show_git' 'Preview Git branches, tags and counters.'
  builtin printf '  %-39s %s\n' '_alev_show_root' 'Preview root, Git and SSH contexts without sudo.'
  builtin printf '  %-39s %s\n' '_alev_show_ssh' 'Preview remote sessions with and without Git.'
  builtin printf '  %-39s %s\n' '_alev_show_path' 'Preview current, home and shortened paths.'
  builtin printf '  %-39s %s\n' '_alev_show_time' 'Preview elapsed-time formats and colors.'
  builtin printf '  %-39s %s\n' '_alev_show_uptime' 'Preview system uptime formats and colors.'
  builtin printf '  %-39s %s\n' '_alev_show_exit' 'Preview exit codes, signals and continuation prompts.'
  builtin print -r -- '  Languages: python, conda, nested, node, java, kotlin, go, rust, dotnet,'
  builtin print -r -- '             ruby, php, lua, luajit, swift, dart, flutter, r.'
  builtin print -r -- ''
  builtin print -r -- 'Terminal diagnostics'
  builtin printf '  %-39s %s\n' '_alev_capabilities' 'Report effective terminal capabilities and width.'
  builtin printf '  %-39s %s\n' '_alev_show_nf_symbols' 'Display raw Nerd Fonts symbols.'
  builtin printf '  %-39s %s\n' '_alev_show_unicode_symbols' 'Display raw Unicode symbols.'
  builtin printf '  %-39s %s\n' '_alev_show_colors' 'Display the ANSI-256 reference in the active depth.'
  builtin print -r -- ''
  builtin print -r -- 'Configuration and utilities'
  builtin printf '  %-39s %s\n' '_alev_icons nf|unicode|ascii' 'Select iconography for the current session.'
  builtin printf '  %-39s %s\n' '_alev_prompt_refresh' 'Clear caches and refresh on the next prompt.'
  builtin printf '  %-39s %s\n' '_alev_stderr [exit_code] message...' 'Print a stderr message and return its code (default 1).'
  builtin printf '  %-39s %s\n' '_alev_stderr --run command [args...]' 'Color command stderr and preserve its actual exit code.'
  builtin printf '  %-39s %s\n' '_alev_paint_color value index' 'Return prompt-colored text for ANSI index 0–255.'
  builtin printf '  %-39s %s\n' '_alev_enable_help_alias' 'Install the session-local help=run-help alias.'
  builtin printf '  %-39s %s\n' '_alev_help' 'List all public Alev functions.'
  return 0
}

# Clear worker and runtime caches before the next prompt.
_alev_prompt_refresh() {
  __alev_worker_cancel_all
  __alev_terminal_capabilities_checked=0
  __alev_runtime_version_cache=(); __alev_runtime_version_cache_timestamps=(); __alev_runtime_cached_context_signature=''; __alev_runtime_version_records=''; __alev_git_status_record=''
  __alev_autosuggest_apply_style
  return 0
}

# Release pending worker descriptors when the shell exits.
__alev_zsh_exit_cleanup() {
  __alev_stderr_restore
  __alev_worker_cancel_all
  return 0
}

# ---------------- Theme activation and hooks ----------------

# Install the optional alias only in interactive sessions, without touching ZLE.
if [[ -o interactive && $_ALEV_ZSH_HELP_ALIAS_ENABLED == true ]]; then
  _alev_enable_help_alias
fi

# Avoid double decorations from the standard Python venv activation script.
export VIRTUAL_ENV_DISABLE_PROMPT=1
# Conda activation should be configured with `conda config --set changeps1 false`.
# Put this theme's hooks first among hook arrays, to capture $? early.
typeset -ga preexec_functions precmd_functions
preexec_functions=( __alev_zsh_preexec ${preexec_functions:#__alev_zsh_preexec} )
precmd_functions=( __alev_zsh_precmd ${precmd_functions:#__alev_zsh_precmd} )
add-zsh-hook zshexit __alev_zsh_exit_cleanup
if [[ -o interactive && $_ALEV_ZLE_INTEGRATION == true ]]; then
  __alev_zle_active=1
  zle -N __alev_git_worker_ready
  zle -N __alev_runtime_worker_ready
  zle -N __alev_terminal_capability_worker_ready
  autoload -Uz add-zle-hook-widget
  add-zle-hook-widget zle-line-pre-redraw __alev_zle_resize_redraw
fi
setopt prompt_subst
# The theme emits its own blank lines. PROMPT_SP writes terminal-width spaces
# to preserve partial output, which can pollute copied text (even with no RPROMPT).
# Leave PROMPT_CR unchanged; do not filter command output or touch user spaces.
unsetopt prompt_sp
# Never interpolate user-controlled strings into a shell expression.
PROMPT='${__alev_prompt_rendered_text}'
RPROMPT=''
RPS2=''
# No right-aligned elements or artificial padding; no initial blank line.
__alev_detect_icons
__alev_icon_mode=$REPLY
__alev_detect_colors quick
__alev_color_depth=$REPLY
__alev_autosuggest_apply_style
__alev_prompt_render


# ============================================================================
# CREDITS
#
# **Special thanks to [Alejandro Pimentel (@alepimentel)](https://github.com/alepimentel)**, author of [Ale ZSH Theme](https://github.com/alepimentel/ale-zsh).
# ============================================================================
