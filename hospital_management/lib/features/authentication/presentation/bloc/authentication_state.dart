import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_alleries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_food_prefrence_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_injuries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_medication_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_surgery_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_in_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';

import '../../../../core/base/base_bloc.dart';
import '../../data/model/reset_password_model.dart';

class GetAllergiesState extends BaseState {
  GetAllergiesModel? model;

  GetAllergiesState({this.model});
}

class GetMedicationState extends BaseState {
  GetMedicationModel? model;

  GetMedicationState({this.model});
}

class GetInjuriesState extends BaseState {
  GetInjuriesModel? model;

  GetInjuriesState({this.model});
}

class GetSurgeryState extends BaseState {
  GetSurgeryModel? model;

  GetSurgeryState({this.model});
}

class GetFoodPreferenceState extends BaseState {
  GetFoodPreferenceModel? model;

  GetFoodPreferenceState({this.model});
}

class AddPatientState extends BaseState {
  AddPatientModel? model;

  AddPatientState({this.model});
}

class SignInPatientState extends BaseState {
  SignInPatientModel? model;

  SignInPatientState({this.model});
}
class ForgotPasswordState extends BaseState {
  ForgotPasswordModel? model;

  ForgotPasswordState({this.model});
}

class ResetPasswordState extends BaseState {
  ResetPasswardModel? model;

  ResetPasswordState({this.model});
}


class StoreDataState extends Equatable {
  Map<String,dynamic>? map;

  StoreDataState({this.map});

  @override
  List<Object?> get props => [];
}