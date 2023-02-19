# base_project_bloc_clean
Base flutter project with bloc
# Project build with BLOC + Clean Architecture
# Project setup with three flavor(dev,staging,product)
# To Run Project must 
1: Setting flavor with environment dev,stag,prod in android studio
2: Link environment with file main corresponding
3: Run cmt line in terminal to config project : "flutter pub run build_runner build --delete-conflicting-outputs"
# To build project APK
-Build apk cho dev:
flutter build apk --flavor dev -t lib/main.dart
-Build apk cho stag:
flutter build apk --flavor stag -t lib/main_stag.dart
-Build apk cho product:
flutter build apk --flavor prod -t lib/main_pro.dart
# To build project aab
-Build aab:
flutter build appbundle --flavor prod -t lib/main_pro.dart
# Before commit or push code to git, developer need analyze format code with cmt:
flutter analyze