# ButterSus AstroNvim Community Repository

A personalized fork of the [AstroNvim Community Repository](https://github.com/AstroNvim/astrocommunity) with my custom plugin configurations and contributions.

<div align="center">
  <img src="https://astronvim.com/logo/astronvim.svg" width="110" height="100" />
</div>

## Repository Structure

This repository is organized with the following branch structure:

- `personal` (default): My customized version with personal plugin settings and enhancements
- `main`: Mirror of the upstream AstroNvim/astrocommunity repository

## Using This Repository

### In Your AstroNvim Config

To use my personal branch of the community repository instead of the official one, modify your `lua/community.lua` file:

```lua
return {
  "ButterSus/astrocommunity", -- Use my fork instead of the official repo
  -- Default branch is 'personal' so no need to specify
  { import = "astrocommunity.colorscheme.catppuccin" },
  -- ... import any other community contributed plugins
}
```

If you want to specifically use the personal branch (though it's the default):

```lua
return {
  { "ButterSus/astrocommunity", branch = "personal" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  -- ... other imports
}
```

### Custom Features

This fork includes:

- Additional plugins not found in the upstream repository
- Custom configurations and overrides for existing plugins
- Plugin settings optimized for my personal workflow

## Git Workflow

### For Maintaining This Repository

I maintain this repository using the following git workflow:

1. **Syncing with upstream**:

   ```bash
   git checkout main
   git fetch upstream
   git merge upstream/main
   git push origin main

   # Update personal branch with changes from main
   git checkout personal
   git rebase main
   git push -f origin personal  # Force push as rebase rewrites history
   ```

2. **Contributing to upstream**:

   ```bash
   # Create feature branch from main (not personal)
   git checkout main
   git checkout -b feature/new-plugin-entry

   # Make changes and commit
   git add .
   git commit -m "Add new plugin: plugin-name"

   # Push to fork
   git push origin feature/new-plugin-entry

   # Create PR to upstream through GitHub interface
   ```

3. **Adding personal customizations**:
   ```bash
   git checkout personal
   # Make changes to existing plugins or add new ones
   git commit -m "Add personal customization for plugin-name"
   git push origin personal
   ```

### For Contributors

If you want to contribute to my personal fork:

1. Fork this repository
2. Create a branch for your feature from the `personal` branch
3. Submit a pull request to the `personal` branch of this repository

## Initial Setup

If you want to set up a similar workflow for your own fork:

```bash
# Clone your fork
git clone https://github.com/yourusername/astrocommunity.git
cd astrocommunity

# Add upstream remote
git remote add upstream https://github.com/AstroNvim/astrocommunity.git

# Create personal branch
git checkout -b personal

# Set personal as default branch (in GitHub settings)

# Push to your fork
git push -u origin personal
```

## Questions or Issues?

Feel free to open an issue if you have any questions or encounter problems using my fork.
