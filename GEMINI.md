# PowerWatch - IoT Electricity Monitor App

## Project Overview

PowerWatch is a Flutter mobile application designed to monitor real-time electricity consumption. It serves as the user interface for an IoT-based electricity monitoring system. The app features a modern, dark-themed UI with a focus on data visualization.

**Key Technologies:**

*   **Frontend:** Flutter
*   **Backend (as designed):** Firebase (Authentication and Realtime Database)
*   **Charting:** `fl_chart`
*   **Font:** `google_fonts` (Inter)

**Architecture:**

The project follows a clean architecture, separating models, services, pages, and widgets. It uses a mock data service to simulate real-time IoT data for prototyping purposes.

## Building and Running

To build and run the PowerWatch application, follow these steps:

1.  **Prerequisites:**
    *   Flutter SDK (version 3.0.0 or higher)

2.  **Install Dependencies:**
    Open a terminal in the project root and run:
    ```bash
    flutter pub get
    ```

3.  **Run the Application:**
    ```bash
    flutter run
    ```

## Development Conventions

*   **State Management:** The project currently uses `StatefulWidget` for local state management. The `provider` package is included in the dependencies and is ready for use in a production environment.
*   **Data:** A mock data service (`lib/services/mock_data_service.dart`) is used to simulate real-time data. This service can be replaced with a real data source (e.g., Firebase Realtime Database) in a production environment.
*   **Styling:** The app uses a custom dark theme defined in `lib/theme/app_theme.dart`. The color palette and typography are also defined in this file.
*   **Project Structure:** The project is organized into the following directories:
    *   `lib/models`: Contains the data models for the application.
    *   `lib/pages`: Contains the different pages or screens of the application.
    *   `lib/services`: Contains the data services for the application.
    *   `lib/theme`: Contains the theme and styling for the application.
    *   `lib/widgets`: Contains the reusable widgets for the application.
