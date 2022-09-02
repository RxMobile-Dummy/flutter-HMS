import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
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
      print('failed');
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
      print('failed');
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
      print('failed');
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
      print('failed');
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
      print('failed');
    }
    return data;
  }

  @override
  Future<AddPatientModel> addPatientCall(AddPatientParams params) async{
    MultipartFile multipartFile =
    await MultipartFile.fromFile(params.profilePic ?? "", filename: pathManager.basename(params.profilePic ?? ""));
    var map =  HashMap<String, dynamic>();
    map['first_name'] = params.firstName;
    map['last_name'] = params.lastName;
    map['contact_number'] = params.contactNumber;
    map['password'] = params.password;
    map['email'] = params.email;
    map['gender'] = params.gender;
    map['date_of_birth'] = params.dateOfBirth;
    map['blood_group'] = params.bloodGroup;
    map['marital_status'] = params.maritalStatus;
    map['height'] = params.height;
    map['weight'] = params.weight;
    map['emergency_contact_number'] = params.emergencyContactNumber;
    map['city'] = params.city;
    map['allergy'] = params.allergy;
    print(params.allergy);
    map['current_medication'] = params.currentMedication;
    map['past_injury'] = params.pastInjury;
    map['past_surgery'] = params.pastSurgery;
    map['smoking_habits'] = params.smokingHabits;
    map['alchol_consumption'] = params.alcoholCunsumption;
    map['activity_level'] = params.activityLevel;
    map['food_preference'] = params.foodPreference;
    map['occupation'] = params.occupation;
    map['profile_pic'] =  multipartFile;
    FormData formData =  FormData.fromMap(map);
     final response = await _apiClient.addPatient(formData);
   /* print("before api");
    final http.Response response = await http.post(
        Uri.parse('https://f01b-180-211-112-179.in.ngrok.io/patient/add_patient/'),
        headers: <String, String>{
          'Content-Type': 'multipart/form-data',
        },
        body: formData);*/
    print("response for http");
    print(response.error);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print('failed');
    }
    return data;
  }

  @override
  Future<SignInPatientModel> signInPatientCall(SignInParams params) async{
    var map = new HashMap<String, String>();
    map['email'] = params.email;
    map['password'] = params.password;
    final response = await _apiClient.signInPatient(map);
    var data ;
    if(response != null ){
      data = response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }

  @override
  Future<ForgotPasswordModel> forgotPasswordCall(ForgotPasswordParams params) async {
    var map = new HashMap<String, String>();
    map['email'] = params.email;
    final response = await _apiClient.forgotPassword(map);
    var data ;
    if(response != null ){
      data = response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }

  @override
  Future<ResetPasswardModel> resetPasswordCall(ResetPasswordParams params) async {
    var map = new HashMap<String, String>();
    map['password'] = params.password;
    map['OTP'] = params.OTP;
    final response = await _apiClient.resetPassword(map);
    var data ;
    if(response != null ){
      data = response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }


}