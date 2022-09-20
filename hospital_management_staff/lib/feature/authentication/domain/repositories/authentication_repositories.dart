import 'package:dartz/dartz.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/sign_in_staff.dart';
import 'package:hospital_management_staff/feature/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:hospital_management_staff/feature/authentication/domain/usecases/reset_password_usecase.dart';

import '../../../../core/failure/failure.dart';
import '../usecases/sign_in_doctor_usecase.dart';

abstract class AuthenticationRepositories {
  Stream<Either<Failure, SignInStaffModel>> signInDoctorCall(SignInParams params);
  Stream<Either<Failure, ForgotPasswordModel>> forgotPasswordCall(ForgotPasswordParams params);
  Stream<Either<Failure, ResetPasswardModel>> resetPasswordCall(ResetPasswordParams params);
}