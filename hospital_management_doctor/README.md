
# Hospital Management Doctor Module


Hospital Management Doctor application is basically use for tack appointment that patients booked. Also doctor can give suggestion to patient regarding medicine and which report needed.

## Features

  * Sign up
      *  We provide functionality to add doctor from admin panel with profile photo, in which field he/she specialist, year of experience, qualification he/she have, appointment fees, in which slot he/she is available and some other basic information.
  * Sign In
      *  If you log out your application and you have credentials email and password. So you can sign in with email and password.
  * Forgot password
      *  If you forgot your password then you need to enter email (Only work with radix email). After enter email in you will receive 6 digit code.
  * Reset password
      *  After adding email for reset password you will redirect to reset password screen. Here you have to enter 6 digit code that you received in your            email id with password. So you can reset your password easily.
  * Home Screen
      *  In this application in home screen you can see total appointments available for particular doctor as well as how many appointment available for today. In body part there are 3 cards is there 1). Appointments 2).Patients 3). Profile.
  * Appointments Screen
      *  In this screen you can see all the appointments list for particular doctor. Also there is edit option available for give medicine suggestion, report suggestion and also change appointment status. Also there is option available for filter appointment with date so doctor can easy find appointments for particular date. Also there is reset filter functionality available for get all the appointments list.
  * Appointment Details Screen
      *  In Appointment details screen doctor can see all the patient details those patient entered at the time of book appointment like name, disease patient have, appointment date, slot that patient book, date of birth, report that patient added.appointments and some basic other information.
  * Edit Appointment Screen
      *  In this screen doctor can edit appointment with change status of appointment, give medicine suggestion, and report suggestion if required then.
  * Patients Screen
      *  In this screen doctor can easy see all the past patient record. Here search functionality provide so doctor can easily search based on first name and last name.
  * Patient Details Screen
      *  When you click on particular patient it will redirect you to patient details screen in this you cann see all the patient details with name, date of birth, disease he/she have, report suggestion that doctor given, medicine suggestion that doctor given, past report that patient had uploaded and some basic other information.
  * Profile screen
      *  In Profile screen doctor can see his/her whole profile. Here 3 option available 1). Doctor personal information 2). Update Profile. 3). Logout. When you click on Personal information doctor can see his/her all the information at the time of ad doctor his/her added.
  * Update Profile
      *  In Update profile screen doctor can change his/her profile with profile photo, year of experience, appointment fees, qualification, specialist fields that she/he have, with other some basic information.
  * Log out
      * In Profile screen there is one option for log out from application you will log out after click on that button and you will reach to log in screen.

## Approach
- Used clean architecture with bloc pattern for implementing hospital management patient module project.

## Naming Conventions


- Folder Name : your_folder_name
- File Name : your_file_name.dart
- Start File in Each Folder: index.dart
- Class Name : YourClassName
- Variable Name : yourVariableName
- Private Variable : \_yourPrivateVariable
- Constant Variable Name : CONSTANT_VARIABLE_NAME
- Function Name : yourFunctionName
- Private Function Name : \_yourPrivateFunctionName



## Commit Format


- :tada: initial commit.

- :rocket: [Add] when implementing a new feature. 

- :hammer: [Fix] when fixing a bug or issue. 

- :art: [Refactor] when refactor/improving code. 

- :construction: [WIP]- when the particular task is still under process.

- :pencil: [Minor] Some small updates.


## Git Branch Naming Conventions


```
- New feature: feature/feat-oct11-jira-ticket-number
- Bug: bug/bug-oct11-jira-ticket-number
- Documentation: doc-oct11-jira-ticket-number
- Code Improvement: refact-oct11-jira-ticket-number
- Any Other: minor-oct11-jira-ticket-number
- Until your feature is completed, you will be working in the same branch. We will get PR's from same branch at EOD,everyday.
- If started with new feature on new branch & has some dependency with last day's branch (If the branch is still not merged yet) then you are free to take pull from your own last day branch (This is only applicable for preceeding day)
```

## How to run a project
Use below command to run project based on your requirement
- Clone project from git.
- Run command ```cd hospital_management_doctor```
- Run command in terminal ```flutter pub get ```
- After that run this command ```flutter packages pub run build_runner build --delete-conflicting-outputs``` for generate .g.dart file
- For development debug: ```flutter run -t lib/main.dart```

## How to generate apk/ipa for project
Use below command to generate apk/ipa of project based on your requirement
- For development apk: ```flutter build apk -t lib/main.dart```
- For development ipa: ```flutter build ipa -t lib/main.dart```

## Directory Structure

```s
├── assets
│   └── images
├── lib
│   ├── core
│   │   ├── api_call
│   │   │   ├── api_constant.dart
│   │   │   ├── base_response.dart
│   │   │   ├── baseClient.dart
│   │   │   └── baseClient.g.dart
│   │   ├── base
│   │   │   ├── base_bloc.dart
│   │   │   ├── base_event.dart
│   │   │   └── base_state.dart
│   │   ├── common_keys
│   │   │   └── common_keys.dart
│   │   ├── error_bloc_builder
│   │   │   └── error_builder_listener.dart
│   │   ├── failure
│   │   │   ├── error_object.dart
│   │   │   ├── exceptions.dart
│   │   │   └── failure.dart
│   │   ├── strings
│   │   │   └── strings.dart
│   │   └── usecase.dart
│   ├── custom
│   │   ├── curve_painter.dart
│   │   └── progress_bar.dart
│   ├── feature
│   │   ├── appointments
│   │   │   ├── data
│   │   │   │   ├── datasourse
│   │   │   │   ├── model
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   ├── repositories
│   │   │   │   └── usecases
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       └── pages
│   │   ├── authentication
│   │   │   ├── data
│   │   │   │   ├── datasourse
│   │   │   │   ├── model
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   ├── repositories
│   │   │   │   └── usecases
│   │   │       ├── bloc
│   │   │       └── pages
│   │   ├── medicine
│   │   │   ├── data
│   │   │   │   ├── datasourse
│   │   │   │   ├── model
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   ├── repositories
│   │   │   │   └── usecases
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       └── pages
│   │   ├── patient
│   │   │   ├── data
│   │   │   │   ├── datasourse
│   │   │   │   ├── model
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   ├── repositories
│   │   │   │   └── usecases
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       └── pages
│   │   ├── profile
│   │   │   ├── data
│   │   │   │   ├── datasourse
│   │   │   │   ├── model
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   ├── repositories
│   │   │   │   └── usecases
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       └── pages
│   │   ├── home.dart
│   │   └── onboarding.dart
│   ├── utils
│   ├── widget
│   ├── injection_container.dart
│   └── main.dart
├── test
│   └── widget_test.dart
├── pubspec.yaml
└── README.md
```






