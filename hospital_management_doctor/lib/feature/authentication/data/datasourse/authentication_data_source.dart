import 'package:hospital_management_doctor/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/reset_password_usecase.dart';

import '../../domain/usecases/sign_in_doctor_usecase.dart';
import '../model/sign_in_doctor.dart';

abstract class AuthenticationDataSource {
  Future<SignInDoctorModel> signInDoctorCall(SignInParams params);
  Future<ForgotPasswordModel> forgotPasswordCall(ForgotPasswordParams params);
  Future<ResetPasswardModel> resetPasswordCall(ResetPasswordParams params);
}