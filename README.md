# Frame

Frame is a focused workspace for consuming educational and informative content without the distractions commonly found on traditional content platforms.

The project is currently focused on YouTube content and provides a cleaner environment for searching for and watching content.

## Features

* 🔎 Search YouTube content
* 🎥 Watch videos inside Frame
* 📱 Responsive UI for mobile, tablet, and desktop
* 🌐 Web support
* 🪟 Windows support
* 🔄 Pagination for search results
* 🌐 Network connection detection
* ⚠️ Dedicated error and no-internet screens
* 🧩 Provider-based state management
* 🚀 Separate backend API

## Project Architecture

Frame follows a simple layered architecture:

```text
UI
 ↓
Provider
 ↓
Service
 ↓
Engine / API
```

### UI

Responsible for displaying the application and handling user interaction.

### Provider

Responsible for application state and communicating between the UI and services.

The project uses `ChangeNotifier` with `Provider`.

### Service

Responsible for application-specific operations such as searching for content and communicating with the backend.

### API

The backend handles communication with YouTube and exposes endpoints consumed by the Flutter application.

## Tech Stack

### Frontend

* Flutter
* Dart
* Provider
* GoRouter
* HTTP
* YouTube Player IFrame

### Backend

* Dart
* Vania
* YouTube Data API

### Deployment

* Firebase Hosting — Flutter Web
* Railway — Backend API

## Project Structure

```text
lib/
│
├── main.dart
│
├── layout/
│   └── app_layout.dart
│
├── models/
│   ├── channel_model.dart
│   ├── content_model.dart
│   ├── playlist_model.dart
│   └── video_model.dart
│
├── network/
│   └── network_status_service.dart
│
├── pages/
│   ├── error_page.dart
│   ├── general_error.dart
│   ├── no_internet.dart
│   ├── results_page.dart
│   ├── search_results_pages.dart
│   ├── search_screen.dart
│   ├── video_player.dart
│   │
│   ├── results_screen_bodies/
│   │   ├── desktop_body.dart
│   │   ├── mobile_body.dart
│   │   └── tablet_body.dart
│   │
│   └── search_screen_bodies/
│       ├── desktop_body.dart
│       ├── mobile_body.dart
│       └── tablet_body.dart
│
├── router/
│   └── app_router.dart
│
├── search/
│   ├── search_provider.dart
│   └── search_service.dart
│
└── widgets/
    ├── content_card.dart
    ├── loading_dots.dart
    ├── navigation_button.dart
    ├── search_bar.dart
    ├── suggestion_button.dart
    │
    ├── channel_cards/
    │   └── channel_card.dart
    │
    ├── playlist_cards/
    │   └── playlist_card.dart
    │
    └── video_cards/
        ├── desktop_video_card.dart
        ├── mobile_video_card.dart
        └── video_card.dart
```

## Backend

The Frame API is a separate Dart/Vania project.

Its main purpose is to provide a backend layer between the Flutter application and the YouTube API.

The API currently exposes search functionality through:

```text
/api/v1/search
```

Supported search types include:

```text
video
channel
playlist
all
```

The API also supports searching using a YouTube resource ID.

## Running the Project

### Requirements

Make sure the following are installed:

* Flutter SDK
* Dart SDK
* Git

Check Flutter installation:

```bash
flutter doctor
```

### Clone the repository

```bash
git clone https://github.com/mazen-ahmed7789798/Frame.git
cd Frame
```

### Install dependencies

```bash
flutter pub get
```

### Run the application

For Chrome:

```bash
flutter run -d chrome
```

For Windows:

```bash
flutter run -d windows
```

For an Android device:

```bash
flutter devices
flutter run -d <device-id>
```

## Environment

The application communicates with the Frame API rather than directly exposing the YouTube API key inside the Flutter application.

The backend requires a YouTube API key configured through an environment variable:

```text
YOUTUBE_API_KEY
```

Do not commit API keys or other secrets to the repository.

## Responsive Design

Frame supports different layouts depending on the available screen size.

The current layout categories are:

```text
Mobile
Tablet
Desktop
```

The UI uses different presentation bodies where the layout requires significant differences while keeping application logic outside the presentation layer.

## Error Handling

The application handles common failure states including:

* No internet connection
* General application/API errors
* Empty search results
* Loading states

Network availability is checked before performing search operations.

## Navigation

Frame uses `GoRouter` for application navigation.

The main application flow is:

```text
Search
  ↓
Search Results
  ↓
Video Player
```

Search results can also be navigated using pagination.

## Design

Frame is designed around a dark interface with a minimal visual style.

Primary colors currently include:

```text
Background:       #0F1019
Secondary:        #1C232B
Accent:           #7EE7C6
Primary Text:     #E6ECEF
Secondary Text:   #8B949E
```

The interface uses **Inter** as its primary typeface.

## Current Status

Frame is currently under active development.

The core search and content-viewing flow is being developed first, followed by improvements to responsive layouts, navigation, error handling, and the overall workspace experience.

## Roadmap

Planned areas of development include:

* [ ] Improve responsive layouts
* [ ] Refine video player experience
* [ ] Improve search and pagination
* [ ] Improve error states
* [ ] Improve overall workspace UI
* [ ] Authentication
* [ ] User-specific content organization
* [ ] Additional content types
* [ ] Mobile-focused improvements
* [ ] Additional workspace features

## License

This project is currently under development.
