# subract's dotfiles

# Usage

Symlink as needed to appropriate locations - I use Ansible to automate this task

## Package notes

### ssh-agent

This package creates a systemd user service that starts an SSH agent, and a `.pam_environment` file that sets the appropriate environment variable. After installing the package, run 
```bash
systemctl --user enable --now ssh-agent
```

### i3

Intended for use with [j4-make-config](https://github.com/okraits/j4-make-config). After updating dots, run 

```bash
j4-make-config -r -a <laptop|desktop> <theme-name|none>
```

Conveniently, running just `j4-make-config` will re-run the most recently run command, so you only need to specify args when changing the theme.
