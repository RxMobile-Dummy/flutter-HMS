import 'package:dartz/dartz.dart';
import 'package:hospital_management_doctor/core/failure/error_object.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/feature/authentication/data/datasourse/authentication_data_source.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/sign_in_doctor.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/repositories/authentication_repositories.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/sign_in_doctor_usecase.dart';

class AuthenticationRepositoriesImpl extends AuthenticationRepositories{
  AuthenticationDataSource? authenticationDataSource;
  AuthenticationRepositoriesImpl({this.authenticationDataSource});

  @override
  Stream<Either<Failure, SignInDoctorModel>> signInDoctorCall(SignInParams params)async* {
    try{
      var response = await authenticationDataSource!.signInDoctorCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, ForgotPasswordModel>> forgotPasswordCall(ForgotPasswordParams params)async* {
    try{
      var response = await authenticationDataSource!.forgotPasswordCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, ResetPasswardModel>> resetPasswordCall(ResetPasswordParams params) async* {
    try{
      var response = await authenticationDataSource!.resetPasswordCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

}