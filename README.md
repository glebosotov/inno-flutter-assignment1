# chuck

This project is done for Innopolis [S22] Cross-platform Mobile Development with Flutter elective

## Features
- **Satisfy all assignment requirements**
- Get [Chuck Norris](api.chucknorris.io) jokes
- Get jokes based on a category
- Search for a joke
- Find my telegram
- Look for images on Unsplash
- Open jokes and images in browser
- Dark mode (duh)
- Some animations

## Screenshots
<img src="screenshots/Simulator Screen Shot - iPhone 13 Pro - 2022-02-11 at 21.23.10.png" alt="Simulator Screen Shot - iPhone 13 Pro - 2022-02-11 at 21.23.10" style="zoom:15%;" /><img src="screenshots/Simulator Screen Shot - iPhone 13 Pro - 2022-02-11 at 21.23.39.png" alt="Simulator Screen Shot - iPhone 13 Pro - 2022-02-11 at 21.23.39" style="zoom: 15%;" /><img src="screenshots/Simulator Screen Shot - iPhone 13 Pro - 2022-02-11 at 21.23.52.png" alt="Simulator Screen Shot - iPhone 13 Pro - 2022-02-11 at 21.23.52" style="zoom:15%;" /><img src="screenshots/Simulator Screen Shot - iPhone 13 Pro - 2022-02-11 at 21.28.54.png" alt="Simulator Screen Shot - iPhone 13 Pro - 2022-02-11 at 21.28.54" style="zoom:15%;" />

## Details on the implementation
- Dio for networking
- BLoC for logic
- Retrofit for API calls code generation

List of all packages:
```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.2
  dio: ^4.0.4
  flutter_bloc: ^8.0.1
  json_annotation: ^4.4.0
  json_serializable: ^6.1.4
  retrofit: ^3.0.1+1
  url_launcher: ^6.0.20

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^1.0.0
  build_runner: ^2.1.7
  retrofit_generator: ^4.0.1
  flutter_launcher_icons: ^0.9.2

```