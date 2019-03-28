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
        path=("$N_PREFIX/bin" $path)
    fi

    if [[ -d "/usr/local/sbin" ]]; then
	[[ "$XTRACE" == "verbose" ]] && printf "\nAdding /usr/local/sbin to path ..."
        path=("/usr/local/sbin" $path)
    fi
fi

if [[ $OSTYPE == *linux* ]]; then
    # http://linuxbrew.sh/
    if [[ -d "$HOME/.linuxbrew" ]]; then
        path=("$HOME/.linuxbrew/bin" $path)

        manpath=("$(brew --prefix)/share/man" $manpath)
        infopath=("$(brew --prefix)/share/info" $infopath)
    fi
fi

# https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html#_setting_up
if [[ -d "$HOME/lib/depot_tools" ]]; then
    path=("$HOME/lib/depot_tools" $path)
fi

# Add $HOME/bin to the path
if [[ -d "$HOME/bin" ]]; then
    path=("$HOME/bin" $path)
fi

# Add npm_config_prefix to the path
if [[ -d "$HOME/.npm-prefix" ]]; then
    [[ "$XTRACE" == "verbose" ]] && printf "\nAdding $HOME/.npm-prefix/bin to path ..."
    path=("$HOME/.npm-prefix/bin" $path)
fi
