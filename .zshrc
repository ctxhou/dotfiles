# Locale (https://help.ubuntu.com/community/Locale#List_current_settings)
export LANG="en_US.UTF-8"

# Report 256-color terminal
export TERM="xterm-256color"

# https://unix.stackexchange.com/questions/111718/command-history-in-zsh
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# antigen (https://github.com/zsh-users/antigen)
if [[ -z "$ANTIGEN_HOME" ]]; then
    [[ "$XTRACE" == "verbose" ]] && printf "\nRunning export ANTIGEN_HOME=/usr/local/share/antigen ..."
    export ANTIGEN_HOME="/usr/local/share/antigen"
fi

if [[ -e "$ANTIGEN_HOME/antigen.zsh" ]]; then
    [[ "$XTRACE" == "verbose" ]] && printf "\nRunning source \$ANTIGEN_HOME/antigen.zsh ..."
    source "$ANTIGEN_HOME/antigen.zsh"

    # Enable antigen logging
    # https://github.com/zsh-users/antigen/wiki/Configuration#general
    # ANTIGEN_LOG=$ANTIGEN_HOME/antigen.log

    antigen use oh-my-zsh # http://ohmyz.sh

    if [[ $OSTYPE == *darwin* ]]; then
        antigen bundle https://github.com/robbyrussell/oh-my-zsh plugins/osx
    fi

    antigen bundle https://github.com/robbyrussell/oh-my-zsh plugins/git
    antigen bundle https://github.com/robbyrussell/oh-my-zsh plugins/emoji-clock
    antigen bundle https://github.com/robbyrussell/oh-my-zsh plugins/command-not-found
    antigen bundle https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting.plugin.zsh
    antigen bundle https://github.com/tysonwolker/iterm-tab-colors zsh-tab-colors.plugin.zsh
    antigen bundle https://github.com/rupa/z z.sh

    DEFAULT_USER=$USER
    POWERLEVEL9K_ALWAYS_SHOW_USER=false
    # POWERLEVEL9K_MODE="nerdfont-complete"
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status context virtualenv dir vcs newline)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

    # https://github.com/bhilburn/powerlevel9k/wiki/Install-Instructions#option-4-install-for-antigen
    POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
    antigen theme bhilburn/powerlevel9k@v0.6.6 powerlevel9k

    antigen apply
fi

# Git aliases (override/add oh-my-zsh plugins/git)
alias gs="gsb"
alias gds="gdca"
alias gg="git grep --ignore-case --line-number"
if type tig > /dev/null; then
        alias gl="tig --all"
    else
        unalias gl # Unalias oh-my-zsh’s plugins/git’s gl alias
        function gl() {
            # https://junegunn.kr/2015/03/browsing-git-commits-with-fzf/
            # https://gist.github.com/junegunn/f4fca918e937e6bf5bad
            # https://gist.github.com/akatrevorjay/9fc061e8371529c4007689a696d33c62
            # https://asciinema.org/a/101366
            git log \
            --abbrev-commit \
            --all \
            --color=always \
            --date=iso8601 \
            --graph \
            --pretty='%C(cyan)%h %C(red)%d %C(blue)%s %C(white)on %C(magenta)%cd %C(white)by %C(yellow)%ce%Creset' \
            "$@" | \

            fzf \
            --ansi \
            --no-mouse \
            --reverse \
            --tiebreak=index \
            --no-sort \
            --bind=ctrl-s:toggle-sort \
            # --preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}'
        }
fi

# https://github.com/sindresorhus/guides/blob/master/how-not-to-rm-yourself.md
# https://github.com/sindresorhus/trash-cli
# if type trash > /dev/null; then
#         alias rm="trash"
#     else
#         print "Install trash-cli (https://github.com/sindresorhus/trash-cli) for an improved experience"
#         alias rm="rm -i"
# fi

# Pretty grep (https://www.gnu.org/software/grep/manual/grep.html)
alias grep="grep --line-number --color"

# Pretty tree (https://linux.die.net/man/1/tree)
alias tree="tree -CDAshpug"

# https://coderwall.com/p/lzgryq/cat-with-syntax-highlighting
if type pygmentize > /dev/null; then
        alias ccat="pygmentize -f terminal256 -g"
    else
        alias ccat="cat --number $@"
fi

# https://github.com/junegunn/fzf
if [[ -d "$HOME/lib/fzf" ]]; then
    source "$HOME/lib/fzf/shell/completion.zsh"
    source "$HOME/lib/fzf/shell/key-bindings.zsh"
fi

# https://github.com/rbenv/rbenv
if type rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

# https://the.exa.website
if type exa > /dev/null; then
    alias la="exa --all --blocks --git --group --group-directories-first --header --inode --links --long"
    alias ll="la"
fi

# Work
if [[ -e "$HOME/.zshrc_work" ]]; then
    [[ "$XTRACE" == "verbose" ]] && printf "\nRunning source $HOME/.zshrc_work ..."
    source "$HOME/.zshrc_work"
fi

# References
# http://zsh.sourceforge.net/Doc/Release/Conditional-Expressions.html
# https://robots.thoughtbot.com/the-unix-shells-humble-if
