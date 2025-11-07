# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter hackathon application using:
- **Flutter 3.35.7** (managed via FVM - Flutter Version Management)
- **Riverpod** for state management (flutter_riverpod + riverpod_annotation + riverpod_generator)
- **GoRouter** for navigation
- **Firebase** for authentication and backend services (currently commented out in main.dart)

## Commands

### Running the app
```bash
# Use FVM to run with the correct Flutter version
fvm flutter run

# Or if FVM is configured globally
flutter run
```

### Code generation (Riverpod)
```bash
# Generate Riverpod code from annotations
fvm flutter pub run build_runner build

# Watch mode for continuous generation
fvm flutter pub run build_runner watch

# Clean and rebuild
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### Testing
```bash
# Run all tests
fvm flutter test

# Run specific test file
fvm flutter test test/path/to/test_file.dart
```

### Linting
```bash
# Analyze code
fvm flutter analyze

# Format code
fvm flutter format lib/
```

### Build
```bash
# Build for iOS
fvm flutter build ios

# Build for Android
fvm flutter build apk
fvm flutter build appbundle
```

## Architecture

### Project Structure
```
lib/
├── main.dart           # App entry point with ProviderScope
├── app.dart            # Root widget using MaterialApp.router
├── config/
│   └── router.dart     # GoRouter configuration with routerProvider
└── feature/            # Feature-based modules (currently empty)
```

### State Management Pattern
- Uses **Riverpod** as the primary state management solution
- Providers are defined using annotations (requires code generation)
- The app is wrapped in `ProviderScope` at the root (main.dart)
- Router is provided via `routerProvider` and consumed with `ref.watch()` in app.dart

### Navigation Pattern
- Uses **GoRouter** for declarative routing
- Router configuration is in `lib/config/router.dart`
- Router is provided as a Riverpod provider (`routerProvider`)
- Currently has a single route to `HomePage` at `/`

### Firebase Integration
- Firebase dependencies are installed (firebase_core, firebase_auth)
- Firebase initialization is currently commented out in main.dart:7-9
- When enabling Firebase, uncomment the initialization and ensure firebase_options.dart is generated using FlutterFire CLI

## Development Notes

### FVM Usage
This project uses FVM to manage Flutter versions. Always prefix Flutter commands with `fvm` or configure your IDE to use the FVM Flutter SDK path (`.fvm/flutter_sdk`).

### Adding New Features
New features should be organized in the `lib/feature/` directory, following a feature-first architecture pattern.

### Code Generation
When using Riverpod annotations (like `@riverpod`), you must run the build_runner to generate the necessary code. The generated files will have a `.g.dart` suffix.
