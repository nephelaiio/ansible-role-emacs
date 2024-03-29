#!/usr/bin/env bash
set -e

git_clone_url=https://github.com/nephelaiio/ansible-role-emacs.git
OK=0
KO=1
if [ -z "$EMACS_INSTALL" ]; then
    EMACS_INSTALL="$OK"
fi

# redefine pushd/popd
# see: https://stackoverflow.com/questions/25288194/dont-display-pushd-popd-stack-across-several-bash-scripts-quiet-pushd-popd
pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd > /dev/null
}

# usage helper
function help {
    echo "$0 OPTIONS [ANSIBLE ARGUMENTS]"
    echo
    echo "OPTIONS:"
    echo "   [--local]"
}

# parse options
# see https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --local)
            LOCAL=$OK
            shift # past argument
            ;;
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
            ;;
    esac
done

# verify requirements
requirements=(ansible-playbook git)
for r in "${requirements[@]}"; do
    if ! type -p "$r"; then
        echo "$r executable not found in path, aborting"
        exit $KO
    fi
done

# create temp dir
tmpdir="$(mktemp -d)"

# perform local role install
if [ -z "${LOCAL}" ]; then
    git clone -q "$git_clone_url" "$tmpdir"
else
    cp -a . "$tmpdir"
fi
pushd "$tmpdir/install"
if [ ! -d ~/.doom.d ]; then
    mkdir ~/.doom.d
fi
ansible-galaxy role install nephelaiio.emacs --force
if [[ "$EMACS_INSTALL" == "$OK" ]]; then
    ansible-playbook --become --connection=local -i inventory playbook.yml -t install
fi
ansible-playbook --connection=local -i inventory playbook.yml "${POSITIONAL[@]}" -t configure -e emacs_doom_config=yes
popd

# initialize doom emacs
~/.emacs.d/bin/doom -y install --no-env --no-fonts
~/.emacs.d/bin/doom -y env

# purge temp files
rm -rf "$tmpdir"
exit $OK
