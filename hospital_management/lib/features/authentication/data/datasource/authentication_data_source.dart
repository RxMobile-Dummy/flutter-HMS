import 'package:hospital_management/features/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_alleries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_food_prefrence_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_injuries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_medication_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_surgery_model.dart';
import 'package:hospital_management/features/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_in_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';

import '../../domain/usecases/add_patient_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/get_allergies_usecase.dart';
import '../../domain/usecases/get_food_preference_usecase.dart';
import '../../domain/usecases/get_injuries_usecase.dart';
import '../../domain/usecases/get_medication_usecase.dart';
import '../../domain/usecases/get_surgery_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/sign_in_patient_usecase.dart';

abstract class AuthenticationDataSource {
  Future<GetAllergiesModel> getAlleriesCall(GetAllergiesParams params);
  Future<GetMedicationModel> getMedicationCall(GetMedicationParams params);
  Future<GetInjuriesModel> getInjuriesCall(GetInjuriesParams params);
  Future<GetSurgeryModel> getSurgeryCall(GetSurgeryParams params);
  Future<GetFoodPreferenceModel> getFoodPreferenecCall(GetFoodPreferenceParams params);
  Future<AddPatientModel> addPatientCall(AddPatientParams params);
  Future<SignInPatientModel> signInPatientCall(SignInParams params);
  Future<ForgotPasswordModel> forgotPasswordCall(ForgotPasswordParams params);
  Future<ResetPasswardModel> resetPasswordCall(ResetPasswordParams params);
}