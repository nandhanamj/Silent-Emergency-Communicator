# Silent Emergency Communicator

## Overview

**Silent Emergency Communicator** is a Flutter-based mobile application developed to provide a fast, discreet, and reliable method for requesting help during emergency situations.

The application enables users to create an emergency profile, manage trusted contacts, automatically generate emergency alerts, retrieve live GPS location data, and send emergency SMS messages with minimal user interaction.

The project was developed as a personal learning project to explore Flutter mobile development, device integration, local storage, GPS services, SMS communication, and emergency response workflows.

---

## Key Features

### Emergency Profile Management

* User registration and onboarding
* Personal profile management
* Blood group information
* Medical notes and emergency information
* Profile editing and updating
* Persistent local storage

### Emergency Contact Management

* Add emergency contacts
* Edit contact information
* Delete contacts
* Relationship tracking
* Contact persistence using SharedPreferences

### Emergency Alert Types

The application supports multiple emergency categories:

* Medical Emergency
* Police Emergency
* Fire Emergency
* Danger Alert
* Panic/SOS Alert

### Smart Emergency Message Generation

* Emergency-specific tags
* Additional custom notes
* Auto-generated emergency messages
* User profile integration
* Location-aware alert generation

### Location Services

* Real-time GPS location retrieval
* Automatic coordinate detection
* Google Maps link generation
* Location inclusion in emergency alerts

### SMS-Based Emergency Communication

* Emergency SMS generation
* Multiple recipient support
* One-tap alert sending
* Silent communication workflow

### Auto SOS System

* Instant emergency alert preparation
* Automatic emergency message generation
* GPS-enabled SOS alerts
* Contact-based emergency broadcasting

### Emergency History Tracking

* Alert history storage
* Timestamp recording
* Emergency type tracking
* Recipient tracking
* Historical emergency review

### Additional Features

* Splash screen onboarding
* Offline-ready local storage
* Vibration feedback support
* Emergency dashboard
* Feature configuration screen
* Language settings architecture
* Custom application branding

---

## Technologies Used

### Frontend

* Flutter
* Dart

### Local Storage

* SharedPreferences

### Device Integration

* Geolocator
* URL Launcher
* Vibration
* Device Information APIs

### Architecture

* Stateful Widget Architecture
* Service Layer Architecture
* Modular Screen-Based Navigation
* Local Data Persistence Architecture

---

## Project Structure

```text
lib/

├── models/
│   ├── emergency_contact.dart
│   ├── emergency_history.dart
│   └── user_profile.dart
│
├── screens/
│   ├── splash_screen.dart
│   ├── registration_screen.dart
│   ├── emergency_dashboard_screen.dart
│   ├── emergency_processing_screen.dart
│   ├── emergency_message_generator_screen.dart
│   ├── select_recipients_screen.dart
│   ├── review_alert_screen.dart
│   ├── profile_screen.dart
│   ├── edit_profile_screen.dart
│   ├── emergency_contacts_screen.dart
│   ├── add_contact_screen.dart
│   ├── emergency_history_screen.dart
│   ├── emergency_messages_screen.dart
│   ├── feature_configuration_screen.dart
│   └── language_screen.dart
│
├── services/
│   ├── storage_service.dart
│   ├── contact_storage_service.dart
│   ├── history_storage_service.dart
│   ├── location_service.dart
│   ├── sms_service.dart
│   ├── network_service.dart
│   ├── auto_sos_service.dart
│   ├── language_service.dart
│   └── translation_service.dart
│
├── assets/
│   ├── images/
│       └──app_logo.png
│
│
└── main.dart
```

---

## Installation

### Clone Repository

```bash
git clone https://github.com/your-username/silent-emergency-communicator.git
```

### Navigate to Project

```bash
cd silent-emergency-communicator
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

### Build Release APK

```bash
flutter build apk --release
```

---

## Required Permissions

### Android

The application requires:

* Internet Permission
* Location Permission
* SMS Permission
* Vibration Permission

---

## Screens Included

* Splash Screen
* Registration Screen
* Emergency Dashboard
* Emergency Processing Screen
* Emergency Message Generator
* Recipient Selection Screen
* Alert Review Screen
* Profile Screen
* Emergency Contacts Screen
* Emergency History Screen
* Emergency Messages Screen
* Feature Configuration Screen
* Language Screen

---

## Future Enhancements

* Firebase Cloud Integration
* Real-Time Emergency Synchronization
* Emergency Authority Integration
* Push Notifications
* Voice Trigger Detection
* Wearable Device Support
* Offline Alert Queueing
* AI-Based Emergency Detection
* Multilingual Translation Engine
* Hardware Shortcut Activation

---

## Learning Outcomes

This project was built to gain hands-on experience with:

* Flutter Mobile Development
* Dart Programming
* Local Data Persistence
* GPS & Location Services
* SMS Integration
* Mobile UI/UX Design
* State Management
* Service-Based Architecture
* Android Application Deployment
* Git & GitHub Version Control

---

## Author

**Nandhana M J**

B.Tech Computer Science and Engineering

---

## License

This project was developed for personal learning, educational exploration, and academic purposes.
