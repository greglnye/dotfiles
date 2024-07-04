#!/usr/bin/env bash
# This file runs once at login.

# Add all local binary paths to the system path.
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/bin/ninja:${PATH}"
export PATH="${HOME}/bin/vcpkg:${PATH}"
export PATH="${HOME}/bin/llvm-project/build/bin:${PATH}"
export PATH="${HOME}/kustomize:${PATH}"

export JAVA_HOME="${HOME}/bin/jdk-17"
export PATH="${JAVA_HOME}/bin:${PATH}"

# Default programs to run.
export EDITOR="vim"
export BROWSER=/usr/bin/firefox

# Add colors to the less and man commands.
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

# If bash is the login shell, then source ~/.bashrc if it exists.
echo "${0}" | grep "bash$" >/dev/null \
  && [ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc"

