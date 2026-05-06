# Push Your Code to GitHub - Simple Instructions

**Your Repository**: https://github.com/Janani-TG/skill-swap-app

---

## 🚀 Method 1: Use the Batch File (EASIEST!)

1. Go to folder: `D:\skillswap\skill-swap-app`
2. **Double-click** the file: `push-to-github.bat`
3. Wait for it to complete
4. Done! ✅

---

## 💻 Method 2: Copy-Paste Commands

Open **Command Prompt** or **PowerShell**, then copy and paste these commands **one by one**:

```bash
cd D:\skillswap\skill-swap-app
```

```bash
git add .
```

```bash
git commit -m "feat: Add UPI payment and fix slot booking"
```

```bash
git branch -M main
```

```bash
git remote add origin https://github.com/Janani-TG/skill-swap-app.git
```

```bash
git push -u origin main
```

---

## 🔐 When Asked for Credentials

**Username**: `Janani-TG`  
**Password**: Use your **Personal Access Token** (not your GitHub password)

### Don't have a token? Get one here:
1. Go to: https://github.com/settings/tokens
2. Click **"Generate new token (classic)"**
3. Name: `SkillSwap`
4. Check: **"repo"**
5. Click **"Generate token"**
6. **COPY IT** (you won't see it again!)
7. Use this as your password

---

## ✅ Verify It Worked

After pushing:
1. Go to: https://github.com/Janani-TG/skill-swap-app
2. Refresh the page
3. You should see all your files! 🎉

---

## 🆘 If You Get an Error

### Error: "remote origin already exists"
Run this first:
```bash
git remote remove origin
```
Then try the push commands again.

### Error: "Permission denied"
You need a Personal Access Token (see above).

### Error: "Updates were rejected"
Run this first:
```bash
git pull origin main --allow-unrelated-histories
```
Then push again:
```bash
git push -u origin main
```

---

## 📝 What You're Pushing

Your code includes:
- ✅ UPI Payment Gateway
- ✅ Slot Booking Fix
- ✅ Updated Theme Colors
- ✅ All Documentation
- ✅ Complete Flutter App

---

**Ready?** Just double-click `push-to-github.bat` or run the commands! 🚀
