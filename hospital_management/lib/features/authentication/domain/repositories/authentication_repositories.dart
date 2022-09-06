import 'package:dartz/dartz.dart';
import 'package:hospital_management/core/failure/failure.dart';
import 'package:hospital_management/features/authentication/data/model/get_alleries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_food_prefrence_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_injuries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_medication_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_surgery_model.dart';
import 'package:hospital_management/features/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_in_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_allergies_usecase.dart';

import '../../data/model/forgot_password_model.dart';
import '../usecases/add_patient_usecase.dart';
import '../usecases/forgot_password_usecase.dart';
import '../usecases/get_food_preference_usecase.dart';
import '../usecases/get_injuries_usecase.dart';
import '../usecases/get_medication_usecase.dart';
import '../usecases/get_surgery_usecase.dart';
import '../usecases/reset_password_usecase.dart';
import '../usecases/sign_in_patient_usecase.dart';

abstract class AuthenticationRepositories {
  Stream<Either<Failure, GetAllergiesModel>> getAllergiesCall(GetAllergiesParams params);
  Stream<Either<Failure, GetMedicationModel>> getMedicationCall(GetMedicationParams params);
  Stream<Either<Failure, GetInjuriesModel>> getInjuriesCall(GetInjuriesParams params);
  Stream<Either<Failure, GetSurgeryModel>> getSurgeryCall(GetSurgeryParams params);
  Stream<Either<Failure, GetFoodPreferenceModel>> getFoodPreferenceCall(GetFoodPreferenceParams params);
  Stream<Either<Failure, AddPatientModel>> addPatientCall(AddPatientParams params);
  Stream<Either<Failure, SignInPatientModel>> signInPatientCall(SignInParams params);
  Stream<Either<Failure, ForgotPasswordModel>> forgotPasswordCall(ForgotPasswordParams params);
  Stream<Either<Failure, ResetPasswardModel>> resetPasswordCall(ResetPasswordParams params);
}