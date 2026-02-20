# 🚀 Employee Management System

A professional, full-stack Employee Management solution featuring a modern **Flutter** mobile application and a robust **Laravel** backend API.

---

## 🌟 Key Features

### 📱 Frontend (Flutter)
- **Modern UI/UX**: Premium "Deep Navy & Gold" theme with Material 3 design.
- **Pure BLoC Architecture**: Reactive state management with **zero** `setState` usage.
- **Clean Architecture**: Separation of concerns (Domain, Data, Presentation layers).
- **Advanced Employee Management**:
  - **Smart Search**: Real-time filtering by name or designation.
  - **Green Flag Status**: Auto-highlighting active employees with 5+ years of tenure.
  - **Swipe Actions**: Gesture-based swipe-to-delete with safety confirmation.
  - **Animated Interactions**: Smooth hero transitions and list animations.

### 🔙 Backend (Laravel)
- **RESTful API**: Secure and efficient endpoints for employee data.
- **Laravel 12**: Built on the latest, high-performance PHP framework.
- **Database**: Optimized schema for employee records.
- **Validation**: Robust server-side input validation.

---

## 🛠️ Technology Stack

### Mobile Application
- **Framework**: Flutter (Dart)
- **State Management**: `flutter_bloc`, `equatable`
- **Networking**: `http`
- **Utilities**: `intl`
- **Architecture**: Clean Architecture (Feature-based)

### Backend API
- **Framework**: Laravel 12.0
- **Language**: PHP 8.2+
- **Database**: SQLite / MySQL (Configurable)
- **Tools**: Composer, Artisan

---

## 📂 Project Structure

### Frontend Structure (`flutter/task/lib`)
```
lib/
├── core/               # Global utilities, theme, and constants
│   └── theme/          # AppColors and ThemeData
├── data/               # Data Layer (Repositories & Data Sources)
│   ├── repo/           # Repository Implementations
│   └── source/         # API Client (RemoteDataSource)
├── domain/             # Domain Layer (Business Logic)
│   ├── entities/       # Core Data Models
│   ├── repo/           # Abstract Repository Interfaces
│   └── usecases/       # Single-responsibility logic (Add, Get, Delete)
├── presentation/       # UI Layer
    └── features/
        └── employee/
            ├── bloc/   # BLoC, Events, and State
            └── pages/  # Flutter Widgets (List & Form Pages)
```

---

## 🚀 Getting Started

Follow these steps to set up the entire system locally.

### 1️⃣ Backend Setup (Laravel)

Navigate to the backend directory:
```bash
cd employee_backend
```

Install dependencies and set up the environment:
```bash
# Install PHP packages
composer install

# Create environment file
cp .env.example .env

# Generate application key
php artisan key:generate

# Run database migrations
php artisan migrate

# Start the server (Accessible at 0.0.0.0:8000)
php artisan serve --host=0.0.0.0 --port=8000
```

### 2️⃣ Frontend Setup (Flutter)

Navigate to the flutter directory:
```bash
cd flutter/task
```

**⚠️ Crucial Step for Android Devices:**
Since the app communicates with `localhost`, you must map your Android device's port to your computer's port using ADB.
```bash
adb reverse tcp:8000 tcp:8000
```

Install dependencies and run:
```bash
# Get Flutter packages
flutter pub get

# Run on connected device
flutter run
```

---

## 📖 Usage Guide

1.  **View Team**: The home screen lists all employees.
    -   *Active employees with >5 years tenure are marked with a "5+ YEARS" Green Badge.*
    -   *Active status is shown with a Green dot; Inactive with a Red dot.*
2.  **Search**: Use the top search bar to filter employees by name or role instantly.
3.  **Add Member**: Tap the "Add Member" FAB to open the form.
    -   Fill in details (Name, Role, Email, Phone).
    -   Select "Joining Date" and "Designation".
    -   Toggle Status (Active/Inactive) using the segmented chips.
    -   Tap "Save" to submit.
4.  **Delete Member**: Swipe any employee card **left** or use the **menu (⋮)** > **Remove Member** to delete. Confirm the dialog to proceed.

---

## 📦 Packages Used

| Package | Purpose |
| :--- | :--- |
| **flutter_bloc** | State management using BLoC pattern |
| **equatable** | Value equality for efficient state rebuilding |
| **http** | Making HTTP requests to the Laravel API |
| **intl** | Date formatting |

---

## 👨‍💻 Developer Notes

-   **State Isolation**: The app uses a single `EmployeeBloc` to manage List, Search, and Form states. This ensures data consistency across screens.
-   **Dependency Injection**: Use cases (`GetEmployees`, `AddEmployees`, `DeleteEmployee`) are injected into the BLoC at the root `main.dart` level.
-   **Theming**: All colors are centralized in `AppColors.dart` for easy rebranding.

---

## Video

https://github.com/user-attachments/assets/f16205e6-b2ad-4416-a724-24d9bd0594ff

