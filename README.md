# SWAPI Flutter App

## Overview
SWAPI Flutter App is a Star Wars database application built using Flutter. It provides features such as endless pagination on the home screen, parallel data fetching for detailed views, JSON parsing in isolates for enhanced performance, Lottie animations, and a Cinema Location feature using Google Maps, including ETA calculation, route navigation, and mock data for cinema locations. Additionally, it incorporates a reminder feature with flutter_local_notifications.

## Features

### 1. Home with Endless Pagination
The home screen of the app displays Star Wars data with endless pagination, allowing users to explore a vast amount of information seamlessly.

### 2. Detail with Parallel Data Fetch
Detailed views of items in the app fetch data in parallel, optimizing performance and providing a smooth user experience.

### 3. Isolate for Parsing JSON
JSON parsing is handled in isolates, enhancing the app's performance by running computations concurrently in a separate background thread.

### 4. Lottie Animation
Lottie animations are integrated into the app to enhance the visual experience and provide engaging feedback to the users.

### 5. Cinema Location - Google Maps
-  ETA Calculation: Users can calculate the Estimated Time of Arrival (ETA) from their current position to specific cinema locations.
- Route Navigation: The app supports route navigation from the user's current position to a chosen cinema location, providing a seamless navigation experience.

### 6. Reminder Feature with flutter_local_notifications
Users can set reminders within the app, and notifications will be triggered using the `flutter_local_notifications` package.

## Getting Started

### Prerequisites
- Flutter installed on your machine. If not, follow the [official installation guide](https://flutter.dev/docs/get-started/install).
- A code editor (e.g., Visual Studio Code, IntelliJ, Android Studio).

### Clone the Repository
```bash
git clone https://github.com/luthfiarifin/swapi_flutter_app.git
cd swapi_flutter_app
```

### Install Dependencies
```bash
flutter pub get
```

### Run the Application
```bash
flutter run
```

## Building the Package
To build the package for distribution, use the following command:

```bash
flutter build <platform>
```
Replace `<platform>` with the desired platform (e.g., `apk` for Android, `ipa` for iOS).

## Running on MacOS, Linux, Windows

### MacOS/Linux
```bash
flutter run
```

### Windows
```bash
flutter run -d windows
```

Follow these steps, and you should be able to set up, build, and run the SWAPI Flutter App on your local development environment. Happy coding!