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
- intl: Internationalization support
- intl_utils: Internationalization utilities

## Internationalization (i18n)

This project uses the `intl` package for internationalization support. The following guide explains how to generate and use locales in the project.

### Directory Structure

The localization files are organized as follows:

```
lib/
  core/
    locale/
      l10n/              # ARB files for each language
        intl_en.arb     # English translations
        intl_vi.arb     # Vietnamese translations
      generated/        # Generated localization files
```

### Adding New Translations

1. Add new translation keys to `lib/core/locale/l10n/intl_en.arb`:
```json
{
  "newKey": "English text",
  "@newKey": {
    "description": "Description of the translation"
  }
}
```

2. Add corresponding translations to `lib/core/locale/l10n/intl_vi.arb`:
```json
{
  "newKey": "Vietnamese text",
  "@newKey": {
    "description": "Description of the translation"
  }
}
```

3. For translations with parameters, use the following format:
```json
{
  "welcomeMessage": "Welcome to {appName}!",
  "@welcomeMessage": {
    "description": "Welcome message with app name",
    "placeholders": {
      "appName": {
        "type": "String"
      }
    }
  }
}
```

### Generating Localization Files

Run the following command to generate the localization files:

```bash
flutter pub run intl_utils:generate
```

This will generate the necessary files in the `lib/core/locale/generated` directory.

### Using Translations in the App

#### 1. In Widgets

```dart
// Using the generated S class
Text(S.of(context).appTitle)

// Using with parameters
Text(S.of(context).welcomeMessage('My App'))

// Using error messages
Text(S.of(context).errorMessage('Connection failed'))
```

#### 2. In Code

```dart
// Get current translations
final translations = S.current;

// Use translations with parameters
final welcomeMessage = translations.welcomeMessage('My App');
final errorMessage = translations.errorMessage('Connection failed');
```

#### 3. In Cubits/Blocs

```dart
class MyCubit extends Cubit<MyState> {
  void showError(String error) {
    // Using translations in cubit
    final message = S.current.errorMessage(error);
    // Use the message...
  }
}
```

#### 4. In Services

```dart
class ApiService {
  void handleError(dynamic error) {
    // Using translations in service
    final message = S.current.serverError;
    // Use the message...
  }
}
```

### Available Translations

#### Common UI Elements

| Key | English | Vietnamese |
|-----|---------|------------|
| appTitle | Base Project | Dự án cơ sở |
| homeScreenTitle | Home Screen | Màn hình chính |
| settingsLabel | Settings | Cài đặt |

#### Theme Settings

| Key | English | Vietnamese |
|-----|---------|------------|
| themeSettings | Theme Settings | Cài đặt giao diện |
| lightTheme | Light Theme | Giao diện sáng |
| darkTheme | Dark Theme | Giao diện tối |
| systemTheme | System Theme | Giao diện hệ thống |

#### Language Settings

| Key | English | Vietnamese |
|-----|---------|------------|
| languageSettings | Language Settings | Cài đặt ngôn ngữ |
| english | English | Tiếng Anh |
| vietnamese | Vietnamese | Tiếng Việt |

#### Messages

| Key | English | Vietnamese |
|-----|---------|------------|
| welcomeMessage | Welcome to {appName}! | Chào mừng đến với {appName}! |
| errorMessage | An error occurred: {error} | Đã xảy ra lỗi: {error} |
| successMessage | Operation completed successfully | Thao tác hoàn tất thành công |
| loadingMessage | Loading... | Đang tải... |

#### Buttons

| Key | English | Vietnamese |
|-----|---------|------------|
| retryButton | Retry | Thử lại |
| cancelButton | Cancel | Hủy |
| saveButton | Save | Lưu |
| deleteButton | Delete | Xóa |
| editButton | Edit | Sửa |

#### Search

| Key | English | Vietnamese |
|-----|---------|------------|
| searchHint | Search... | Tìm kiếm... |
| noResultsFound | No results found | Không tìm thấy kết quả |

#### Error Messages

| Key | English | Vietnamese |
|-----|---------|------------|
| networkError | Network error occurred | Lỗi kết nối mạng |
| serverError | Server error occurred | Lỗi máy chủ |
| connectionError | Connection error occurred | Lỗi kết nối |
| timeoutError | Request timed out | Yêu cầu đã hết thời gian chờ |

### Adding a New Language

1. Create a new ARB file in `lib/core/locale/l10n/` (e.g., `intl_es.arb` for Spanish)
2. Copy all translation keys from `intl_en.arb`
3. Translate all values to the new language
4. Run `flutter pub run intl_utils:generate`
5. Add the new locale to `LocaleCubit.supportedLocales`

### Best Practices

1. Always use the generated `S` class for translations
2. Keep translation keys descriptive and organized
3. Use parameters for dynamic content
4. Add descriptions for all translation keys
5. Maintain consistent naming conventions
6. Test translations in all supported languages
7. Keep translations up to date with UI changes