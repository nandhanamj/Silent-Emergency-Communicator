# Silent Emergency Communicator

## Overview

Silent Emergency Communicator is a Flutter-based mobile application designed to help users discreetly request assistance during emergency situations. The application allows users to create emergency profiles, manage trusted contacts, generate emergency alerts, share location information, and send emergency SMS messages quickly without drawing attention.

The project focuses on providing a silent and efficient emergency communication system for situations involving medical emergencies, crime, fire incidents, personal danger, or general SOS alerts.

---

## Features

### User Registration & Profile Management

* Create emergency profile
* Store personal information
* Blood group information
* Medical notes
* Additional emergency information
* Edit profile functionality

### Emergency Contact Management

* Add emergency contacts
* Edit emergency contacts
* Delete emergency contacts
* Store relationship information
* Persistent local storage

### Emergency Alert System

* Medical Emergency
* Police Emergency
* Fire Emergency
* Danger Alert
* SOS Alert

### Smart Message Generation

* Emergency-specific tags
* Custom emergency notes
* Auto-generated emergency messages
* User profile integration

### Location Services

* GPS location retrieval
* Google Maps location link generation
* Automatic location inclusion in alerts

### SMS Alert Delivery

* SMS-based emergency communication
* Multiple recipient support
* Silent alert generation
* Emergency authority selection

### Emergency History

* Alert history storage
* Timestamp tracking
* Emergency type tracking
* Recipient tracking

### Additional Features

* Silent emergency mode
* Vibration feedback
* Multilingual architecture support
* Future-ready authority integration

---

## Technologies Used

### Frontend

* Flutter
* Dart

### Storage

* SharedPreferences

### Device Services

* Geolocator
* SMS Launcher
* Vibration

### Architecture

* Stateful Widget Architecture
* Service Layer Architecture
* Local Storage Architecture

---

## Project Structure

lib/

├── models/

│ ├── user_profile.dart

│ ├── emergency_contact.dart

│ └── emergency_history.dart

│

├── screens/

│ ├── splash_screen.dart

│ ├── registration_screen.dart

│ ├── emergency_dashboard_screen.dart

│ ├── emergency_processing_screen.dart

│ ├── emergency_message_generator_screen.dart

│ ├── select_recipients_screen.dart

│ ├── review_alert_screen.dart

│ ├── profile_screen.dart

│ ├── edit_profile_screen.dart

│ ├── emergency_contacts_screen.dart

│ ├── add_contact_screen.dart

│ ├── emergency_history_screen.dart

│ ├── emergency_messages_screen.dart

│ ├── feature_configuration_screen.dart

│ └── language_screen.dart

│

├── services/

│ ├── storage_service.dart

│ ├── contact_storage_service.dart

│ ├── history_storage_service.dart

│ ├── location_service.dart

│ ├── sms_service.dart

│ ├── network_service.dart

│ ├── auto_sos_service.dart

│ ├── language_service.dart

│ └── translation_service.dart

│

└── main.dart

---

## Installation

### Clone Repository

git clone https://github.com/your-username/silent-emergency-communicator.git

### Navigate to Project

cd silent-emergency-communicator

### Install Dependencies

flutter pub get

### Run Application

flutter run

---

## Required Permissions

### Android

The application requires:

* Internet Permission
* Location Permission
* SMS Permission
* Vibration Permission

---

## Future Enhancements

* Firebase Cloud Integration
* Real-Time Alert Synchronization
* Authority API Integration
* Push Notifications
* Voice Trigger Detection
* Wearable Device Integration
* Offline Alert Queueing
* Multilingual Translation Engine
* Hardware Shortcut Activation

---

## Author

Nandhana M J

B.Tech Computer Science and Engineering

---

## License

This project is developed for educational and academic purposes.