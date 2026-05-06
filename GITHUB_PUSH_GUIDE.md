# How to Push Your Code to GitHub

**Your GitHub Account**: https://github.com/Janani-TG  
**Date**: May 7, 2026

---

## 📋 Prerequisites

Before pushing, make sure you have:
- ✅ Git installed on your computer
- ✅ GitHub account (you have: Janani-TG)
- ✅ Git configured with your credentials

---

## 🚀 Step-by-Step Guide

### Step 1: Configure Git (First Time Only)

Open a terminal/command prompt and run:

```bash
git config --global user.name "Janani-TG"
git config --global user.email "your-email@example.com"
```

Replace `your-email@example.com` with the email you used for GitHub.

---

### Step 2: Check Current Git Status

Navigate to your project folder:

```bash
cd D:\skillswap\skill-swap-app
```

Check the status:

```bash
git status
```

This will show you all the files that have been modified.

---

### Step 3: Stage All Changes

Add all your changes to Git:

```bash
git add .
```

This stages all modified files for commit.

---

### Step 4: Commit Your Changes

Create a commit with a descriptive message:

```bash
git commit -m "feat: Add UPI payment gateway and fix slot booking

- Implemented UPI payment system with multiple payment options
- Added payment options bottom sheet (UPI, Card, Wallets)
- Fixed slot booking navigation from skill detail to session screen
- Added date picker and time slot selection
- Updated theme colors to white, light brown, and pastel brown
- Fixed credit system flow (credits not deducted on request)
- All features tested and working on Chrome"
```

---

### Step 5: Check Remote Repository

Check if you already have a remote repository configured:

```bash
git remote -v
```

**If you see a URL**: Skip to Step 7  
**If you see nothing**: Continue to Step 6

---

### Step 6: Add Remote Repository (If Needed)

#### Option A: If Repository Already Exists on GitHub

If you already created a repository on GitHub (e.g., `skillswap` or `skill-swap-app`):

```bash
git remote add origin https://github.com/Janani-TG/skillswap.git
```

Replace `skillswap` with your actual repository name.

#### Option B: Create New Repository on GitHub

1. Go to https://github.com/Janani-TG
2. Click the **"+"** icon (top right) → **"New repository"**
3. Repository name: `skillswap` or `skill-swap-app`
4. Description: "Skill exchange platform with UPI payments"
5. Choose **Public** or **Private**
6. **DO NOT** initialize with README (you already have one)
7. Click **"Create repository"**
8. Copy the repository URL (e.g., `https://github.com/Janani-TG/skillswap.git`)
9. Run:

```bash
git remote add origin https://github.com/Janani-TG/skillswap.git
```

---

### Step 7: Push to GitHub

#### First Time Push

If this is your first push to this repository:

```bash
git branch -M main
git push -u origin main
```

#### Subsequent Pushes

For future updates:

```bash
git push
```

---

### Step 8: Verify on GitHub

1. Go to https://github.com/Janani-TG
2. Click on your repository name
3. You should see all your files uploaded!

---

## 🔐 Authentication

When you push for the first time, GitHub will ask for authentication:

### Option 1: Personal Access Token (Recommended)

