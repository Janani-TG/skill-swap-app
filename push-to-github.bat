@echo off
echo ========================================
echo  SkillSwap - Push to GitHub
echo ========================================
echo.

cd skill-swap-app

echo [1/5] Checking Git status...
git status
echo.

echo [2/5] Staging all changes...
git add .
echo.

echo [3/5] Creating commit...
git commit -m "feat: Add UPI payment gateway and fix slot booking - Implemented UPI payment system with multiple payment options - Added payment options bottom sheet (UPI, Card, Wallets) - Fixed slot booking navigation from skill detail to session screen - Added date picker and time slot selection - Updated theme colors to white, light brown, and pastel brown - Fixed credit system flow (credits not deducted on request) - All features tested and working on Chrome"
echo.

echo [4/5] Checking remote repository...
git remote -v
echo.

echo [5/5] Pushing to GitHub...
echo.
echo NOTE: If this is your first push, you may need to set up the remote first.
echo Run: git remote add origin https://github.com/Janani-TG/skillswap.git
echo.
echo Press any key to push to GitHub...
pause > nul

git push -u origin main

echo.
echo ========================================
echo  Push Complete! Check GitHub:
echo  https://github.com/Janani-TG
echo ========================================
pause
