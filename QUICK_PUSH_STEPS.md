# Quick Push to GitHub - 3 Simple Steps

**Your GitHub**: https://github.com/Janani-TG

---

## 🚀 Method 1: Using the Batch File (Easiest)

1. **Double-click** `push-to-github.bat` file
2. Follow the prompts
3. Done! ✅

---

## 💻 Method 2: Using Command Line

Open **Command Prompt** or **PowerShell** and run:

### Step 1: Navigate to Project
```bash
cd D:\skillswap\skill-swap-app
```

### Step 2: Stage, Commit, and Push
```bash
git add .
git commit -m "feat: Add UPI payment and fix slot booking"
git push
```

**That's it!** ✅

---

## 🆕 First Time Setup (Only if needed)

If you haven't set up the remote repository yet:

### 1. Create Repository on GitHub
- Go to https://github.com/Janani-TG
- Click **"+"** → **"New repository"**
- Name: `skillswap`
- Click **"Create repository"**

### 2. Link Your Local Code
```bash
cd D:\skillswap\skill-swap-app
git remote add origin https://github.com/Janani-TG/skillswap.git
git branch -M main
git push -u origin main
```

---

## 🔐 Authentication

When prompted for credentials:
- **Username**: Janani-TG
- **Password**: Use **Personal Access Token** (not your GitHub password)

### Get Personal Access Token:
1. Go to https://github.com/settings/tokens
2. Click **"Generate new token (classic)"**
3. Name: "SkillSwap Dev"
4. Check: **"repo"**
5. Click **"Generate token"**
6. **Copy the token** and use it as password

---

## ✅ Verify Success

After pushing, check:
1. Go to https://github.com/Janani-TG
2. Click your repository
3. See your files! 🎉

---

## 📝 What You're Pushing

- ✅ UPI Payment Gateway
- ✅ Slot Booking Fix
- ✅ Updated Theme Colors
- ✅ Documentation Files
- ✅ All Recent Changes

---

## 🆘 Need Help?

Read the detailed guide: `GITHUB_PUSH_GUIDE.md`

---

**Ready to push?** Just run the commands above! 🚀
