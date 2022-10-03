import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
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

import '../../../../core/api_call/baseClient.dart';
import 'package:path/path.dart' as pathManager;
import 'package:http/http.dart' as http;

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final ApiClient _apiClient;

  AuthenticationDataSourceImpl(this._apiClient);

  @override
  Future<GetAllergiesModel> getAlleriesCall(GetAllergiesParams params) async{
    final response = await _apiClient.getAllergies();
    print(response);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print(Strings.kFailed);
    }
    return data;
  }

  @override
  Future<GetMedicationModel> getMedicationCall(GetMedicationParams params) async {
    final response = await _apiClient.getMedication();
    print(response);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print(Strings.kFailed);
    }
    return data;
  }

  @override
  Future<GetInjuriesModel> getInjuriesCall(GetInjuriesParams params) async {
    final response = await _apiClient.getInjuries();
    print(response);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print(Strings.kFailed);
    }
    return data;
  }

  @override
  Future<GetSurgeryModel> getSurgeryCall(GetSurgeryParams params) async {
    final response = await _apiClient.getSurgery();
    print(response);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print(Strings.kFailed);
    }
    return data;
  }

  @override
  Future<GetFoodPreferenceModel> getFoodPreferenecCall(GetFoodPreferenceParams params) async{
    final response = await _apiClient.getFoodPreference();
    print(response);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print(Strings.kFailed);
    }
    return data;
  }

  @override
  Future<AddPatientModel> addPatientCall(AddPatientParams params) async{
    MultipartFile? multipartFile;
    if(params.profilePic!.isNotEmpty) {
      if(!params.profilePic![0].contains(CommonKeys.K_Patient_Images)) {
        multipartFile =
        await MultipartFile.fromFile(
          params.profilePic ?? "",
          filename: pathManager.basename(params.profilePic ?? ""),
        );
      }
    }
   /* MultipartFile multipartFile =
    await MultipartFile.fromFile(params.profilePic ?? "", filename: pathManager.basename(params.profilePic ?? ""));*/
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_First_Name] = params.firstName;
    map[CommonKeys.K_Last_Name] = params.lastName;
    map[CommonKeys.K_Contact_Number] = params.contactNumber;
    map[CommonKeys.K_Password] = params.password;
    map[CommonKeys.K_Email] = params.email;
    map[CommonKeys.K_Gender] = params.gender;
    map[CommonKeys.K_Date_Of_Birth] = params.dateOfBirth;
    map[CommonKeys.K_Blood_Group] = params.bloodGroup;
    map[CommonKeys.K_Marital_Status] = params.maritalStatus;
    map[CommonKeys.K_Height] = params.height;
    map[CommonKeys.K_Weight] = params.weight;
    map[CommonKeys.K_Emergency_Contact_Number] = params.emergencyContactNumber;
    map[CommonKeys.K_City] = params.city;
    map[CommonKeys.K_Allergy] = params.allergy;
    print(params.allergy);
    map[CommonKeys.K_Current_Medication] = params.currentMedication;
    map[CommonKeys.K_Past_Injury] = params.pastInjury;
    map[CommonKeys.K_Past_Surgery] = params.pastSurgery;
    map[CommonKeys.K_Smoking_Habit] = params.smokingHabits;
    map[CommonKeys.K_Alcohol_Consumption] = params.alcoholCunsumption;
    map[CommonKeys.K_Activity_Level] = params.activityLevel;
    map[CommonKeys.K_Food_Preference] = params.foodPreference;
    map[CommonKeys.K_Occupation] = params.occupation;
    map[CommonKeys.K_Profile_Pic] =   params.profilePic!.isNotEmpty ? multipartFile : params.profilePic;
    FormData formData =  FormData.fromMap(map);
    print(formData);
     final response = await _apiClient.addPatient(formData);
    print(response.error);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print(Strings.kFailed);
    }
    return data;
  }

  @override
  Future<SignInPatientModel> signInPatientCall(SignInParams params) async{
    var map = new HashMap<String, String>();
    map[CommonKeys.K_Email] = params.email;
    map[CommonKeys.K_Password] = params.password;
    final response = await _apiClient.signInPatient(map);
    var data ;
    if(response != null ){
      data = response;
      return data;
    }else {
      print(Strings.kFailed);
    }
    return data;
  }

  @override
  Future<ForgotPasswordModel> forgotPasswordCall(ForgotPasswordParams params) async {
    var map = new HashMap<String, String>();
    map[CommonKeys.K_Email] = params.email;
    final response = await _apiClient.forgotPassword(map);
    var data ;
    if(response != null ){
      data = response;
      return data;
    }else {
      print(Strings.kFailed);
    }
    return data;
  }

  @override
  Future<ResetPasswardModel> resetPasswordCall(ResetPasswordParams params) async {
    var map = new HashMap<String, String>();
    map[CommonKeys.K_New_Password] = params.password;
    map[CommonKeys.K_OTP] = params.OTP;
    final response = await _apiClient.resetPassword(map);
    var data ;
    if(response != null ){
      data = response;
      return data;
    }else {
      print(Strings.kFailed);
    }
    return data;
  }


}