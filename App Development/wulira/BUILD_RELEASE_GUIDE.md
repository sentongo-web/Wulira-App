# Wulira App - Build & Release Preparation Guide

## Pre-Launch Checklist

Before you build the final release APK/Bundle for Play Store, follow this comprehensive guide.

---

## Step 1: Update Version Number

**File:** `pubspec.yaml`

**Current:**
```yaml
version: 1.0.0+1
```

**Explanation:**
- `1.0.0` = User-visible version (major.minor.patch)
- `+1` = Build number (increment each release)

**For first Play Store launch, keep `1.0.0+1`**

**Future releases:**
```yaml
version: 1.0.1+2  # Bug fixes
version: 1.1.0+3  # Minor features
version: 2.0.0+4  # Major update
```

---

## Step 2: Verify API Levels

**File:** `android/app/build.gradle.kts`

**Current Status:**
```
minSdk = flutter.minSdkVersion (from Flutter)
targetSdk = flutter.targetSdkVersion (from Flutter)
```

**What this means:**
- `minSdk` = Lowest Android version supported (API 21 = Android 5.0)
- `targetSdk` = Latest Android version tested (API 36 = Android 16)

**For Play Store, you need:**
- ✓ Target API: 36 (2025+ requirement)
- ✓ Min API: 21+ (for broad device support)

**Check current values:**
```powershell
cd "D:\App Development\wulira"
flutter run -v  # Check build output for API levels
```

---

## Step 3: Review Permissions

**File:** `android/app/src/main/AndroidManifest.xml`

**Check what permissions are declared:**

```powershell
# Open and review the manifest
notepad android/app/src/main/AndroidManifest.xml
```

**Expected permissions for Wulira:**
```xml
<!-- Required -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- For Text-to-Speech -->
<uses-permission android:name="android.permission.RECORD_AUDIO" />

<!-- Not needed (remove if present) -->
<!-- No location, camera, or contact permissions -->
```

**Why Play Store cares:**
- Each permission requires user approval
- Excessive permissions = app rejected
- Unused permissions = app rejected
- Be honest about why you need each permission

---

## Step 4: Test on Multiple Emulator API Levels

### Test on API 21 (Minimum)

```powershell
# Create or use API 21 emulator
flutter emulators

# If no API 21 emulator exists, create one:
# Android Studio → Tools → Device Manager → Create New Device
# Select Pixel 3 → API 21 (Lollipop)

# Launch and test
flutter emulators --launch <api-21-emulator-name>
flutter run -d <emulator-id>

# Test checklist:
# □ App launches without crash
# □ All buttons work
# □ No layout issues (text readable, buttons clickable)
# □ Audio plays correctly
# □ Database functions
# □ Close and reopen - data persists
```

### Test on API 36 (Current)

```powershell
# Launch current emulator
flutter emulators --launch Medium_Phone_API_36.1
flutter run -d emulator-5554

# Test checklist:
# □ Everything works on latest Android
# □ Permissions work correctly
# □ No warnings or errors
```

### Test on Tablet Emulator (Optional)

```powershell
# Test responsive design
# Android Studio → Tools → Device Manager → Create New Device
# Select Pixel Tablet → API 36

# Test:
# □ Layout works in landscape
# □ Text is readable
# □ Buttons accessible
```

---

## Step 5: Clean Build

```powershell
cd "D:\App Development\wulira"

# Remove old build artifacts
flutter clean

# Get fresh dependencies
flutter pub get

# Analyze code for issues
flutter analyze

# Run tests (if any exist)
flutter test
```

**Expected output:**
```
✓ Cleaning complete
✓ Got dependencies
✓ Analyzing... (no errors)
✓ Tests passed
```

---

## Step 6: Create Signing Key

**IMPORTANT:** Do this ONCE and keep the key safe!

### Generate Keystore File

```powershell
# Navigate to Android app directory
cd "D:\App Development\wulira\android\app"

# Generate signing key (one-time setup)
keytool -genkey -v -keystore wulira-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias wulira-upload-key
```

**When prompted, enter:**
```
Keystore password: [Create strong password - WRITE THIS DOWN!]
Key password: [Same as keystore password]
First name: Paul
Last name: Sentongo
Organization Unit: App Development
Organization: Sentongo
City: Kampala
State/Province: Kampala
Country: UG
```

**Verification:**
```
? Is this correct? yes

Generating 2048 bit RSA key pair and self-signed certificate...
```

**Result:** New file `wulira-release-key.jks` created

### Secure the Key File

