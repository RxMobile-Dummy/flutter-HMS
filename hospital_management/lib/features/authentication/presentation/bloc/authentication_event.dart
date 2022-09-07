import 'dart:io';

import 'package:hospital_management/features/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_alleries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_injuries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_medication_model.dart';
import 'package:hospital_management/features/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_in_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';

import '../../../../core/base/base_bloc.dart';
import '../../data/model/get_food_prefrence_model.dart';
import '../../data/model/get_surgery_model.dart';

class GetAllergiesEvent extends BaseEvent {
  GetAllergiesEvent();
}

class GetAllergiesSuccessEvent extends BaseEvent {
  GetAllergiesModel? model;

  GetAllergiesSuccessEvent({this.model});
}

class GetMedicationEvent extends BaseEvent {
  GetMedicationEvent();
}

class GetMedicationSuccessEvent extends BaseEvent {
  GetMedicationModel? model;

  GetMedicationSuccessEvent({this.model});
}

class GetInjuriesEvent extends BaseEvent {
  GetInjuriesEvent();
}

class GetInjuriesSuccessEvent extends BaseEvent {
  GetInjuriesModel? model;

  GetInjuriesSuccessEvent({this.model});
}

class GetSurgeryEvent extends BaseEvent {
  GetSurgeryEvent();
}

class AddPatientEvent extends BaseEvent {
  String? firstName,lastName,contactNumber, password,email,
      gender,dateOfBirth,bloodGroup, maritalStatus,height,weight, emergencyContactNumber,city, allergy,currentMedication,
      pastInjury,pastSurgery, smokingHabits, alcoholConsumption,activityLevel, foodPreference,occupation;
  String? profilePic;
  AddPatientEvent({
    this.profilePic,
    this.weight,
    this.smokingHabits,
    this.pastSurgery,
    this.pastInjury,
    this.maritalStatus,
    this.gender,
    this.foodPreference,
    this.emergencyContactNumber,
    this.dateOfBirth,
    this.currentMedication,
    this.contactNumber,
    this.city,this.bloodGroup,
    this.alcoholConsumption,
    this.activityLevel,
    this.height,
    this.occupation,
    this.lastName,
    this.firstName,
    this.allergy,
    this.email,
    this.password
});
}

class GetSurgerySuccessEvent extends BaseEvent {
  GetSurgeryModel? model;

  GetSurgerySuccessEvent({this.model});
}

class AddPatientSuccessEvent extends BaseEvent {
  AddPatientModel? model;

  AddPatientSuccessEvent({this.model});
}

class GetFoodPreferenceEvent extends BaseEvent {
  GetFoodPreferenceEvent();
}

class GetFoodPreferenceSuccessEvent extends BaseEvent {
  GetFoodPreferenceModel? model;

  GetFoodPreferenceSuccessEvent({this.model});
}

class SignInPatientEvent extends BaseEvent {
  String email,password;
  SignInPatientEvent({required this.email,required this.password});
}

class SignInPatientSuccessEvent extends BaseEvent {
  SignInPatientModel? model;

  SignInPatientSuccessEvent({this.model});
}

class ForgotPasswordEvent extends BaseEvent {
  String email;
  ForgotPasswordEvent({required this.email});
}

class ForgotPasswordSuccessEvent extends BaseEvent {
  ForgotPasswordModel? model;

  ForgotPasswordSuccessEvent({this.model});
}

class ResetPasswordEvent extends BaseEvent {
  String password,otp;
  ResetPasswordEvent({required this.password,required this.otp});
}

class ResetPasswordSuccessEvent extends BaseEvent {
  ResetPasswardModel? model;

  ResetPasswordSuccessEvent({this.model});
}

class StoreDataEvent extends BaseEvent {
  Map<String,dynamic> map;
  StoreDataEvent({required this.map});
}