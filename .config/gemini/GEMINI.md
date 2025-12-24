## Gemini Added Memories
- Always use uv to run python files.
- Always use 'uv run' to execute python files.
- Always use 'uv add' to add missing packages.

User GitHub Profile: https://github.com/mackrus

## Dotfiles Management
- **Setup**: Bare Git repository stored at `~/.dotfiles`.
- **Alias**: `dot` (configured in `~/.zshrc`) acts as the git command for dotfiles.
- **Workflow**: 
  - Use `dot status` to check changes.
  - Use `dot add -f <file>` to track new files (everything is ignored by default in `~/.gitignore`). 
  - Use `dot commit` and `dot push` as usual.
- **Repository**: https://github.com/mackrus/dotfiles
