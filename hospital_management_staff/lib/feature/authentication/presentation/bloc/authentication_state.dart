

import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/sign_in_staff.dart';

class SignInDoctorState extends BaseState {
  SignInStaffModel? model;

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