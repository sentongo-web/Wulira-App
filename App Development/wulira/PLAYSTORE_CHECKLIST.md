# Google Play Store - Submission Checklist

## ✓ App Quality Requirements

### Functionality
- [ ] App launches without crashing
- [ ] All features work on Android 5.0+
- [ ] Navigation is smooth
- [ ] No performance issues
- [ ] Offline functionality works
- [ ] Database saves properly

### Testing Checklist
```
Test on Android 16 emulator:
□ Home screen loads
□ Lessons display correctly
□ Quizzes work and save progress
□ Flashcards flip and show answers
□ Audio plays properly
□ Progress tracking shows updates
□ Premium features show paywall
□ Theme switching works
□ App closes without errors
□ Restart app and progress is saved
```

---

## ✓ Store Listing Content

### 1. App Title
- **Length:** 50 characters max
- **Recommended:** "Wulira - Learn Luganda"
- **Avoid:** All caps, excessive punctuation

### 2. Short Description
- **Length:** 80 characters max
- **Example:** "Master Luganda language with interactive lessons and quizzes"

### 3. Full Description
- **Length:** 4000 characters max
- **Include:**
  - What the app does
  - Key features
  - Who it's for
  - Unique selling points
  - Your name (Paul Sentongo)
  - Version/update info

**Template:**
```
Wulira is your personal Luganda language teacher, designed for tourists, 
visitors, and anyone interested in learning Uganda's most spoken local language.

FEATURES:
• Interactive lessons from beginner to intermediate
• Quizzes to test your knowledge
• Flashcard system for quick reviews
• Real audio pronunciation by native speakers
• Track your learning progress
• Dark and light themes
• Works offline

PERFECT FOR:
- Tourists visiting Uganda
- Business travelers
- Language enthusiasts
- Cultural learners
- Expats living in Uganda

Developed by Paul Sentongo
Version 1.0.0
```

### 4. Screenshots (Need 4-8)
**Size:** 1080 x 1920px (portrait) or 2560 x 1440px (landscape)
**What to show:**
1. Home screen with app title
2. Lesson screen in action
3. Quiz interface
4. Flashcard feature
5. Progress tracking
6. Premium features
7. Settings/themes

**How to capture from emulator:**
```powershell
# Take screenshot from Android emulator
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png C:\Users\YourUsername\Pictures\
```

### 5. Feature Graphic
- **Size:** 1024 x 500px
- **Format:** PNG or JPG
- **Content:** Shows main benefit (e.g., "Learn Luganda in 30 days")
- **Design tips:**
  - Bold text
  - Eye-catching colors
  - Central focus

### 6. App Icon
- **Size:** 512 x 512px (minimum)
- **Format:** PNG (32-bit with alpha)
- **Rules:**
  - No rounded corners (system handles this)
  - No text or small details
  - Safe area: 438px center square
  - Should work at 48px too

---

## ✓ Categorization

### Category
- [ ] **Education** (recommended for language apps)
- Alternative: Lifestyle, Books & Reference

### Content Rating
Complete the IARC questionnaire:
1. Go to Play Console
2. Click "Content rating"
3. Fill form (about 5 minutes):
   - Violence: No
   - Profanity: No
   - Sexual content: No
   - Alcohol/Tobacco: No
   - Gambling: No
4. Get rating: **Everyone** or **3+**

### Audience
- [ ] Select "Not set" or "3+" for language learners
- [ ] Target audience: General
- [ ] Contains ads: No (if free with in-app purchase)

---

## ✓ Legal & Compliance

### Privacy Policy
**Required!** You need one for Play Store approval.

**Include:**
- What data you collect (None recommended for Wulira)
- How you use it
- Third-party services (Firebase, Analytics, etc.)
- User rights
- Contact info

**Create one:** Use free tools like:
- https://www.privacypolicygenerator.info
- https://www.freeprivacypolicy.com
- https://www.termsfeed.com

**Host it:** Make it accessible at a URL
- On your website
- Or host on GitHub Pages
- Provide the link in Play Console

### Example Privacy Policy Structure:
```
WULIRA APP PRIVACY POLICY

1. INFORMATION WE COLLECT
   - User progress (stored locally)
   - No personal data sent to servers
   - No tracking of location

2. HOW WE USE IT
   - All data stored on your device
   - Used only to save your learning progress
   - Never shared with third parties

3. CONTACT
   - Email: your-email@example.com
```

### Terms of Service (Optional but recommended)
- Limitations of liability
- User conduct rules
- Acceptable use policy

---

## ✓ Technical Requirements

### API Level
- [ ] Target API: 36 (latest stable)
- [ ] Min API: 21 (Android 5.0)
- [ ] Max API: No limit

**Current status (from pubspec.yaml):**
```
SDK: ^3.11.3
Min Android: API 16 (should update to 21+)
```

### File Size
- [ ] APK size: < 100MB
- [ ] Bundle size: < 500MB
- [ ] Wulira estimated: ~50MB

### Permissions Needed
```xml
REQUIRED FOR WULIRA:
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

OPTIONAL (if using):
<uses-permission android:name="android.permission.RECORD_AUDIO" /> (for TTS)
```

Check in: `android/app/src/main/AndroidManifest.xml`

