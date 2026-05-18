# Hacker Countdown

A cross-platform Flutter countdown timer with a hacker-terminal aesthetic — black background, neon green text, Matrix-style falling characters, and a monospace font.

Runs on Android, iOS, and macOS.

## Features

- Set a custom countdown duration (hours, minutes, seconds)
- Start, pause, and reset the timer
- HH:MM:SS display in Courier Prime monospace font
- Animated Matrix rain background using a custom canvas painter
- Accurate timing with app lifecycle awareness

## Architecture

The app follows clean architecture with strict layer separation:

```
lib/
├── presentation/       # Screens and widgets (no business logic)
│   ├── screens/
│   └── widgets/
├── bloc/               # State management (flutter_bloc)
│   ├── countdown_bloc.dart
│   ├── countdown_event.dart
│   └── countdown_state.dart
├── core/
│   ├── di/             # Dependency injection (get_it)
│   ├── router/         # Navigation (go_router)
│   └── theme/          # App theme
└── main.dart
```

## Dependencies

| Package        | Purpose                   |
| -------------- | ------------------------- |
| `flutter_bloc` | State management          |
| `get_it`       | Dependency injection      |
| `equatable`    | Value equality for states |
| `go_router`    | Navigation                |

## Getting Started

### Prerequisites

- Flutter SDK >= 3.7.0
- Dart SDK >= 3.7.0

### Run

```bash
flutter pub get
flutter run
```

To target a specific platform:

```bash
flutter run -d macos
flutter run -d android
flutter run -d ios
```