```powershell
# Move to safe location (parent of Git repo)
Move-Item "wulira-release-key.jks" "D:\App Development\wulira-release-key.jks"

# Create backup on external drive/cloud
# Store passwords in secure location (password manager)

# NEVER commit to GitHub
# Add to .gitignore
echo "*.jks" >> .gitignore
```

---

## Step 7: Configure Signing in Gradle

**File:** `android/app/build.gradle.kts`

Replace this section with your signing configuration:

```kotlin
android {
    // ...existing code...

    // Add this section BEFORE buildTypes:
    signingConfigs {
        create("release") {
            keyAlias = "wulira-upload-key"
            keyPassword = "YOUR_KEY_PASSWORD_HERE"  // Replace with your password
            storeFile = file("../../../wulira-release-key.jks")  // Path to your .jks file
            storePassword = "YOUR_KEYSTORE_PASSWORD_HERE"  // Replace with your password
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            // Other settings...
        }
    }
}
```

**⚠️ SECURITY WARNING:**
- This puts passwords in code (temporary for testing)
- NEVER commit this to GitHub!
- Before pushing to GitHub, revert this section
- Use environment variables in production

**Alternative: Use Gradle Properties (More Secure)**

Create: `android/local.properties`

```properties
WULIRA_KEYSTORE_PATH=../../../wulira-release-key.jks
WULIRA_KEYSTORE_PASSWORD=your_keystore_password
WULIRA_KEY_ALIAS=wulira-upload-key
WULIRA_KEY_PASSWORD=your_key_password
```

Update `build.gradle.kts`:

```kotlin
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(rootProject.file("local.properties")))

android {
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties['WULIRA_KEY_ALIAS']
            keyPassword = keystoreProperties['WULIRA_KEY_PASSWORD']
            storeFile = file(keystoreProperties['WULIRA_KEYSTORE_PATH'])
            storePassword = keystoreProperties['WULIRA_KEYSTORE_PASSWORD']
        }
    }
}
```

**And add to `.gitignore`:**
```
local.properties
*.jks
```

---

## Step 8: Build Release APK

```powershell
cd "D:\App Development\wulira"

# Build release APK
flutter build apk --release

# Wait for build to complete...
# Output: build/app/outputs/flutter-apk/app-release.apk
```

**Build output:**
```
✓ Built build\app\outputs\flutter-apk\app-release.apk
```

**File size check:**
```powershell
# Check file size (should be < 100MB)
(Get-Item "build\app\outputs\flutter-apk\app-release.apk").Length / 1MB
```

---

## Step 9: Build App Bundle (Recommended)

**App Bundle is preferred for Play Store** (smaller downloads)

```powershell
cd "D:\App Development\wulira"

# Build App Bundle
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

**Verification:**
```powershell
# Check if file exists
Get-ChildItem "build\app\outputs\bundle\release\app-release.aab"

# Check file size
(Get-Item "build\app\outputs\bundle\release\app-release.aab").Length / 1MB
```

---

## Step 10: Test the Release Build

### Install Release APK on Emulator

```powershell
# Install the APK
adb install "build\app\outputs\flutter-apk\app-release.apk"

# Open the app
adb shell am start -n com.wulira.wulira/.MainActivity

# Test thoroughly:
# □ App launches
# □ All features work
# □ No console errors
# □ Performance is smooth
# □ Audio quality is good
# □ Database queries fast
```

### Check for Crashes

```powershell
# Monitor log for crashes
adb logcat | findstr "CRASH"

# If you see crashes:
# 1. Note the error message
# 2. Go back to debug build
# 3. Fix the issue
# 4. Rebuild release
```

---

## Step 11: Version Control

```powershell
cd "D:\App Development\wulira"

# Add the guides and updated files
git add PRIVACY_POLICY.md SCREENSHOTS_GRAPHICS_GUIDE.md .gitignore

# Commit before release build
git commit -m "Prepare for Play Store release - add policies and guides"

# Push to GitHub
git push

# Tag this version
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

---

## Step 12: Final Checklist Before Uploading

### Code Quality
- [ ] No console errors
- [ ] No warnings in build
- [ ] Code is tested
- [ ] No debug mode active
- [ ] No test data in app

### Legal
- [ ] Privacy Policy created
- [ ] README explains app well
- [ ] No misleading claims
- [ ] No copyright infringement

### Technical
- [ ] Version: 1.0.0+1 in pubspec.yaml
- [ ] API levels correct (min 21, target 36)
- [ ] Permissions minimal and justified
- [ ] No crashes on API 21 or API 36
- [ ] App size < 100MB
- [ ] Signing key secure