### Device Compatibility
- [ ] Test on API 21 emulator (Android 5.0)
- [ ] Test on API 36 emulator (latest)
- [ ] Test on real Android phone if possible
- [ ] Landscape mode works
- [ ] All screen sizes supported

---

## ✓ Pricing & Distribution

### Pricing
- [ ] Select: **Free**
- [ ] If in-app purchases: Still free (in-app purchases are optional)
- [ ] Never: Bait-and-switch (don't advertise as free then make it paid)

### Distribution Countries
- [ ] Select: **All countries** (or specific if desired)
- [ ] Uganda (primary market)
- [ ] East Africa region
- [ ] Global (tourists want it worldwide)

### Sensitive Content
- [ ] Adult content: No
- [ ] Violence: No
- [ ] Hate speech: No
- [ ] Weapons: No
- [ ] Drugs: No

---

## ✓ Release Preparation

### Before Uploading

**Version Number**
```
In pubspec.yaml:
version: 1.0.0+1

First upload should be: 1.0.0 or 1.0.1
Never use 0.x.x for public launch
```

**App Bundle (AAB)**
```powershell
# Build command:
flutter build appbundle --release

# Creates: build/app/outputs/bundle/release/app-release.aab
```

**APK (Alternative - APK is for testing/sideload)**
```powershell
# If needed:
flutter build apk --release

# Creates: build/app/outputs/flutter-apk/app-release.apk
```

### Release Notes
Write 500 characters or less:
```
Wulira 1.0.0 - Initial Release

Learn Luganda with our new app! Features:
✓ Interactive lessons and quizzes
✓ Native speaker audio pronunciation
✓ Track your learning progress
✓ Works offline
✓ Beautiful dark/light themes

Perfect for tourists and language learners!
```

---

## ✓ Submission Process

### Step 1: Create Release
1. Go to Play Console
2. Select "Releases" in left menu
3. Choose "Closed testing" (first time)
4. Click "Create new release"

### Step 2: Upload Bundle
1. Click "Upload"
2. Select `app-release.aab`
3. Wait for processing

### Step 3: Review Info
- [ ] Version name: 1.0.0
- [ ] Version code: 1
- [ ] Release notes filled
- [ ] Permissions listed
- [ ] Min API is 21+

### Step 4: Complete Questionnaire
- [ ] Target API updated
- [ ] Alcohol/Tobacco: No
- [ ] Content rating: Completed
- [ ] Privacy policy: Added
- [ ] Export compliance: Reviewed

### Step 5: Submit
1. Review requirements
2. Click "Submit for review"
3. Status: "Pending review"

### Step 6: Wait for Approval
- **24-72 hours** for Google's review
- You'll get email notifications
- Check Play Console for feedback

### Timeline:
```
Hour 0: Submitted for review
Hour 4: Initial malware scan
Hour 24-48: Human review
Hour 48-72: Approved or rejected email
Hour 72+: Published to Play Store (if approved)
```

---

## ✓ After Approval

### Monitor These Metrics
```
In Play Console → Analytics:
- Downloads
- Uninstalls
- Crashes
- Ratings & Reviews
- User retention
- Revenue (if in-app purchases enabled)
```

### Fix Issues Fast
If crash rate > 1%:
1. Check logs in Play Console
2. Fix the bug
3. Increment version: 1.0.0 → 1.0.1
4. Resubmit (24-72 hour review again)

### Respond to Reviews
- Answer user questions
- Thank positive reviews
- Address complaints professionally
- Push fixes for reported bugs

---

## ✓ Important Reminders

⚠️ **SECURITY**
- Never commit `wulira-key.jks` to GitHub
- Store backup securely
- Don't share passwords
- Update privacy policy if you add tracking

⚠️ **STORE POLICIES**
- No misleading descriptions
- No spam or keyword stuffing
- No offensive content
- No malware or spyware
- No unauthorized data collection

⚠️ **COMPLIANCE**
- Disclose in-app purchases clearly
- Be honest about features
- Don't change core features after launch without notice
- Respond to reviews professionally

---

## Quick Submission Checklist

### Before You Hit Submit:
- [ ] App tested and crash-free
- [ ] APK/Bundle built successfully
- [ ] Version number updated
- [ ] Screenshots ready (4+ images)
- [ ] Icon and graphics ready
- [ ] Description written (4000 chars)
- [ ] Privacy policy created and online
- [ ] Content rating completed
- [ ] Permissions justified
- [ ] Target API 36, Min API 21+
- [ ] Release notes written
- [ ] All requirements reviewed one more time

### After Submission:
- [ ] Saved the receipt/confirmation email
- [ ] Checking email for updates
- [ ] Monitoring status in Play Console
- [ ] Preparing responses to questions
- [ ] Ready to fix any rejection issues
- [ ] Celebrating once approved! 🎉

---

## Support Resources

📚 **Official Docs:**
- https://developer.android.com/guide/playcore
- https://support.google.com/googleplay/android-developer

🎓 **Flutter Deployment:**
- https://flutter.dev/docs/deployment/android

📞 **Contact Support:**
- Play Console Help: support.google.com/googleplay
- Flutter Issues: github.com/flutter/flutter/issues

💡 **Pro Tips:**
- Launch on Friday morning for weekday review
- Test thoroughly before submitting (rejection takes time)
- Read all feedback carefully
- Be responsive to user reviews
- Plan next update based on user feedback

---

Good luck with your Wulira App launch! 🚀📱


