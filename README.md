# Tatyassar (تتيسّر)

**Intelligent Decision Support System for Stress Management Through Personalized Therapeutic Interventions**

Tatyassar is a mobile application that provides university students with an accessible, chat-based interface for early psychological support. The app connects to an AI backend (IDSS) that detects emotional cues from student messages and generates personalized, empathetic therapeutic responses grounded in CBT and APA clinical guidelines.

---

## Project Structure

```
tatyassar/
├── lib/
│   ├── main.dart                        # App entry point
│   ├── app.dart                         # GetMaterialApp setup
│   ├── navigation_menu.dart             # Bottom nav (Chat / Profile)
│   ├── firebase_options.dart            # Firebase configuration
│   ├── bindings/
│   │   └── general_bindings.dart        # GetX dependency injection
│   ├── routes/
│   │   ├── routes.dart                  # Route name constants
│   │   └── app_routes.dart              # GetX page routes
│   ├── features/
│   │   ├── authentication/              # Login, signup, onboarding, password reset
│   │   │   ├── controllers/
│   │   │   ├── models/
│   │   │   └── screens/
│   │   ├── chat/                        # Chat interface (IDSS frontend)
│   │   │   └── screens/
│   │   │       ├── chat_screen.dart
│   │   │       └── widgets/
│   │   │           ├── bot_message.dart
│   │   │           ├── chat_appbar.dart
│   │   │           ├── typing_indicator.dart
│   │   │           └── user_message.dart
│   │   └── personalization/             # User profile and settings
│   │       ├── controllers/
│   │       ├── models/
│   │       └── screens/
│   ├── common/
│   │   ├── images/                      # Reusable image widgets
│   │   ├── styles/                      # Spacing and shadow styles
│   │   └── widgets/                     # Shared UI components
│   ├── data/
│   │   └── repositories/
│   │       ├── authentication/          # Firebase Auth repository
│   │       └── user/                    # Firestore user repository
│   └── utils/
│       ├── constants/                   # Colors, sizes, strings, enums
│       ├── exceptions/                  # Firebase and platform exceptions
│       ├── helpers/                     # Helper and utility functions
│       ├── loaders/                     # Loading animations
│       ├── popups/                      # Snackbars and loaders
│       ├── theme/                       # Light/dark theme definitions
│       └── validators/                  # Form validation
├── assets/
│   ├── fonts/                           # Poppins font family
│   ├── logos/                           # App logos (light/dark)
│   └── images/
│       ├── on_boarding_images/          # Onboarding screen illustrations
│       ├── content/                     # Default profile image
│       └── animations/                  # Lottie and GIF animations
├── android/
├── ios/
└── pubspec.yaml
```

---

## Architecture

### Frontend — Flutter (this repo)

| Layer | Details |
|---|---|
| UI Framework | Flutter (cross-platform: Android + iOS) |
| State Management | GetX |
| Authentication | Firebase Auth (email/password + Google Sign-In) |
| Storage | Firebase Firestore (chat history, user profiles) |
| Navigation | GetX named routes |

### Backend — IDSS (Python)

The IDSS is the intelligence layer that processes student messages and returns therapeutic responses. It runs independently and is called via HTTP API.

| Component | Details |
|---|---|
| Preprocessing | Text normalization + paraphrasing via Phi-3 Mini |
| Embedding | all-MiniLM-L6-v2 (384-dim sentence vectors) |
| Cue Classification | Multi-label MLP (anxiety, avoidance, self-blame, withdrawal, etc.) |
| Knowledge Base | CBT/APA-grounded rules (solutions.json) |
| Response Generation | Phi-3 Mini 128K Instruct (local LLM) |
| Self-Learning | SEAL-inspired mechanism — retrains every 10 validated examples |
| Crisis Detection | Keyword/pattern safety layer |
| Memory | Firestore (persistent chat) + in-memory cue context |

---

## Screenshots

### Splash Screen

<p float="left">
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 16.43.37.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.38.47.png" width="18%" />
  <img src="App_Screenshots/3dicons-sun-front-clay.png" width="18%" />
  <img src="App_Screenshots/3dicons-sun-front-color.png" width="18%" />
</p>

> Dark splash · Light splash · App icon (clay) · App icon (color)

### Onboarding

<p float="left">
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 16.57.01.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 16.57.04.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 16.57.08.png" width="18%" />
</p>

> Understand Your Stress (dark) · Personalized Coping Strategies (dark) · Mindfulness Companion (dark)

<p float="left">
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.32.17.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.32.30.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.32.34.png" width="18%" />
</p>

> Understand Your Stress (light) · Personalized Coping Strategies (light) · Mindfulness Companion (light)

### Authentication

<p float="left">
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 16.59.58.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.32.08.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 16.57.39.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.32.10.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 16.58.57.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 16.58.17.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.32.44.png" width="18%" />
</p>

> Sign In (dark) · Sign In (light) · Sign Up (dark) · Sign Up (light) · Forget Password · Password Reset Email Sent · Google Sign-In

### Chat

<p float="left">
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 17.02.04.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 17.03.44.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.17.03.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.17.06.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.30.03.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.30.46.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.31.24.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 17.13.09.png" width="18%" />
</p>

> Empty chat · Typing input · AI therapeutic response · CBT follow-up · Full conversation · Crisis input · Extended conversation · Crisis detection

### Profile

<p float="left">
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 17.02.09.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 17.02.11.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 17.02.38.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.31.27.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.31.45.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.31.52.png" width="18%" />
  <img src="App_Screenshots/Simulator Screenshot - Iphone 16 Pro - 2025-12-15 at 18.31.55.png" width="18%" />
</p>

> Account overview · Profile settings · Edit name · Account with logout · Photo picker · Profile with custom photo · Delete account dialog

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.1.5`
- Firebase project with Authentication and Firestore enabled
- `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) placed in the appropriate platform directories

### Setup

```bash
# Install dependencies
flutter pub get

# Run on device/emulator
flutter run
```

### Firebase Configuration

The app expects a Firestore collection structure:

```
Users/
  {uid}/
    chats/
      {messageId}: { text, role, timestamp }
```