### Store Assets
- [ ] App icon: 512x512 PNG
- [ ] Feature graphic: 1024x500 JPG
- [ ] Screenshots: 4-8 at 1080x1920px
- [ ] Descriptions written
- [ ] Content rating completed
- [ ] Privacy policy link ready

### Files Ready
- [ ] app-release.aab built successfully
- [ ] Privacy policy saved
- [ ] Screenshots organized
- [ ] Guides committed to GitHub
- [ ] Backup of signing key made

---

## Step 13: Upload to Play Console

### Create Release

1. Go to: https://play.google.com/console
2. Select your app "Wulira App"
3. Left menu → **Releases** → **Create new release**
4. Choose: **Closed Testing** (first time)

### Upload Bundle

1. Click **Upload**
2. Select: `build/app/outputs/bundle/release/app-release.aab`
3. Wait for processing (usually 30 seconds)
4. Accept diagnostics

### Complete Release Info

```
Version name: 1.0.0
Version code: 1

Release notes:
Wulira 1.0.0 - Initial Release

Learn Luganda with interactive lessons, quizzes, and flashcards!

Features:
✓ Interactive lessons from beginner to intermediate
✓ Quizzes to test your knowledge  
✓ Flashcard system for quick reviews
✓ Real audio pronunciation by native speakers
✓ Track your learning progress
✓ Dark and light themes
✓ Works offline

Perfect for tourists, visitors, and language learners visiting Uganda!

Developed by Paul Sentongo
```

### Submit for Review

1. Scroll down → Review all requirements
2. Confirm:
   - [ ] Content rating done
   - [ ] Privacy policy added
   - [ ] App description complete
   - [ ] Screenshots uploaded
   - [ ] Icon uploaded
3. Click **Submit for review**
4. Status: **Pending review**

---

## Step 14: After Submission

### What to Do

1. **Save confirmation email** (has tracking ID)
2. **Monitor Play Console** → Check status daily
3. **Watch for emails** from Google Play
4. **Prepare responses** to any rejection feedback
5. **Don't panic** if rejected - fix and resubmit

### Timeline

```
Hour 0:    Submitted to review
Hour 4-8:  Initial scan (malware, viruses)
Hour 24:   Human review begins
Hour 48:   Most decisions made
Hour 72:   Final decision/feedback email
Hour 72+:  Published (if approved)
```

### If Approved ✓

```
1. App appears in Play Store search
2. Users can download and review
3. Check Analytics for:
   - Downloads
   - Crash rates
   - User ratings
   - Geographic distribution
4. Monitor reviews and respond
5. Plan next update
```

### If Rejected ✗

```
1. Read feedback email carefully
2. Common reasons:
   - Crashes on startup
   - No privacy policy
   - Misleading description
   - Target API too low
3. Fix the issue
4. Increment version: 1.0.0 → 1.0.1
5. Rebuild and resubmit
6. Expect 24-72 hour review again
```

---

## Quick Command Reference

```powershell
# Clean and rebuild
flutter clean; flutter pub get

# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release

# Create signing key
keytool -genkey -v -keystore wulira-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias wulira-upload-key

# Install release APK
adb install build/app/outputs/flutter-apk/app-release.apk

# Check logs
adb logcat

# Verify file sizes
(Get-Item "build/app/outputs/bundle/release/app-release.aab").Length / 1MB
```

---

## Troubleshooting

### Issue: Build fails with "keystore not found"
**Solution:**
- Ensure signing key path is correct in build.gradle.kts
- Check file exists at specified location
- Rebuild after fixing path

### Issue: App crashes after upload to Play Console
**Solution:**
- Test on physical device with same Android version
- Check logs with: `adb logcat | findstr "CRASH"`
- Fix bug, increment version, rebuild, resubmit

### Issue: "Targeted API level is too low"
**Solution:**
- Play Store requires target API 36
- Update flutter (handles this automatically)
- Or manually set targetSdk in build.gradle.kts

### Issue: APK/Bundle is too large (> 100MB)
**Solution:**
- Check what's including large files
- Enable ProGuard/R8 minification
- Remove unused assets
- Use Play Instant for testing only

---

## Success Criteria

Your app is ready to launch when:

✓ Builds without errors
✓ No crashes on API 21 and API 36
✓ All features work correctly
✓ APK/Bundle < 100MB
✓ Signing key created and secured
✓ Privacy policy written
✓ Screenshots captured
✓ Graphics prepared
✓ Version number set to 1.0.0
✓ Git repository updated
✓ Ready for Play Console upload

---

**You're ready to launch Wulira to the world! 🚀**

Next step: Go to Google Play Console and upload your App Bundle!


