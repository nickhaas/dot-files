# Path to your oh-my-zsh installation.
export ZSH=/home/nick/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="xiong-chiamiov"
ZSH_THEME="rkj-repos"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
 DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
 DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git systemd tmux zsh-syntax-highlighting go)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export EDITOR='vim'
export VISUAL='vim'

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Set some aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias sshconfig="vim ~/.ssh/config"
alias sshknown="vim ~/.ssh/known_hosts"
alias vimrc="vim ~/.vimrc"
alias i3config="vim ~/.i3/config"
alias Xresources="vim ~/.Xresources"
alias office='rdesktop -d UNITED -u nhaas -g 1920x1180 -k de hotel-kette.united.domain'
alias winjumper='rdesktop -d UNITED -u nhaas -g 1680x1000 -k de winjumper.united.domain'
#alias mg='sudo mount -t cifs -o username=nhaas //unifska01.united.domain/global$ /home/nick/mount/global'
alias mg='sudo mount -t cifs -o username=nhaas //united.domain/shares/global /home/nick/mount/global'
alias homes='sudo mount -t cifs //homejumper.united.domain/ka_homes/nhaas /home/nick/mount/ka_homes -o username=nhaas,domain=united'


# FIX STEAM FTW!!
alias rmbadsteamlibs='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete'
alias rmbadsteamlibslocal='find ~/.local/share/Steam/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete'

export GITHUB_TOKEN="YOUR_GITHUB_TOKEN"

i3-get-window-criteria() {
    PROGNAME=`basename "$0"`

    # Check for xwininfo and xprop
    for cmd in xwininfo xprop; do
        if ! which $cmd > /dev/null 2>&1; then
            echo "$PROGNAME: $cmd: command not found" >&2
            exit 1
        fi
    done

    match_int='[0-9][0-9]*'
    match_string='".*"'
    match_qstring='"[^"\\]*(\\.[^"\\]*)*"' # NOTE: Adds 1 backreference

    {
        # Run xwininfo, get window id
        window_id=`xwininfo -int | sed -nre "s/^xwininfo: Window id: ($match_int) .*$/\1/p"`
        echo "id=$window_id"

        # Run xprop, transform its output into i3 criteria. Handle fallback to
        # WM_NAME when _NET_WM_NAME isn't set
        xprop -id $window_id |
            sed -nr \
                -e "s/^WM_CLASS\(STRING\) = ($match_qstring), ($match_qstring)$/instance=\1\nclass=\3/p" \
                -e "s/^WM_WINDOW_ROLE\(STRING\) = ($match_qstring)$/window_role=\1/p" \
                -e "/^WM_NAME\(STRING\) = ($match_string)$/{s//title=\1/; h}" \
                -e "/^_NET_WM_NAME\(UTF8_STRING\) = ($match_qstring)$/{s//title=\1/; h}" \
                -e '${g; p}'
    } | sort | tr "\n" " " | sed -r 's/^(.*) $/[\1]\n/'
}

PATH="/home/nick/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/nick/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/nick/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/nick/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/nick/perl5"; export PERL_MM_OPT;

mkpasswd() {
   length="$1"
   if [ -z "$length" ]; then
      length="20"
   fi
   < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$length} | sed 's/-/_/';echo;
}

initsshkeyaccess() {
   echo "> Adding SSH-Keys"
   echo "=> nhaas"
   ssh-add ~/.ssh/nhaas
}

ssh-add -l || initsshkeyaccess
