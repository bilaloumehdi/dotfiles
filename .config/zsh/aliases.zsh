######################################
# Bash aliases
######################################
alias cl='clear'
alias ls='ls -l'
alias q='exit'

######################################
# IDE lunching
########################################
export PATH="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin:$PATH"
export PATH="/Applications/IntelliJ\ IDEA.app/Contents/MacOS:$PATH"
#######################################

###########################
# VIM 
###########################
alias vim='nvim'
alias vi='nvim'

#######################################
# GIT aliases
#######################################
alias co='git checkout'
alias master='git checkout master'
alias gst='git status'
alias glog='git log'
alias glogo='git log --oneline'
alias glogor='git log --oneline --graph'
alias gadd='git add'
alias gcmt='git commit'
alias gpsh='git push'
alias gpshs='cmn && mvn spotless:apply && git push'
alias gpu='git pull'
alias gd='git diff'
alias gbr='git branch --sort=-committerdate'
alias gmr='git merge'
alias gsh='git stash'
alias gsp='git stash pop'
alias grs='git restore'
alias grss='git restore --staged'

########################################
#  BUILD
########################################
alias mvnqk='mvnd "-Dmaven.javadoc.skip=true" "-Dmaven.jacoco.skip=true" -DskipTests clean install'