1. Go to https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Give it a name: "SkillSwap Development"
4. Select scopes: Check **"repo"** (full control of private repositories)
5. Click **"Generate token"**
6. **COPY THE TOKEN** (you won't see it again!)
7. When Git asks for password, paste the token

### Option 2: GitHub CLI

Install GitHub CLI and authenticate:

```bash
gh auth login
```

Follow the prompts to authenticate.

---

## 📝 Quick Reference Commands

### Check Status
```bash
git status
```

### Stage Changes
```bash
git add .                    # Add all files
git add filename.dart        # Add specific file
```

### Commit Changes
```bash
git commit -m "Your message here"
```

### Push Changes
```bash
git push
```

### Pull Latest Changes
```bash
git pull
```

### View Commit History
```bash
git log --oneline
```

### Create New Branch
```bash
git checkout -b feature-name
```

### Switch Branch
```bash
git checkout main
```

---

## 🎯 What You're Pushing

Your commit includes:

### New Features
1. **UPI Payment Gateway**
   - `skill-swap-app/lib/screens/credits_screen.dart` (modified)
   - Payment options bottom sheet
   - UPI payment dialog
   - Transaction confirmation

2. **Slot Booking Fix**
   - `skill-swap-app/lib/screens/skill_detail_screen.dart` (modified)
   - Fixed navigation to SessionScreen
   - Date picker working
   - Time slot selection working

3. **Documentation**
   - `PAYMENT_GATEWAY_INTEGRATION.md`
   - `PAYMENT_INTEGRATION_SUMMARY.md`
   - `SLOT_BOOKING_FIX.md`
   - `CREDITS_MEDIA_RATINGS_VERIFICATION_REPORT.md`

### Modified Files
- Credit system services
- Session booking screens
- Theme colors updated

---

## 🔄 Typical Workflow

For future updates, follow this workflow:

```bash
# 1. Make your changes in code

# 2. Check what changed
git status

# 3. Stage changes
git add .

# 4. Commit with message
git commit -m "feat: Add new feature description"

# 5. Push to GitHub
git push

# Done! ✅
```

---

## 💡 Commit Message Best Practices

Use conventional commit format:

```
feat: Add new feature
fix: Fix bug
docs: Update documentation
style: Format code
refactor: Refactor code
test: Add tests
chore: Update dependencies
```

Examples:
```bash
git commit -m "feat: Add UPI payment integration"
git commit -m "fix: Resolve slot booking navigation issue"
git commit -m "docs: Update README with setup instructions"
git commit -m "style: Update theme colors to brown palette"
```

---

## 🆘 Troubleshooting

### Problem: "fatal: not a git repository"
**Solution**: You're not in the project folder. Navigate to:
```bash
cd D:\skillswap\skill-swap-app
```

### Problem: "Permission denied"
**Solution**: Use Personal Access Token instead of password

### Problem: "Updates were rejected"
**Solution**: Pull first, then push:
```bash
git pull origin main
git push
```

### Problem: "Merge conflict"
**Solution**: 
1. Open conflicted files
2. Resolve conflicts manually
3. Stage and commit:
```bash
git add .
git commit -m "fix: Resolve merge conflicts"
git push
```

### Problem: Git command not found
**Solution**: Install Git from https://git-scm.com/downloads

---

## 📱 Using GitHub Desktop (Alternative)

If you prefer a GUI:

1. Download **GitHub Desktop**: https://desktop.github.com/
2. Install and sign in with your GitHub account
3. Click **"Add"** → **"Add Existing Repository"**
4. Browse to `D:\skillswap\skill-swap-app`
5. Click **"Commit to main"** (bottom left)
6. Click **"Push origin"** (top right)

---

## 🎉 Success Checklist

After pushing, verify:

- [ ] Go to https://github.com/Janani-TG/[your-repo-name]
- [ ] See all your files listed
- [ ] Check the commit message appears
- [ ] Verify the timestamp is recent
- [ ] Click on a file to see the code
- [ ] Check that documentation files are visible

---

## 📊 Repository Structure on GitHub

Your repository will look like this:

```
skillswap/
├── .github/
├── android/
├── ios/
├── lib/
│   ├── models/
│   ├── screens/
│   │   ├── credits_screen.dart ✨ (Updated)
│   │   ├── skill_detail_screen.dart ✨ (Updated)
│   │   ├── session_screen.dart
│   │   └── ...
│   ├── services/
│   └── widgets/
├── web/
├── windows/
├── PAYMENT_GATEWAY_INTEGRATION.md ✨ (New)
├── SLOT_BOOKING_FIX.md ✨ (New)
├── CREDITS_MEDIA_RATINGS_VERIFICATION_REPORT.md ✨ (New)
├── pubspec.yaml
└── README.md
```

---

## 🔗 Useful Links

- **Your GitHub Profile**: https://github.com/Janani-TG
- **GitHub Docs**: https://docs.github.com/
- **Git Cheat Sheet**: https://education.github.com/git-cheat-sheet-education.pdf
- **Personal Access Tokens**: https://github.com/settings/tokens

---

## 📝 Next Steps After Pushing

1. **Add README.md** with project description
2. **Add .gitignore** to exclude build files (already exists)
3. **Create branches** for new features
4. **Set up GitHub Actions** for CI/CD (optional)
5. **Add collaborators** if working in a team
6. **Enable GitHub Pages** for documentation (optional)

---

## 🎯 Summary

**To push your code right now, run these commands:**

```bash
# Navigate to project
cd D:\skillswap\skill-swap-app

# Stage all changes
git add .

# Commit with message
git commit -m "feat: Add UPI payment gateway and fix slot booking"

# Push to GitHub (first time)
git branch -M main
git push -u origin main
```

**If you don't have a remote yet:**

```bash
# Add remote (replace with your actual repo URL)
git remote add origin https://github.com/Janani-TG/skillswap.git

# Then push
git branch -M main
git push -u origin main
```

---

**Created**: May 7, 2026  
**For**: Janani-TG  
**Project**: SkillSwap App  
**Status**: Ready to Push! 🚀
