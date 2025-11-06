# PowerWatch - IoT Electricity Monitor App

A Flutter mobile application prototype for monitoring electricity consumption in real-time. This app serves as the user-facing interface for an IoT-based electricity monitoring system.

## Features

### Authentication
- **Login Page**: Email/password authentication with form validation
- **Sign Up Page**: User registration with full name, email, and password
- Clean, modern UI with PowerWatch branding

### Main Application
- **Bottom Navigation**: Four main sections accessible via bottom navigation bar
- **Dark Mode**: Modern dark theme optimized for data visualization

### Dashboard (Home)
- **Live Power Gauge**: Custom speedometer-style circular gauge showing real-time power consumption
- **Data Cards**: 2x2 grid displaying voltage, current, energy today, and estimated bill
- **Remote Control**: Interactive toggle switch for main circuit relay control
- **Real-time Updates**: Simulated data updates every 3 seconds

### Usage Analytics
- **Time Frame Selection**: Day, Week, and Month views
- **Interactive Bar Charts**: Visual representation of energy consumption patterns
- **Summary Statistics**: Total usage, averages, peaks, and lows
- **Responsive Design**: Charts adapt to different time frames

### Alerts & Insights
- **Notification List**: Scrollable list of alerts and insights
- **Categorized Alerts**: Different icons and colors for different alert types
- **Timestamps**: Relative time display for each alert
- **Empty State**: Friendly message when no alerts are present

### Profile & Settings
- **User Information**: Display user name and email
- **Tariff Rate Management**: Editable electricity tariff rate with dialog
- **Device Management**: Placeholder for future device configuration
- **Dark Mode Toggle**: Theme preference setting
- **Logout Functionality**: Secure logout with confirmation dialog

## Technical Implementation

### Architecture
- **Clean Architecture**: Separated models, services, pages, and widgets
- **Mock Data Service**: Simulates real-time IoT data for prototyping
- **Custom Widgets**: Reusable gauge and chart components
- **State Management**: Local state management with StatefulWidget

### Design System
- **Color Palette**: 
  - Primary Blue: #1A73E8
  - Background Dark: #121212
  - Card Surface: #1E1E1E
  - Accent Green: #34A853
  - Warning Orange: #FBBC04
- **Typography**: Inter font family with Material Design text styles
- **Icons**: Material Icons library
- **Components**: Consistent card-based layout with rounded corners

### Dependencies
- `flutter`: Core Flutter framework
- `fl_chart`: For interactive bar charts
- `google_fonts`: For Inter font family
- `firebase_core`, `firebase_auth`, `firebase_database`: Firebase integration (ready for production)
- `provider`: State management (ready for production)

## Project Structure

```
lib/
├── main.dart                 # App entry point and routing
├── theme/
│   └── app_theme.dart       # Dark theme configuration
├── models/
│   ├── power_data.dart      # Power consumption data model
│   ├── alert.dart           # Alert/notification model
│   └── user.dart            # User profile model
├── services/
│   └── mock_data_service.dart # Mock data simulation
├── pages/
│   ├── auth/
│   │   ├── login_page.dart  # Login screen
│   │   └── signup_page.dart # Registration screen
│   ├── dashboard_page.dart  # Main dashboard
│   ├── usage_page.dart      # Usage analytics
│   ├── alerts_page.dart     # Alerts and insights
│   ├── profile_page.dart    # User profile and settings
│   └── main_app.dart        # Main app with navigation
└── widgets/
    ├── power_gauge.dart     # Custom circular gauge
    └── usage_bar_chart.dart # Custom bar chart
```

## Getting Started

1. **Prerequisites**: Flutter SDK 3.0.0 or higher
2. **Installation**: 
   ```bash
   flutter pub get
   ```
3. **Run**: 
   ```bash
   flutter run
   ```

## Mock Data

The app uses simulated data for prototyping:

- **Real-time Data**: Voltage (230V), Current (2.7A), Power (625W), Daily Energy (8.3kWh), Estimated Bill (₹2115)
- **Historical Data**: 
  - Day: 24-hour hourly consumption pattern
  - Week: 7-day daily totals
  - Month: 4-week weekly totals
- **Alerts**: Pre-defined notifications for high usage, efficiency tips, and system events

## Future Enhancements

- **Firebase Integration**: Real-time database connectivity
- **Device Management**: IoT device pairing and configuration
- **Advanced Analytics**: AI-powered insights and recommendations
- **Push Notifications**: Real-time alert delivery
- **Offline Support**: Local data caching and sync
- **Multi-language Support**: Internationalization
- **Accessibility**: Screen reader and accessibility features

## Design Philosophy

PowerWatch emphasizes:
- **Data-Driven Design**: Clear visualization of energy consumption
- **User-Centric**: Intuitive navigation and interactions
- **Modern Aesthetics**: Clean, tech-focused visual design
- **Performance**: Smooth animations and responsive UI
- **Scalability**: Architecture ready for production features

This prototype demonstrates a complete mobile application for IoT electricity monitoring with professional-grade UI/UX design and robust technical implementation.

