export ZSH="/home/chen/.oh-my-zsh"

ZSH_THEME="darkblood"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump)

source $ZSH/oh-my-zsh.sh
source $HOME/.zshrc.alias

HIST_STAMPS="yyyy-mm-dd"

# GO
export GOROOT=/usr/local/go
export GOPATH=$HOME/go:$HOME/github
export GOPROXY=https://goproxy.cn,direct
export GO111MODULE=on

# JAVA
export JAVA_HOME=/usr/local/jdk1.8.0_211
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

## Maven
export MAVEN_HOME=/usr/local/apache-maven-3.6.1

## PATH
export PATH=$PATH:$GOPATH:$JAVA_HOME/bin:/$MAVEN_HOME/bin
