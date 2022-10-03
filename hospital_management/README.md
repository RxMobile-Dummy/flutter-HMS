# Hospital Management Patient Module


Hospital Management Patient application is basically use for book particular doctor's appointment online instead of go to hospital and book appointment. Also patient can see how many department and who doctor special for particular health issue.
Also patient can track their appointment with different doctor.

## Features

  * Sign up
      *  Before you want to use application functionality you need to sign up first with first name, last name, mobile, email , password, blood group, gender, allergies that you have, past surgery that you had, past injury that you have, if you consume alcohol or not, are you married or not, your weight, your height, you job details and with other basic details.
  * Sign In
      *  If you log out your application and you have credentials email and password. So you can sign in with email and password.
  * Forgot password
      *  If you forgot your password then you need to enter email (Only work with radix email). After enter email in you will receive 6 digit code.
  * Reset password
      *  After adding email for reset password you will redirect to reset password screen. Here you have to enter 6 digit code that you received in your            email id with password. So you can reset your password easily.
  * Home Screen
      *  In this application in home screen you can see in appbar that how many doctor is there in this hospital. Also you can see that how many total appointments that you have booked. And in body part there is 3 card is there. 1) Doctors. 2) Appointments. 3) Profile.
  * Doctors Screen
      *  In this doctors screen total doctors list in the hospital you can see with their appointment fees, year of experience they have, in which field they are specialist, their photo, also with mobile number and and other basic information.
  * Doctor Details Screen
      *  When you click on particular doctor in doctor list screen then it will redirect you to doctor details screen. In this screen you can see whole doctor profile like doctor profile photo, their appointment charges, in which field he/she is specialist, how many years of experience they have, their contact details, which degree they have achieved and also with patient comments and rating that particular doctor received from patients.
  * Book Appointment
      *  In doctors list screen on particular doctor card at top side you can see one button for book appointment for particular doctor. On click of that button it will redirect to you on book appointment screen. In that screen you need to enter some information like first name, last name, contact details, your profile pic, your past report (In PDF), what disease you, appointment date and in which slot you need to book your appointment. And book appointment for that doctor.
  * Appointments List Screen
      *  In This appointment list screen you can see all your appoints that you have booked. Also there is one option for apply filter based on date so you can easily find appointments that you have booked for a particular date. Also there is another reset filter option is there for getting all the appointment that you have booked.
  * Appointment Details Screen
      *  When you click on particular appointment in appointment list screen then will redirect to you to appointment details screen. In this screen you will see youa appointment information list slot time, appointment date, report suggestion that doctor given, medicine suggestion that doctor given, also your application status.
  * Edit appointment
      *  In appointment list screen you can see one option for edit appointment on top of particular appointment card. When you click on that option it will redirect you to edit appointment with all the details that you have enter at the time of book appointment. You can change you basic all details with slot time, appointment date.
  * Delete Appointment
      *  In appointment list screen you can see one delete option for delete your appointment on top of particular appointment card. When you click on that option one dialog will open for taken permission from patient when you click on yes it will delete your appointment.
  * Profile screen
      *  In Profile screen patient can see his/her all profile with all the information that he/she had enter at the time sign up. In profile screen we divide whole information in 2 section 1). Personal Information 2). Medical Information. You can see your personal information in personal information section and you can see your medical information in medical section. Also there is one option for update your profile. And there is one more option for log out from application.
  * Update Profile
      *  On click of update profile screen it will redirect you to update patient profile with all the information that you have entered at the time of sign up. So basically you can update all your details from there.
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
- Run command ```cd hospital_management```
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
│   ├── features
│   │   ├── appoinment
│   │   │   ├── data
│   │   │   │   ├── datasource
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
│   │   │   │   ├── datasource
│   │   │   │   ├── model
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   ├── repositories
│   │   │   │   └── usecases
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       └── pages
│   │   ├── doctor
│   │   │   ├── data
│   │   │   │   ├── datasource
│   │   │   │   ├── model
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   ├── repositories
│   │   │   │   └── usecases
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       └── pages
│   │   ├── feedback
│   │   │   ├── data
│   │   │   │   ├── datasource
│   │   │   │   ├── model
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   ├── repositories
│   │   │   │   └── usecases
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       └── page
│   │   ├── profile
│   │   │   ├── data
│   │   │   │   ├── datasource
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
│   ├── injection_container.dart
│   └── main.dart
├── test
│   └── widget_test.dart
├── pubspec.yaml
└── README.md
```






