import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/core/strings/strings.dart';



import 'package:hospital_management/features/profile/data/datasource/patient_profile_data_source.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/features/profile/data/model/update_patient_profile_model.dart';
import 'package:hospital_management/features/profile/domain/usecases/get_patient_profile_usecase.dart';
import 'package:hospital_management/features/profile/domain/usecases/update_patient_profile_usecase.dart';

import '../../../../core/api_call/baseClient.dart';
import 'package:path/path.dart' as pathManager;

class PatientProfileDataSourceImpl implements PatientProfileDataSource {
  final ApiClient _apiClient;

  PatientProfileDataSourceImpl(this._apiClient);


  @override
  Future<GetPatientProfileModel> getPatientProfileCall(GetPatientProfileParams params) async{
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Id] = params.id;
    final response = await _apiClient.getPatientProfile();
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
  Future<UpdatePatientProfileModel> updatePatientProfileCall(UpdatePatientParams params) async {
    MultipartFile? multipartFile;
    if(params.profile_pic!.isNotEmpty) {
      if(!params.profile_pic![0].contains(CommonKeys.K_Patient_Images)) {
        multipartFile =
        await MultipartFile.fromFile(
            params.profile_pic ?? "",
            filename: pathManager.basename(params.profile_pic ?? ""),
        );
      }
    }
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Patient_Id] = params.patient_id;
    map[CommonKeys.K_First_Name] = params.first_name;
    map[CommonKeys.K_Last_Name] = params.last_name;
    map[CommonKeys.K_Contact_Number] = params.contact_number;
    map[CommonKeys.K_Email] = params.email;
    map[CommonKeys.K_Gender] = params.gender;
    map[CommonKeys.K_Date_Of_Birth] = params.date_of_birth;
    map[CommonKeys.K_Blood_Group] = params.blood_group;
    map[CommonKeys.K_Marital_Status] = params.marital_status;
    map[CommonKeys.K_Height] = params.height;
    map[CommonKeys.K_Weight] = params.weight;
    map[CommonKeys.K_Emergency_Contact_Number] = params.emergency_contact_number;
    map[CommonKeys.K_City] = params.city;
    map[CommonKeys.K_Allergy] = params.allergy;
    map[CommonKeys.K_Current_Medication] = params.current_medication;
    map[CommonKeys.K_Past_Injury] = params.past_injury;
    map[CommonKeys.K_Past_Surgery] = params.past_surgery;
    map[CommonKeys.K_Smoking_Habit] = params.smoking_habits;
    map[CommonKeys.K_Alcohol_Consumption] = params.alchol_consumption;
    map[CommonKeys.K_Activity_Level] = params.activity_level;
    map[CommonKeys.K_Food_Preference] = params.food_preference;
    map[CommonKeys.K_Occupation] = params.occupation;
    map[CommonKeys.K_Profile_Pic] =  params.profile_pic!.isNotEmpty ? multipartFile : params.profile_pic;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.updatePatientProfile(formData);
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


}