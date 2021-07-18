<div align="center">

# asdf-skaffold [![Build](https://github.com/nklmilojevic/asdf-skaffold/actions/workflows/build.yml/badge.svg)](https://github.com/nklmilojevic/asdf-skaffold/actions/workflows/build.yml) [![Lint](https://github.com/nklmilojevic/asdf-skaffold/actions/workflows/lint.yml/badge.svg)](https://github.com/nklmilojevic/asdf-skaffold/actions/workflows/lint.yml)


[skaffold](https://github.com/GoogleContainerTools/skaffold) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add skaffold
# or
asdf plugin add skaffold https://github.com/nklmilojevic/asdf-skaffold.git
```

skaffold:

```shell
# Show all installable versions
asdf list-all skaffold

# Install specific version
asdf install skaffold latest

# Set a version globally (on your ~/.tool-versions file)
asdf global skaffold latest

# Now skaffold commands are available
skaffold version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/nklmilojevic/asdf-skaffold/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Nikola Milojević](https://github.com/nklmilojevic/)
