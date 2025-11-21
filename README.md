# MagicSlides Flutter Assignment

A Flutter application built for the MagicSlides Topic → PPT Generation Assignment.  
Implements **Supabase authentication**, **MagicSlides API integration**, **PDF/PPT preview**, **file downloading**, and **MVVM architecture**.

---

## 🚀 Features

### 🔐 Authentication (Supabase)
- Email + Password Signup
- Login
- Persistent session
- Logout

### 🏠 Home Screen
- Topic Input
- Template Selection (Default / Editable)
- Template Dropdown
- Slide Count (1–50)
- Language Selection
- Model Selection (gpt-4 / gpt-3.5)
- AI Images Toggle
- Image-per-slide Toggle
- Google Images / Google Text Toggles
- Watermark Fields
- Generate Button

### 📤 MagicSlides API Integration
- Uses POST `https://api.magicslides.app/public/api/ppt_from_topic`
- Builds full request body dynamically from UI selections
- Uses hardcoded accessId (placeholder until provided)

### 📄 Output
- PDF preview (if API returns PDF)
- PPTX download
- Open in browser

---

## 📦 Folder Structure (MVVM – Clean)
```
lib/
 ├── core/
 │    ├── constants/
 │    ├── services/
 │    └── models/
 ├── features/
 │    ├── auth/
 │    │    ├── view/
 │    │    └── viewmodel/
 │    ├── home/
 │    │    ├── view/
 │    │    └── viewmodel/
 │    └── generate/
 │         ├── view/
 │         └── viewmodel/
 └── main.dart
```

---

## 🔧 Setup Instructions

### 1. Install Packages
```
flutter pub get
```

### 2. Configure Supabase
Update values in:
```
lib/core/constants/constants.dart
```
- `supabaseUrl`
- `supabaseAnonKey`
- `magicSlidesEndpoint`
- `magicSlidesAccessId`

### 3. Add MagicSlides Access ID
Replace:
```
magicSlidesAccessId = "ACCESS_ID_NOT_PROVIDED";
```
with actual accessId once provided.

### 4. Run the App
```
flutter run
```

---

## 📱 APK
Generate release APK:
```
flutter build apk
```
APK will be available under:
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## ⚙️ Architecture
- MVVM (ChangeNotifier-based)
- Service Layer
- Clean UI separation
- PDF Preview using pdfx
- File download via Dio + path_provider

---

## ⚠️ Known Issues
- API cannot generate without the accessId.
- Some MagicSlides responses are PPTX; cannot preview directly (download only).
- Old Android versions may require storage permission.

---

## 👨‍💻 Author
Flutter Assignment Submission – MagicSlides
