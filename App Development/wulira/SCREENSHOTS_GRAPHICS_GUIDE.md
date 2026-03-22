# Wulira App - Screenshots & Graphics Guide for Play Store

## Part 1: Taking Screenshots from Android Emulator

### Method 1: Using Android Debug Bridge (ADB)

**Step 1: Open PowerShell and connect to emulator**

```powershell
# Check if adb is available
adb devices

# You should see:
# emulator-5554    device
```

**Step 2: Take a screenshot**

```powershell
# Take screenshot and save to emulator storage
adb shell screencap -p /sdcard/wulira_screenshot.png

# Pull the screenshot to your computer
adb pull /sdcard/wulira_screenshot.png "D:\App Development\wulira\playstore_assets\screenshots\"

# List available screenshots
adb shell ls /sdcard/*.png
```

**Step 3: Multiple screenshots**

```powershell
# Take 8 screenshots for Play Store (min 4, max 8)
adb shell screencap -p /sdcard/screenshot_1_home.png
adb pull /sdcard/screenshot_1_home.png "D:\App Development\wulira\playstore_assets\screenshots\01_home.png"

adb shell screencap -p /sdcard/screenshot_2_lesson.png
adb pull /sdcard/screenshot_2_lesson.png "D:\App Development\wulira\playstore_assets\screenshots\02_lesson.png"

adb shell screencap -p /sdcard/screenshot_3_quiz.png
adb pull /sdcard/screenshot_3_quiz.png "D:\App Development\wulira\playstore_assets\screenshots\03_quiz.png"

adb shell screencap -p /sdcard/screenshot_4_flashcard.png
adb pull /sdcard/screenshot_4_flashcard.png "D:\App Development\wulira\playstore_assets\screenshots\04_flashcard.png"

adb shell screencap -p /sdcard/screenshot_5_progress.png
adb pull /sdcard/screenshot_5_progress.png "D:\App Development\wulira\playstore_assets\screenshots\05_progress.png"

adb shell screencap -p /sdcard/screenshot_6_premium.png
adb pull /sdcard/screenshot_6_premium.png "D:\App Development\wulira\playstore_assets\screenshots\06_premium.png"

adb shell screencap -p /sdcard/screenshot_7_theme.png
adb pull /sdcard/screenshot_7_theme.png "D:\App Development\wulira\playstore_assets\screenshots\07_theme.png"

adb shell screencap -p /sdcard/screenshot_8_success.png
adb pull /sdcard/screenshot_8_success.png "D:\App Development\wulira\playstore_assets\screenshots\08_success.png"
```

### Method 2: Using Android Studio Built-in Screenshot Tool

1. **In Android Studio:**
   - Open "Logcat" tab at the bottom
   - Click the emulator window (to focus it)
   - Press `Ctrl + S` or use Tools → Screenshots

