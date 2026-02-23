# Distributed Development Workflow

## 🔄 Collaborative Development: MacBook + Jetson

We now use a **distributed workflow** where both MacBook and Jetson have git repos and can contribute independently.

---

## 📋 Architecture

```
┌─────────────┐     git push      ┌──────────┐     git pull      ┌──────────┐
│  MacBook    │ ─────────────────→  │  GitHub  │ ←─────────────────│  Jetson   │
│  (Mark dev) │                   │ (Backup) │                   │  (AI dev)  │
└─────────────┘                   └──────────┘                   └──────────┘
        ↑                               ↑                                ↓
        └──────────── git pull ─────────┴────────────────────────┘
```

### Locations:

- **MacBook:** `~/Sites/jetson-openclaw-setup`
- **Jetson:** `~/openclaw-repo`
- **GitHub:** `https://github.com/markfietje/jetson-openclaw-setup`

---

## 🎯 Golden Rule

**ALWAYS pull before you push!**

```bash
git pull origin main  # Get latest changes FIRST
# Then make your changes
git add .
git commit -m "Your changes"
git push origin main
```

---

## 📝 Standard Workflow

### On MacBook (Mark):
```bash
cd ~/Sites/jetson-openclaw-setup

# ALWAYS pull first
git pull origin main

# Make changes
vim services/signal-gateway/src/main.rs

# Test locally (if applicable)
cargo test

# Commit
git add .
git commit -m "feat: Add new feature"

# Push
git push origin main
```

### On Jetson (AI Assistant):
```bash
cd ~/openclaw-repo

# ALWAYS pull first
git pull origin main

# Make changes
vim services/brain-server/src/main.rs

# Commit
git add .
git commit -m "feat: Add new feature"

# Push
git push origin main
```

---

## ✅ Benefits

1. **Independent work** - Mark and AI can work simultaneously
2. **Traditional workflow** - Same as open-source collaboration
3. **Automatic merging** - Git handles conflicts
4. **Backup protection** - Everything on GitHub
5. **Flexible** - Can work from either machine

---

## ⚠️ Discipline Required

### Critical Rules:

1. **PULL BEFORE YOU PUSH** ✅
   ```bash
   git pull origin main  # Do this FIRST every time
   ```

2. **CLEAR COMMIT MESSAGES** ✅
   ```bash
   git commit -m "feat: Add feature X"
   git commit -m "fix: Bug in signal receiver"
   ```

3. **PUSH FREQUENTLY** ✅
   - Don't let changes pile up
   - Push often to avoid conflicts

4. **CHECK STATUS** ✅
   ```bash
   git status  # See what's changed
   git log --oneline -5  # See recent commits
   ```

---

## 🔀 Conflict Resolution

If there's a merge conflict (rare if you pull first):

```bash
git pull origin main
# CONFLICT! Fix the files
vim conflicting-file.txt
# Resolve conflicts
git add conflicting-file.txt
git rebase --continue
git push origin main
```

---

## 🎯 Quick Reference

| Task | Command |
|------|---------|
| **Pull latest** | `git pull origin main` |
| **Check status** | `git status` |
| **Commit** | `git add . && git commit -m "message"` |
| **Push** | `git push origin main` |
| **See log** | `git log --oneline -10` |
| **Sync** | `git pull --rebase origin main` |

---

## 📊 Typical Session

### Mark (on MacBook):
```bash
cd ~/Sites/jetson-openclaw-setup
git pull origin main
# Make changes
git add .
git commit -m "feat: Add new feature"
git push origin main
```

### AI Assistant (on Jetson):
```bash
cd ~/openclaw-repo
git pull origin main  # Get Mark's latest changes
# Make changes
git add .
git commit -m "fix: Bug in brain-server"
git push origin main
```

### Mark (back on MacBook):
```bash
git pull origin main  # Get AI's changes
# Now both machines are in sync!
```

---

## 🎉 Advantages

- ✅ **Independent work** - No waiting for each other
- ✅ **Collaborative** - Both can contribute
- ✅ **Safe** - Everything backed up on GitHub
- ✅ **Professional** - Standard open-source workflow
- ✅ **Flexible** - Work from anywhere

---

## 💡 Best Practices

1. **Commit small, atomic changes**
   - One feature per commit
   - Clear commit messages

2. **Push frequently**
   - Don't batch changes
   - Keep GitHub in sync

3. **Pull before starting work**
   - Always start with `git pull`
   - See what others changed

4. **Check git status**
   - Know what's changed
   - Don't commit unintended files

5. **Write good commit messages**
   - Use conventional format
   - Be descriptive
   - Reference issues if needed

---

## 🚨 Troubleshooting

### "Push rejected"
```bash
# Someone else pushed first
git pull --rebase origin main
git push origin main
```

### "Merge conflict"
```bash
# Edit the conflicting files
# Remove conflict markers
git add conflicted-file.txt
git rebase --continue
git push origin main
```

### "Not a git repository"
```bash
# You're in the wrong directory
cd ~/openclaw-repo  # on Jetson
cd ~/Sites/jetson-openclaw-setup  # on MacBook
```

---

## 🎯 Summary

**Key principle:** Pull before you push!

**Workflow:**
1. Pull: `git pull origin main`
2. Work: Edit files
3. Commit: `git add . && git commit -m "message"`
4. Push: `git push origin main`

**Repeat on both machines!**

---

**Added:** 2026-02-23
**Status:** ACTIVE - Distributed workflow enabled
**Locations:** MacBook + Jetson + GitHub
