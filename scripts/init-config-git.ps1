if (Get-Command git -ErrorAction SilentlyContinue) {
    # TODO: config user info

    # conf about push/pull
    git config --global init.defaultBranch main
    git config --global push.autoSetupRemote true

    # recommended aliases from official site
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
    git config --global alias.unstage "reset HEAD --"
    git config --global alias.last "log -1 HEAD"
    git config --global alias.visual !gitk

    # recommanded aliases for pretty log
    git config --global alias.ll "log --oneline --graph"
    git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

    # other recomended aliases
    git config --global alias.ls-staged "diff --cached --name-only"
    git config --global alias.config-ignore "!curl -L -s https://www.gitignore.io/api/$@ > .gitignore"
}
