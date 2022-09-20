



import 'package:hospital_management_staff/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/sign_in_staff.dart';
import 'package:hospital_management_staff/feature/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:hospital_management_staff/feature/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:hospital_management_staff/feature/authentication/domain/usecases/sign_in_doctor_usecase.dart';

abstract class AuthenticationDataSource {
  Future<SignInStaffModel> signInDoctorCall(SignInParams params);
  Future<ForgotPasswordModel> forgotPasswordCall(ForgotPasswordParams params);
  Future<ResetPasswardModel> resetPasswordCall(ResetPasswordParams params);
}