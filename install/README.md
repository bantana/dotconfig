# 重构

## bash脚本编写

```bash
err() {
    # 错误输出到stderr
}

```

检测上一条命令返回值，如果有的话.

```bash
if [[ $? -ne 0 ]]; then
    err "found some error!"
    exit 1
fi
```

Clean:

```bash
clean() {
    # clean
}
```

Check：

```bash
check(neovim,nodejs,npm,yarn) {
    # check program exist.
}

register:

```bash
register(npm) {
    # register operator step stats(installed, failed)
}

