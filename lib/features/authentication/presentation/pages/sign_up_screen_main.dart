import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:hospital_management/features/authentication/presentation/pages/keep_alive_data_page.dart';
import 'package:hospital_management/features/authentication/presentation/pages/sign_up_screen1.dart';
import 'package:hospital_management/features/authentication/presentation/pages/sign_up_screen2.dart';
import 'package:hospital_management/features/authentication/presentation/pages/sign_up_screen3.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/error_bloc_builder/error_builder_listener.dart';
import '../../../../custom/progress_bar.dart';
import '../../../home.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_event.dart';

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
          height: registrationDataMap["height"],
          email: registrationDataMap['email'],
          profilePic: registrationDataMap['profile_pic'],
          lastName: registrationDataMap['last_name'],
          firstName: registrationDataMap['first_name'],
          password: registrationDataMap['password'],
          occupation: registrationDataMap['occupation'],
          activityLevel: registrationDataMap['activity_level'],
          alcoholConsumption: registrationDataMap['alchol_consumption'],
          allergy: registrationDataMap['allergy'],
          bloodGroup: registrationDataMap['blood_group'],
          city: registrationDataMap['city'],
          contactNumber: registrationDataMap['contact_number'],
          currentMedication: registrationDataMap['current_medication'],
           dateOfBirth: registrationDataMap['date_of_birth'],
           emergencyContactNumber: registrationDataMap['emergency_contact_number'],
          foodPreference: registrationDataMap['food_preference'],
           gender: registrationDataMap['gender'],
          maritalStatus: registrationDataMap['marital_status'],
          pastInjury: registrationDataMap['past_injury'],
          pastSurgery: registrationDataMap['past_surgery'],
          smokingHabits: registrationDataMap['smoking_habits'],
          weight: registrationDataMap['weight']
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
                    MaterialPageRoute(builder: (context) => Home()),
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
