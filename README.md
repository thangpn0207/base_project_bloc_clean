# Base Project with BLoC + Clean Architecture

A Flutter project template built with BLoC pattern and Clean Architecture principles. This project is configured with three environments (development, staging, production) for both mobile and web platforms.

## Project Structure

This project follows Clean Architecture principles:
- **Presentation Layer**: UI components, BLoC files
- **Domain Layer**: Use cases, entities, repository interfaces
- **Data Layer**: Repository implementations, data sources, models

## Environment Configuration

The project uses `.env` files for configuring different environments:
- `.env.development` - Development settings
- `.env.staging` - Staging settings
- `.env.production` - Production settings

The application's environment is determined by the entry point file used when running or building the app:
- `lib/main_dev.dart` - Development environment
- `lib/main_stag.dart` - Staging environment
- `lib/main_prod.dart` - Production environment

## Flavor Configuration

### Android

The Android flavors are configured in `android/app/build.gradle` with three product flavors:

```gradle
flavorDimensions "environment"
productFlavors {
    dev {
        dimension "environment"
        applicationIdSuffix ".dev"
        resValue "string", "app_name", "Base Project Dev"
    }
    stag {
        dimension "environment"
        applicationIdSuffix ".stag"
        resValue "string", "app_name", "Base Project Stag"
    }
    prod {
        dimension "environment"
        resValue "string", "app_name", "Base Project"
    }
}
```

### iOS

For iOS, you need to set up Xcode schemes manually:

1. Open the Runner.xcworkspace in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Create three new schemes for each environment:
   - Xcode → Product → Scheme → New Scheme...
   - Create schemes named: Runner-dev, Runner-stag, Runner-prod

3. Configure each scheme:
   - In Xcode, select a scheme → Edit Scheme...
   - Under 'Build Configuration', select 'Debug' for development and staging, 'Release' for production
   - Under 'Arguments', add environment variables:
     - For Runner-dev: `FLAVOR=dev`
     - For Runner-stag: `FLAVOR=stag`
     - For Runner-prod: `FLAVOR=prod`

4. Update Info.plist by adding custom display names for each flavor:
   - Add the key `CFBundleDisplayName` with value: `$(PRODUCT_NAME)-$(FLAVOR)`

## Running the App

### Mobile

```bash
# Development
flutter run --flavor dev -t lib/main_dev.dart

# Staging
flutter run --flavor stag -t lib/main_stag.dart

# Production
flutter run --flavor prod -t lib/main_prod.dart
```

### Web

```bash
# Development
flutter run -d chrome -t lib/main_dev.dart

# Staging
flutter run -d chrome -t lib/main_stag.dart

# Production
flutter run -d chrome -t lib/main_prod.dart
```

## Building the App

### Mobile APK

```bash
# Development APK
flutter build apk --flavor dev -t lib/main_dev.dart

# Staging APK
flutter build apk --flavor stag -t lib/main_stag.dart

# Production APK
flutter build apk --flavor prod -t lib/main_prod.dart
```

### Mobile App Bundle (AAB)

```bash
# Development AAB
flutter build appbundle --flavor dev -t lib/main_dev.dart

# Staging AAB
flutter build appbundle --flavor stag -t lib/main_stag.dart

# Production AAB
flutter build appbundle --flavor prod -t lib/main_prod.dart
```

### Web

```bash
# Development build
flutter build web -t lib/main_dev.dart

# Staging build
flutter build web -t lib/main_stag.dart

# Production build
flutter build web --release -t lib/main_prod.dart
```

## Deploying Web Builds

When deploying web builds, each environment should have its own deployment:

1. Deploy development build to development server/URL
2. Deploy staging build to staging server/URL  
3. Deploy production build to production server/URL

## Development Setup

1. Generate code with build_runner:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

2. Before committing code, run the analyzer:
```bash
flutter analyze
```

## Project Dependencies

This project uses the following major dependencies:
- flutter_bloc: State management
- get_it: Dependency injection
- dio: HTTP client
- shared_preferences: Local storage
- flutter_dotenv: Environment configuration