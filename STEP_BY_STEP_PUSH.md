# Step-by-Step: Push to GitHub

**Repository**: https://github.com/Janani-TG/skill-swap-app

---

## 🎯 Choose Your Method

### ⚡ FASTEST: Use the Batch File

```
1. Open folder: D:\skillswap\skill-swap-app
2. Find file: push-to-github.bat
3. Double-click it
4. Done! ✅
```

### 💻 MANUAL: Use Command Line

Follow these steps **exactly**:

---

## Step 1️⃣: Open Command Prompt

- Press `Windows Key + R`
- Type: `cmd`
- Press `Enter`

---

## Step 2️⃣: Navigate to Project

Copy and paste this command:

```bash
cd D:\skillswap\skill-swap-app
```

Press `Enter`

---

## Step 3️⃣: Add All Files

Copy and paste:

```bash
git add .
```

Press `Enter`

**What this does**: Stages all your changes for commit

---

## Step 4️⃣: Create Commit

Copy and paste:

```bash
git commit -m "feat: Add UPI payment and fix slot booking"
```

Press `Enter`

**What this does**: Creates a snapshot of your changes

---

## Step 5️⃣: Set Branch Name

Copy and paste:

```bash
git branch -M main
```

Press `Enter`

**What this does**: Renames your branch to "main"

---

## Step 6️⃣: Connect to GitHub

Copy and paste:

```bash
git remote add origin https://github.com/Janani-TG/skill-swap-app.git
```

Press `Enter`

**What this does**: Links your local code to GitHub repository

**Note**: If you get "remote origin already exists" error, run this first:
```bash
git remote remove origin
```
Then try Step 6 again.

---

## Step 7️⃣: Push to GitHub

Copy and paste:

```bash
git push -u origin main
```

Press `Enter`

**What this does**: Uploads your code to GitHub

---

## 🔐 Authentication

When prompted:

```
Username: Janani-TG
Password: [Your Personal Access Token]
```

### Don't have a token?

1. Open: https://github.com/settings/tokens
2. Click: **"Generate new token (classic)"**
3. Name: `SkillSwap Development`
4. Check: ☑️ **repo** (Full control of private repositories)
5. Scroll down, click: **"Generate token"**
6. **COPY THE TOKEN** (green text) - You won't see it again!
7. Paste it as your password

---

## ✅ Success!

You should see something like:

```
Enumerating objects: 100, done.
Counting objects: 100% (100/100), done.
Delta compression using up to 8 threads
Compressing objects: 100% (80/80), done.
Writing objects: 100% (100/100), 1.5 MiB | 500 KiB/s, done.
Total 100 (delta 20), reused 0 (delta 0)
To https://github.com/Janani-TG/skill-swap-app.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

---

## 🎉 Verify on GitHub

1. Open browser
2. Go to: https://github.com/Janani-TG/skill-swap-app
3. Refresh the page
4. You should see:
   - ✅ All your folders (android, ios, lib, etc.)
   - ✅ All your files
   - ✅ Your commit message
   - ✅ "Updated X seconds/minutes ago"

---

## 🆘 Common Issues

### Issue 1: "git: command not found"
**Solution**: Install Git from https://git-scm.com/downloads

### Issue 2: "remote origin already exists"
**Solution**: Run this first:
```bash
git remote remove origin
```
Then continue from Step 6

### Issue 3: "Permission denied"
**Solution**: You need a Personal Access Token (see Authentication section above)

### Issue 4: "Updates were rejected"
**Solution**: Run this:
```bash
git pull origin main --allow-unrelated-histories
```
Then try Step 7 again

### Issue 5: "Nothing to commit"
**Solution**: You've already committed! Skip to Step 7 (push)

---

## 📊 What Gets Pushed

Your repository will contain:

```
skill-swap-app/
├── android/              (Android app files)
├── ios/                  (iOS app files)
├── lib/                  (Flutter code)
│   ├── models/
│   ├── screens/
│   │   ├── credits_screen.dart ✨ (Updated)
│   │   ├── skill_detail_screen.dart ✨ (Updated)
│   │   └── ...
│   ├── services/
│   └── widgets/
├── web/                  (Web files)
├── windows/              (Windows files)
├── pubspec.yaml          (Dependencies)
├── README.md             (Project info)
└── Documentation files ✨ (New)
```

---

## 🔄 Future Updates

After the first push, updating is easier:

```bash
cd D:\skillswap\skill-swap-app
git add .
git commit -m "Your update message"
git push
```

That's it! Just 3 commands for future updates.

---

## 💡 Pro Tips

1. **Commit often**: Make small, frequent commits
2. **Good messages**: Use clear commit messages
3. **Pull first**: Before pushing, run `git pull` to get latest changes
4. **Check status**: Run `git status` to see what changed
5. **View history**: Run `git log --oneline` to see commit history

---

## 📱 Alternative: GitHub Desktop

Prefer a visual interface?

1. Download: https://desktop.github.com/
2. Install and sign in
3. Click: **"Add"** → **"Add Existing Repository"**
4. Browse to: `D:\skillswap\skill-swap-app`
5. Click: **"Commit to main"**
6. Click: **"Push origin"**

Done! ✅

---

## 🎯 Quick Reference Card

```
┌─────────────────────────────────────┐
│  Git Commands Quick Reference       │
├─────────────────────────────────────┤
│  git status      → Check changes    │
│  git add .       → Stage all files  │
│  git commit -m   → Save snapshot    │
│  git push        → Upload to GitHub │
│  git pull        → Download updates │
│  git log         → View history     │
└─────────────────────────────────────┘
```

---

**Need help?** Read `PUSH_INSTRUCTIONS.md` for more details.

**Ready to push?** Follow the steps above! 🚀

---

**Created**: May 7, 2026  
**For**: Janani-TG  
**Repository**: skill-swap-app
