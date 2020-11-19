# blood_pressure_tracker

Blood Pressure Tracker is a simple application that allows users to keep track of their blood pressure.



## Screenshots

<img alt="Home Screen" src="/resources/home_screen.png" width="400"/> 
<img alt="New Entry Dialog" src="/resources/new_entry_dialog.png" width="400"/> 
<img alt="History Screen" src="/resources/history.png" width="400"/>
<img alt="Deleting Entry From Database" src="/resources/deleting_entry.png" width="400"/>
<img alt="Share Dialog" src="/resources/export_in_csv.png" width="400"/>

## Packages

- `flutter_riverpod` for state management
- `intl` for DateTime formatting
- `share` allows sharing of generated .csv file
    
    Moor - local database.
- `moor` core package which defines most apis
- `sqlite3_flutter_libs` ships the latest `sqlite3` version with app
- `path_provider` and `path` used to find right location for database
- `moor_generator` generates query code based on tables
- `build_runner` code-generation tool

    Hive - used to track if there are changes in database since last export. Hive wasn't necessary, I just wanted to learn it.
- `hive` lightweight fast key-value database
- `hive_flutter` extension for hive

## Prerequisites

Make sure you have met the following requirements:
* You have Flutter installed on your machine, if not, you can find it [here](https://flutter.dev).
* You have your IDE of choice with Flutter/Dart plugins (Android Studio / IntelliJ, Visual Studio Code).

## Cloning and running blood_pressure_tracker

Based on your IDE, follow these steps:

IntelliJ:
1. On project's github page press the **Code** button and copy the URL
1. In IntelliJ home screen choose `Get from Version Control` option
1. Paste in URL and choose a directory where project should be saved, then press **Clone**
1. When IntelliJ is fully opened, you should run `flutter pub get` command in terminal which points to project's directory
1. To run project on an emulator or connected device press **Play** button or run `flutter run` command in terminal

Visual Studio Code ([steps took from here](https://dev.to/adityasingh20/how-to-clone-a-flutter-project-in-vscode-5f7b)): 
1. Open VS Code and new window
1. Press `ctrl + shift + p` to make command pallet show
1. Type in Git in the pallet
1. Select the suggested Git:clone option
1. Paste the Git URL in the pallet of the project you have cloned
1. Get dependencies (`flutter pub get`) and run the project (`flutter run`)

## Author

* [Uros Todosijevic](https://github.com/UrosTodosijevic)

<img alt="Share Dialog" src="https://user-images.githubusercontent.com/19648848/99724380-d4a49300-2ab3-11eb-960f-3dcff2eec88e.png" width="400"/> <img alt="Share Dialog" src="https://user-images.githubusercontent.com/19648848/99724380-d4a49300-2ab3-11eb-960f-3dcff2eec88e.png" width="400"/>


