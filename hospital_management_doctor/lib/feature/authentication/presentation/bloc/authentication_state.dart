import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/sign_in_doctor.dart';

class SignInDoctorState extends BaseState {
  SignInDoctorModel? model;

  SignInDoctorState({this.model});
}

class ForgotPasswordState extends BaseState {
  ForgotPasswordModel? model;

  ForgotPasswordState({this.model});
}

class ResetPasswordState extends BaseState {
  ResetPasswardModel? model;

  ResetPasswordState({this.model});
}