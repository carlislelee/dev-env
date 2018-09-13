alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'

alias htxt='hadoop fs -text'
alias hls='hadoop fs -ls'
alias hdu='hadoop fs -du -h'
alias hdus='hadoop fs -du -s -h'
alias hput='hadoop fs -put'
alias hrmr='hadoop fs -rm -r'
alias hmkdir='hadoop fs -mkdir'

export LS_OPTIONS='--color=auto'           # 如果没有指定，则自动选择颜色
export CLICOLOR='Yes'                       # 是否输出颜色
export LSCOLORS='ExGxFxdaCxDaDahbadacec'    # 指定颜色

