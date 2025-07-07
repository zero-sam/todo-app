# Todo App with Flutter 

A modern, multi-screen Flutter to-do manager app with persistent storage, beautiful UI, and optional Google Sign-In via Firebase.

## Features
- Add, edit, and delete tasks
- Mark tasks as done/undone
- Task due date support
- Multi-screen navigation (Home, Task Details, Settings)
- Persistent storage using `shared_preferences`
- Google Sign-In and Firebase Auth (optional)
- Responsive, attractive UI with gradients
- Ready for Android APK build

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Git](https://git-scm.com/)
- Android Studio or VS Code (recommended)

### Setup
1. **Clone the repository:**
   ```sh
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
   cd todo_final
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **(Optional) Firebase Setup:**
   - Add your `google-services.json` to `android/app/` for Android.
   - Add your `GoogleService-Info.plist` to `ios/Runner/` for iOS.
   - See [Firebase setup docs](https://firebase.flutter.dev/docs/overview/) for details.
4. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure
- `lib/` - Main Dart source code
  - `main.dart` - App entry point
  - `models/` - Data models
  - `screens/` - UI screens (Home, Task Details, Settings, Login)
- `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` - Platform folders

## Customization
- To enable/disable Google Sign-In, edit the relevant code and dependencies in `pubspec.yaml` and `main.dart`/`login_screen.dart`.
- To change the theme, edit the `ThemeData` in `main.dart`.

## Drive Link for Apk
https://drive.google.com/drive/folders/15IEgdVMLLWzVmHgJKjVb2ONc-210jz_O?usp=sharing

*This is a project for the hackathon run by https://www.katomaran.com*

## License
MIT
