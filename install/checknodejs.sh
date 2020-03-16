npmrc='prefix=~/.npm-global'

if [[ ! -f ~/.npmrc ]]; then
    touch ~/.npmrc
fi
# if [[ $(< ~/.npmrc ) != "$npmrc" ]]; then
if [[ $(grep prefix ~/.npmrc) != "~/.npm-global" ]]; then
    echo "fixing npm config set prefix='~/.npm-global'"
    npm config set prefix='~/.npm-global'
else
    echo "npm config already set!"
fi
