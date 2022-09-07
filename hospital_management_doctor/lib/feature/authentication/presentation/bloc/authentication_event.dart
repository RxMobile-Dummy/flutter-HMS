import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/sign_in_doctor.dart';

class SignInDoctorEvent extends BaseEvent {
  String email,password;
  SignInDoctorEvent({required this.email,required this.password});
}

class SignInDoctorSuccessEvent extends BaseEvent {
  SignInDoctorModel? model;

  SignInDoctorSuccessEvent({this.model});
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