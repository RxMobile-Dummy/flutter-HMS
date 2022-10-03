
# Hospital Management Staff Module


Hospital Management Staff application is basically use for staff member in hospital for see the appointment list. Also Pharmacist can also use this application for add,update,delete and see the medicine. Also laboratory person can use this application for generate report and update for particular person report suggestion given by doctor.

## Features

  * Sign up
      *  We provide functionality to add staff member from admin panel with profile photo, year of experience, qualification he/she have, blood group, gender, date of birth, email, contact number and some basic other details.
  * Sign In
      *  If you log out your application and you have credentials email and password. So you can sign in with email and password.
  * Forgot password
      *  If you forgot your password then you need to enter email (Only work with radix email). After enter email in you will receive 6 digit code.
  * Reset password
      *  After adding email for reset password you will redirect to reset password screen. Here you have to enter 6 digit code that you received in your            email id with password. So you can reset your password easily.
  * Home Screen
      *  In this application in home screen you can see total appointments available in Hospital also you can see total appointments available current day. In Body part there is 5 card is there 1). Appointments 2). Profile 3). Patients 4). Medicine 5). Laboratory.
  * Appointments Screen
      *  In this screen you can see all the appointments list available in hospital.
  * Appointment Details Screen
      *  In Appointment details screen staff member can see all the patient details those patient entered at the time of book appointment like name, disease that patient have, appointment date, slot that patient book, date of birth, report that patient added.appointments and some basic other information.
  * Patients Screen
      *  In this screen staff member can easy see all the past patient record. Here search functionality provide so staff member can easily search based on first name and last name.
  * Patient Details Screen
      *  When you click on particular patient it will redirect you to patient details screen in this you can see all the patient details with name, date of birth, disease he/she have, report suggestion that doctor given, medicine suggestion that doctor given, past report that patient had uploaded and some basic other information.
  * Profile screen
      *  In Profile screen staff member can see his/her whole profile. Here 3 option available 1). Personal information 2). Update Profile. 3). Logout. When you click on Personal information staff member can see his/her all the information that were added at the time sign up.
  * Update Profile
      *  In Update profile screen staff member can change his/her profile with profile photo, qualification, email, contact number with other some basic information.
  * Log out
      * In Profile screen there is one option for log out from application you will log out after click on that button and you will reach to log in screen.
  * Add Medicine Screen
      * In add medicine screen Pharmacist can add medicine with medicine name, prescription required or not, stock available, how much amount of stock sold, medicine MG, medicine quantity, expiry date, manufacture date, medicine picture, and some other basic details.
  * Update Medicine Screen
      * In Update Medicine Screen Pharmacist can update medicine all the details with how much amount of stock available now, how much amount of medicine sold, expiry date, and some other information that added at the time of add medicine.
  * Medicine Screen
      * In medicine list screen you can see all the medicine list with medicine picture, medicine price, how much amount of MG is there in particular medicine, how much amount od item sold and some other details.
  * Medicine Details Screen
      * In Medicine details screen staff member can see all the medicine details with medicine image, price of that medicine, prescription required or not, manufacture date, expiry date, how much amount of item sold, how much amount of item remaining, How much MG are there in particular medicine and other some details.
  * Delete Medicine Screen
      * In Delete medicine screen Pharmacist can delete particular medicine.
  * Patient Report Screen
      * In Patient Report screen All the appointment list is there that is done by doctor. Also there is search functionality provided for search particular appointment in patient report module.
  * Upload Patient Report Screen
      * In Upload Patient Report Screen laboratory person can upload report image as well as in .pdf format. In this screen laboratory person can see all the report list that is suggested by Doctor for particular patient.


## Approach
- Used clean architecture with bloc pattern for implementing hospital management staff module project.

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
- Run command ```cd hospital_management_staff```
- Run command in terminal ```flutter pub get ```
- After that run this command ```flutter packages pub run build_runner build --delete-conflicting-outputs``` for generate .g.dart file
- For development debug: ```flutter run -t lib/main.dart```

## How to generate apk/ipa for project
Use below command to generate apk/ipa of project based on your requirement
- For development apk: ```flutter build apk -t lib/main.dart```
- For development ipa: ```flutter build ipa -t lib/main.dart```

## Directory Structure

```s
.
├── assets
│   └── images
├── lib
│   ├── core
│   │   ├── api_call
│   │   │   ├── api_constant.dart
│   │   │   ├── base_client.dart
│   │   │   ├── base_client.g.dart
│   │   │   └── base_response.dart
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
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       └── pages
│   │   ├── laboratory
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
│   │   ├── colors.dart
│   │   ├── device_file.dart
│   │   └── style.dart
│   ├── widget
│   │   ├── custom_appbar.dart
│   │   ├── custom_button.dart
│   │   ├── date_picker.dart
│   │   ├── drop_down.dart
│   │   ├── expandable_text.dart
│   │   ├── multi_select_chip.dart
│   │   ├── multi_selection_widget.dart
│   │   ├── open_image_widget.dart
│   │   ├── open_pdf_widget.dart
│   │   ├── radio_widget.dart
│   │   ├── size.dart
│   │   ├── splash.dart
│   │   ├── star_display_widget.dart
│   │   ├── text_field_with_border.dart
│   │   └── text_field.dart
│   ├── injection_container.dart
│   └── main.dart
├── test
│   └── widget_test.dart
├── pubspec.yaml
└── README.md
```






