[[ "$XTRACE" == "verbose" ]] && printf "\nSourcing $HOME/.zshenv ..."

# http://zsh.sourceforge.net/Guide/zshguide02.html#l24
typeset -U path
typeset -U manpath
typeset -U infopath

if [[ $OSTYPE == *darwin* ]]; then
    # https://github.com/tj/n
    if [[ -z "$N_PREFIX" ]]; then
        [[ "$XTRACE" == "verbose" ]] && printf "\nRunning export N_PREFIX=$HOME/n ..."
        export N_PREFIX="$HOME/n"
    fi

    if [[ -d "$HOME/n/bin" ]]; then
        [[ "$XTRACE" == "verbose" ]] && printf "\nAdding $N_PREFIX/bin to path ..."
        path=($PATH "$N_PREFIX/bin")
    fi

    # https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html#_setting_up
    if [[ -d "$HOME/Applications/depot_tools" ]]; then
        path=($PATH "$HOME/Applications/depot_tools/bin")
    fi
fi

if [[ $OSTYPE == *linux* ]]; then
    # http://linuxbrew.sh/
    if [[ -d "$HOME/.linuxbrew" ]]; then
        path=($PATH "$HOME/.linuxbrew/bin")

        manpath=($MANPATH "$(brew --prefix)/share/man")
        infopath=($INFOPATH "$(brew --prefix)/share/info")
    fi
fi

# Add npm_config_prefix to $PATH
if [[ -d "$HOME/.npm-prefix" ]]; then
    [[ "$XTRACE" == "verbose" ]] && printf "\nAdding $HOME/.npm-prefix/bin to path ..."
    path=($PATH "$HOME/.npm-prefix"/bin)
fi
