@echo off
echo ========================================
echo  Pushing SkillSwap to GitHub
echo ========================================
echo.

echo [Step 1/5] Adding all files...
git add .

echo [Step 2/5] Committing changes...
git commit -m "feat: Add UPI payment gateway and fix slot booking - Implemented UPI payment system with multiple payment options - Fixed slot booking navigation issue - Updated theme colors - All features tested and working"

echo [Step 3/5] Setting branch to main...
git branch -M main

echo [Step 4/5] Adding remote repository...
git remote add origin https://github.com/Janani-TG/skill-swap-app.git

echo [Step 5/5] Pushing to GitHub...
git push -u origin main

echo.
echo ========================================
echo  SUCCESS! Check your repository at:
echo  https://github.com/Janani-TG/skill-swap-app
echo ========================================
echo.
pause
