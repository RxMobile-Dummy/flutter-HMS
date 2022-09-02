import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';



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
    map['id'] = params.id;
    final response = await _apiClient.getPatientProfile(map);
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
  Future<UpdatePatientProfileModel> updatePatientProfileCall(UpdatePatientParams params) async {
    MultipartFile? multipartFile;
    if(params.profile_pic!.isNotEmpty) {
      if(!params.profile_pic![0].contains("patient_images")) {
        multipartFile =
        await MultipartFile.fromFile(
            params.profile_pic ?? "",
            filename: pathManager.basename(params.profile_pic ?? ""),
        );
      }
    }
    var map =  HashMap<String, dynamic>();
    map['patient_id'] = params.patient_id;
    map['first_name'] = params.first_name;
    map['last_name'] = params.last_name;
    map['contact_number'] = params.contact_number;
    map['email'] = params.email;
    map['gender'] = params.gender;
    map['date_of_birth'] = params.date_of_birth;
    map['blood_group'] = params.blood_group;
    map['marital_status'] = params.marital_status;
    map['height'] = params.height;
    map['weight'] = params.weight;
    map['emergency_contact_number'] = params.emergency_contact_number;
    map['city'] = params.city;
    map['allergy'] = params.allergy;
    map['current_medication'] = params.current_medication;
    map['past_injury'] = params.past_injury;
    map['past_surgery'] = params.past_surgery;
    map['smoking_habits'] = params.smoking_habits;
    map['alchol_consumption'] = params.alchol_consumption;
    map['activity_level'] = params.activity_level;
    map['food_preference'] = params.food_preference;
    map['occupation'] = params.occupation;
    map['profile_pic'] =  params.profile_pic!.isNotEmpty ? multipartFile : params.profile_pic;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.updatePatientProfile(formData);
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


}