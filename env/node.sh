#!/usr/bin/env bash
# node@10 npm yarn
#!/usr/bin/env bash
if [[ "$(uname -s)" == "Darwin" ]]; then
    PATH="/usr/local/opt/node@10/bin:$PATH"
fi

node_bin_path="$HOME/.npm-global/bin"
if [[ -d "${node_bin_path}" ]]; then
    addToPATH "${node_bin_path}"
fi
unset node_bin_path
echo "debug node"
