# subract's dotfiles

# Usage

Symlink as needed to appropriate locations - I use Ansible to automate this task.

## Package notes

### ssh-agent

This package creates a systemd user service that starts an SSH agent, and a `.pam_environment` file that sets the appropriate environment variable. After installing the package, run 
```bash
systemctl --user enable --now ssh-agent
```