2. **Save to:**
   - Default location: Your Downloads folder
   - Move to: `D:\App Development\wulira\playstore_assets\screenshots\`

### Method 3: Using Windows Snipping Tool (Manual)

1. Open Android Emulator window
2. Press `Win + Shift + S` to open Snipping Tool
3. Capture the screen
4. Save as PNG

---

## Part 2: Screenshot Requirements for Play Store

### Dimensions
- **Phone/Tablet (7-inch):** 1080 x 1920 pixels (portrait)
- **Phone/Tablet (10-inch):** 1440 x 2560 pixels (landscape)
- **Format:** PNG or JPG

### Number of Screenshots
- **Minimum:** 4 screenshots
- **Maximum:** 8 screenshots
- **Recommended:** 6-8 screenshots

### What Each Screenshot Should Show

**Screenshot 1: Home Screen**
- Show app title/logo
- Main navigation
- Key feature buttons
- Make it inviting

**Screenshot 2: Lesson Screen**
- Show a lesson in progress
- Display lesson content
- Show user interaction
- Highlight educational value

**Screenshot 3: Quiz Feature**
- Show quiz interface
- Display a question
- Show answer options
- Highlight engagement

**Screenshot 4: Flashcard Feature**
- Show flashcard setup
- Display word with translation
- Show card flipping
- Highlight quick learning

**Screenshot 5: Progress Tracking**
- Show user statistics
- Display lessons completed
- Show achievement badges
- Highlight motivation/tracking

**Screenshot 6: Premium Content**
- Show premium features
- Display subscription benefits
- Show unlock mechanism
- Highlight value proposition

**Screenshot 7: Theme/Settings**
- Show dark theme option
- Show light theme option
- Display settings/preferences
- Highlight customization

**Screenshot 8: Success/Achievement**
- Show completion celebration
- Display unlocked content
- Show sharing options
- Highlight user satisfaction

### Screenshot Design Tips

✓ **DO:**
- Keep text large and readable
- Show actual app interface
- Use natural colors
- Focus on one feature per screenshot
- Add simple text overlays explaining benefits

❌ **DON'T:**
- Use blurry or low-quality images
- Show system notifications
- Include sensitive information
- Use too much text (hard to read at small size)
- Show blank/empty screens

---

## Part 3: Creating App Store Graphics

### 1. App Icon (512x512px required)

**Specifications:**
- Size: 512 x 512 pixels
- Format: PNG with alpha channel (transparency)
- Color mode: RGBA (32-bit)
- Safe area: Inner 438x438 square (keep important content here)
- No rounded corners (Android handles this)
- No drop shadows (avoid outside safe area)

**Design Tips:**
- Simple, bold design
- Recognizable at 48px (actual home screen size)
- Use contrasting colors
- Include "W" or language symbol
- Professional appearance

**Tools to Create:**
- Adobe Photoshop
- GIMP (free): https://www.gimp.org
- Figma (free): https://www.figma.com
- Canva: https://www.canva.com

**Example Design:**
```
Background: Gradient (Ugandan colors - yellow/red/blue)
Foreground: White "W" for Wulira or speech bubble icon
Text: None on icon
Style: Modern, minimal, playful
```

### 2. Feature Graphic (1024x500px required)

**Specifications:**
- Size: 1024 x 500 pixels
- Format: PNG or JPG
- File size: < 512 KB
- Contains promotional text
- Shows app benefit

**What It Should Show:**
- App name/logo
- Main benefit (e.g., "Learn Luganda in 30 Days")
- Attractive imagery
- Call to action (optional)

**Design Template:**
```
Left side (40%): App icon or mascot
Middle (20%): Vertical divider or gradient
Right side (40%): Bold text showing benefit

Example:
[Wulira Icon] | [Gradient] | [Text: "Master Luganda!"]
              |            | "Learn with interactive lessons"
```

**Tools:**
- Canva (has templates)
- Adobe Express (free)
- Photoshop
- GIMP

### 3. Preview Graphics (Optional)

For Play Store preview video (if you add one):
- Dimensions: 1920 x 1080 pixels
- Duration: 15-30 seconds
- Format: MP4 or WebM
- Shows app features in action

---

## Part 4: Directory Structure for Play Store Assets

Create this folder structure to organize everything:

```
D:\App Development\wulira\playstore_assets\
├── app_icon/
│   └── ic_launcher_512x512.png
├── feature_graphic/
│   └── feature_graphic_1024x500.jpg
├── screenshots/
│   ├── 01_home_1080x1920.png
│   ├── 02_lesson_1080x1920.png
│   ├── 03_quiz_1080x1920.png
│   ├── 04_flashcard_1080x1920.png
│   ├── 05_progress_1080x1920.png
│   ├── 06_premium_1080x1920.png
│   ├── 07_theme_1080x1920.png
│   └── 08_success_1080x1920.png
└── preview_video/
    └── preview_15sec.mp4
```

---

## Part 5: Step-by-Step to Prepare Graphics

### Step 1: Create the Folders

```powershell
# Create directory structure
mkdir "D:\App Development\wulira\playstore_assets\app_icon"
mkdir "D:\App Development\wulira\playstore_assets\feature_graphic"
mkdir "D:\App Development\wulira\playstore_assets\screenshots"
mkdir "D:\App Development\wulira\playstore_assets\preview_video"
```

### Step 2: Create App Icon

1. **Open design tool (GIMP/Figma/Canva)**
2. **Create new image: 512x512px**
3. **Design the icon:**
   - Ugandan flag colors (yellow, red, black, white, green)
   - Simple "W" letter or speech bubble
   - Center it in safe area
4. **Export as PNG (with transparency)**
5. **Save as:** `playstore_assets\app_icon\ic_launcher_512x512.png`

### Step 3: Create Feature Graphic

1. **Create new image: 1024x500px**
2. **Design layout:**
   - Left side: Your app icon (scaled down)
   - Right side: Bold text
3. **Add text:**
   - "Learn Luganda"
   - "Master the language of Uganda"
   - "Interactive lessons • Quizzes • Progress tracking"
4. **Export as JPG**
5. **Save as:** `playstore_assets\feature_graphic\feature_graphic_1024x500.jpg`

### Step 4: Take Screenshots

```powershell
# Make sure emulator is running
flutter devices

