import 'package:dartz/dartz.dart';
import 'package:hospital_management/core/failure/failure.dart';
import 'package:hospital_management/core/strings/strings.dart';
import 'package:hospital_management/features/authentication/data/datasource/authentication_data_source.dart';
import 'package:hospital_management/features/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_alleries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_food_prefrence_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_injuries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_medication_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_surgery_model.dart';
import 'package:hospital_management/features/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_in_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';
import 'package:hospital_management/features/authentication/domain/usecases/add_patient_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_allergies_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_food_preference_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_injuries_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_medication_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_surgery_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/sign_in_patient_usecase.dart';

import '../../../../core/failure/error_object.dart';
import '../../domain/repositories/authentication_repositories.dart';

class AuthenticationRepositoriesImpl extends AuthenticationRepositories{
  AuthenticationDataSource? authenticationDataSource;
  AuthenticationRepositoriesImpl({this.authenticationDataSource});

  @override
  Stream<Either<Failure, GetAllergiesModel>> getAllergiesCall(GetAllergiesParams params) async* {
    try{
      var response = await authenticationDataSource!.getAlleriesCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, GetMedicationModel>> getMedicationCall(GetMedicationParams params) async*{
    try{
      var response = await authenticationDataSource!.getMedicationCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, GetInjuriesModel>> getInjuriesCall(GetInjuriesParams params) async* {
    try{
      var response = await authenticationDataSource!.getInjuriesCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, GetSurgeryModel>> getSurgeryCall(GetSurgeryParams params) async* {
    try{
      var response = await authenticationDataSource!.getSurgeryCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, GetFoodPreferenceModel>> getFoodPreferenceCall(GetFoodPreferenceParams params) async* {
    try{
      var response = await authenticationDataSource!.getFoodPreferenecCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, AddPatientModel>> addPatientCall(AddPatientParams params) async* {
    try{
      var response = await authenticationDataSource!.addPatientCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, SignInPatientModel>> signInPatientCall(SignInParams params) async* {
    try{
      var response = await authenticationDataSource!.signInPatientCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, ForgotPasswordModel>> forgotPasswordCall(ForgotPasswordParams params) async*{
    try{
      var response = await authenticationDataSource!.forgotPasswordCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, ResetPasswardModel>> resetPasswordCall(ResetPasswordParams params) async*{
    try{
      var response = await authenticationDataSource!.resetPasswordCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }
}