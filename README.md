## 🩺 HyperSensiFit — Mobile Health Application

**Description:**  
HyperSensiFit is a mobile-based application designed to help users predict their risk of hypertension and receive dietary recommendations aligns with Dietary Approaches to Stop Hypertension (DASH) diet.  
It uses a **custom K-Nearest Neighbor (KNN)** algorithm implemented directly in the app and processes health data against a locally stored **CSV dataset** — enabling full offline functionality.
It utilized the **Hypertension-risk-model (HRM)** dataset provided by MD Raihan Khan on kaggle.

**Key Features:**
- Predicts hypertension risk using user-inputted health data  
- KNN algorithm implemented natively 
- Offline processing with dataset stored locally in CSV format  
- Dietary recommendations aligns with Dietary Approaches to Stop Hypertension (DASH) diet for high-risk users  
- Stores user health data history locally for progress tracking  

**Tech Stack:**
- Flutter (Dart)
- KNN Model
- SQLite (for offline storage)

**Platforms:** Android (cross-platform ready)

**Download links:** 
- **Older phones:** https://github.com/hannabuilds/hypersensifit/releases/download/v1.0.0/app-armeabi-v7a-release.apk
- **Modern phones:** https://github.com/hannabuilds/hypersensifit/releases/download/v1.0.0/app-arm64-v8a-release.apk
- https://github.com/hannabuilds/hypersensifit/releases/download/v1.0.0/app-x86_64-release.apk