# Open Flutter app in emulator if not already open
# Take screenshots of each screen

# Navigate to each app screen:
# 1. Home screen
# 2. Lesson screen
# 3. Quiz screen
# 4. Flashcard screen
# 5. Progress screen
# 6. Premium screen
# 7. Settings (theme)
# 8. Success/Achievement

# For each screen, run:
adb shell screencap -p /sdcard/screenshot_[number]_[name].png
adb pull /sdcard/screenshot_[number]_[name].png "D:\App Development\wulira\playstore_assets\screenshots\"
```

### Step 5: Optimize Screenshots (Optional)

If images are too large, compress them:

```powershell
# Using built-in Windows tools or free tools like:
# - https://tinypng.com (online)
# - https://compressor.io (online)
# - ImageMagick (command line)

# Or use PowerShell with ImageMagick:
magick mogrify -quality 85 -resize 1080x1920 *.png
```

---

## Part 6: Uploading to Play Console

### In Google Play Console:

1. **Go to Store Listing section**
2. **Click "Store Listing" in left menu**

### Upload Screenshots:

1. **Scroll to "Screenshots" section**
2. **Select phone/tablet category**
3. **Click "Upload screenshots"**
4. **Upload 4-8 PNG images (1080x1920px)**
5. **Google automatically resizes for different devices**

### Upload Feature Graphic:

1. **Scroll to "Feature graphic" section**
2. **Click "Upload"**
3. **Select your JPG (1024x500px)**

### Upload App Icon:

1. **At top of Store Listing, click "Upload icon"**
2. **Select your PNG (512x512px)**
3. **Google auto-crops and resizes**

---

## Part 7: Text to Add to Each Screenshot (Optional)

You can add text overlays using design tools before uploading:

```
Screenshot 1: "LEARN LUGANDA"
Screenshot 2: "Interactive Lessons • Build Your Knowledge"
Screenshot 3: "Test Your Skills • Track Progress"
Screenshot 4: "Master Words • Quick Reviews"
Screenshot 5: "See Your Progress • Stay Motivated"
Screenshot 6: "Unlock Premium • Advanced Lessons"
Screenshot 7: "Customize • Light or Dark Mode"
Screenshot 8: "Celebrate • Share Your Success"
```

---

## Part 8: Asset Checklist

Before uploading to Play Store:

- [ ] App icon created (512x512px PNG with alpha)
- [ ] Feature graphic created (1024x500px JPG)
- [ ] 4-8 screenshots taken (1080x1920px PNG)
- [ ] All images are high quality
- [ ] No personal info in screenshots
- [ ] No system notifications visible
- [ ] Text is readable at small size
- [ ] Images show actual app interface
- [ ] No blurry or distorted images
- [ ] All files organized in playstore_assets folder
- [ ] File names clearly labeled

---

## Part 9: Quick Reference Commands

```powershell
# Check connected devices
adb devices

# Take single screenshot
adb shell screencap -p /sdcard/test.png

# Pull screenshot
adb pull /sdcard/test.png "D:\App Development\wulira\playstore_assets\screenshots\"

# List files on device
adb shell ls /sdcard/*.png

# Clear all screenshots
adb shell rm /sdcard/*.png

# Push file to device
adb push "C:\path\file.txt" /sdcard/

# Install APK via adb
adb install "build\app\outputs\flutter-apk\app-debug.apk"
```

---

## Part 10: Common Issues & Solutions

### Issue: Screenshot comes out blurry
**Solution:** 
- Ensure emulator is using high-resolution display
- Try different emulator skins
- Take screenshot from emulator UI button (Screen Record)

### Issue: Can't find adb
**Solution:**
```powershell
# Add to system PATH or use full path:
"C:\Users\[YourUsername]\AppData\Local\Android\Sdk\platform-tools\adb" devices
```

### Issue: Screenshot has Android status bar/navigation
**Solution:**
- Use crop tools to remove bars
- Or take fresh screenshot with app fullscreen

### Issue: Icon too small or hard to see
**Solution:**
- Redesign with bold, simple shapes
- Use high contrast colors
- Test at 48px size (home screen size)

---

## Final Checklist Before Store Submission

✓ App icon: 512x512 PNG with transparency
✓ Feature graphic: 1024x500 JPG
✓ Screenshots: 4-8 images at 1080x1920px
✓ All graphics professional quality
✓ No sensitive information
✓ All files properly named
✓ Folder structure organized
✓ Files ready for Play Console upload

---

Good luck with your Wulira App graphics! 🎨📱


