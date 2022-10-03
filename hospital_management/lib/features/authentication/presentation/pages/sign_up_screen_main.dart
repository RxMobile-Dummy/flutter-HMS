import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:hospital_management/features/authentication/presentation/pages/keep_alive_data_page.dart';
import 'package:hospital_management/features/authentication/presentation/pages/sign_up_screen1.dart';
import 'package:hospital_management/features/authentication/presentation/pages/sign_up_screen2.dart';
import 'package:hospital_management/features/authentication/presentation/pages/sign_up_screen3.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/error_bloc_builder/error_builder_listener.dart';
import '../../../../custom/progress_bar.dart';
import '../../../appoinment/presentation/bloc/appointment_bloc.dart';
import '../../../doctor/presentation/bloc/doctor_bloc.dart';
import '../../../home.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_event.dart';
import 'package:hospital_management/injection_container.dart' as Sl;

class SignUpScreenMain extends StatefulWidget {
  const SignUpScreenMain({Key? key}) : super(key: key);

  @override
  _SignUpScreenMainState createState() => _SignUpScreenMainState();
}

class _SignUpScreenMainState extends State<SignUpScreenMain>  {
  PageController pageviewController = PageController(keepPage: true);
  Map<String,dynamic> registrationDataMap = Map();

  List<dynamic> screenList =[];
  @override
  void initState() {
    screenList = [
      KeepAlivePage(child: SignUpScreen1(pageController: pageviewController,nextClick: (value){
        registrationDataMap.addAll(value);
        print(registrationDataMap);
      }),),
      KeepAlivePage(child:  SignUpScreen3(pageController: pageviewController,nextClick: (value){
        registrationDataMap.addAll(value);
        print(registrationDataMap);
      }),),
      KeepAlivePage(child:  SignUpScreen2(pageController: pageviewController,nextClick: (value){
        registrationDataMap.addAll(value);
        _signUpUser(
          height: registrationDataMap[CommonKeys.K_Height],
          email: registrationDataMap[CommonKeys.K_Email],
          profilePic: registrationDataMap[CommonKeys.K_Profile_Pic],
          lastName: registrationDataMap[CommonKeys.K_Last_Name],
          firstName: registrationDataMap[CommonKeys.K_First_Name],
          password: registrationDataMap[CommonKeys.K_Password],
          occupation: registrationDataMap[CommonKeys.K_Occupation],
          activityLevel: registrationDataMap[CommonKeys.K_Activity_Level],
          alcoholConsumption: registrationDataMap[CommonKeys.K_Alcohol_Consumption],
          allergy: registrationDataMap[CommonKeys.K_Allergy],
          bloodGroup: registrationDataMap[CommonKeys.K_Blood_Group],
          city: registrationDataMap[CommonKeys.K_City],
          contactNumber: registrationDataMap[CommonKeys.K_Contact_Number],
          currentMedication: registrationDataMap[CommonKeys.K_Current_Medication],
           dateOfBirth: registrationDataMap[CommonKeys.K_Date_Of_Birth],
           emergencyContactNumber: registrationDataMap[CommonKeys.K_Emergency_Contact_Number],
          foodPreference: registrationDataMap[CommonKeys.K_Food_Preference],
           gender: registrationDataMap[CommonKeys.K_Gender],
          maritalStatus: registrationDataMap[CommonKeys.K_Marital_Status],
          pastInjury: registrationDataMap[CommonKeys.K_Past_Injury],
          pastSurgery: registrationDataMap[CommonKeys.K_Past_Surgery],
          smokingHabits: registrationDataMap[CommonKeys.K_Smoking_Habit],
          weight: registrationDataMap[CommonKeys.K_Weight]
        );
        print(registrationDataMap);
      }),),
    ];
    super.initState();
  }

  Future<String> _signUpUser({
    String? firstName,
    String? lastName,
    String? contactNumber,
    String? password,
    String? email,
    String? gender,
    String? dateOfBirth,
    String? bloodGroup,
    String? maritalStatus,
    String? height,
    String? weight,
    String? emergencyContactNumber,
    String? city,
    String? allergy,
    String? currentMedication,
    String? pastInjury,
    String? pastSurgery,
    String? smokingHabits,
    String? alcoholConsumption,
    String? activityLevel,
    String? foodPreference,
    String? occupation,
    String? profilePic,
  }) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AuthenticationBloc>(context).add(
          AddPatientEvent(
            weight: weight,
            smokingHabits: smokingHabits,
            pastSurgery: pastSurgery,
            pastInjury: pastInjury,
            maritalStatus: maritalStatus,
            gender: gender,
            foodPreference: foodPreference,
            emergencyContactNumber: emergencyContactNumber,
            dateOfBirth: dateOfBirth,
            currentMedication: currentMedication,
            contactNumber: contactNumber,
            city: city,
            bloodGroup: bloodGroup,
            allergy: allergy,
            alcoholConsumption: alcoholConsumption,
            activityLevel: activityLevel,
            occupation: occupation,
            password: password,
            firstName: firstName,
            lastName: lastName,
            profilePic: profilePic,
            email: email,
            height: height,
          ));
      return "";
    });
  }
  @override
  Widget build(BuildContext context) {
    return  ErrorBlocListener<AuthenticationBloc>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      child: BlocBuilder<AuthenticationBloc,BaseState>(
          builder: (context, state) {
            if(state is AddPatientState){
              ProgressDialog.hideLoadingDialog(context);
              AddPatientModel? model = state.model;
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider<AppointmentBloc>(
                            create: (context) => Sl.Sl<AppointmentBloc>(),
                          ),
                          BlocProvider<DoctorBloc>(
                            create: (context) => Sl.Sl<DoctorBloc>(),
                          ),
                        ],
                        child: Home())),
                        (route) => false);
              });
            }
            return Container(
              child: PageView.builder(

                itemBuilder: (context, index) {
                  return screenList[index];
                },
                controller: pageviewController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: screenList.length,
              ),
            );
          }
      ),
    );
  }
}
