import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hospital_management_staff/core/common_keys/common_keys.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/profile/data/datasourse/profile_data_sourse.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/update_profile_usecase.dart';

import '../../../../core/api_call/baseClient.dart';
import 'package:path/path.dart' as pathManager;

class ProfileDataSourceImpl implements ProfileDataSource {
  final ApiClient _apiClient;

  ProfileDataSourceImpl(this._apiClient);

  @override
  Future<GetProfileModel> getProfileCall(GetProfileParams params) async {
     var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Id] = params.id.toString();
    final response = await _apiClient.getStaffProfile(map);
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
  Future<UpdateProfileModel> updateProfileCall(UpdateProfileParams params) async {
    MultipartFile? multipartFile;
    if(params.profilePic!.isNotEmpty) {
      if(!params.profilePic![0].contains(Strings.kDoctorImageStoredPath)) {
        multipartFile =
        await MultipartFile.fromFile(
          params.profilePic ?? '',
          filename: pathManager.basename(params.profilePic ?? ""),
        );
      }
    }
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Staff_Id] = params.staffId;
    map[CommonKeys.K_First_Name] = params.firstName;
    map[CommonKeys.K_Last_Name] = params.lastName;
    map[CommonKeys.K_Contact_Number] = params.contactNumber;
    map[CommonKeys.K_Email] = params.email;
    map[CommonKeys.K_Gender] = params.gender;
    map[CommonKeys.K_Date_Of_Birth] = params.dateOfBirth;
    map[CommonKeys.K_Blood_Group] = params.bloodGroup;
    map[CommonKeys.K_Year_Of_Experience] = params.yearOfExperience;
    map[CommonKeys.K_Education] = params.education;
    map[CommonKeys.K_Hospital_Id] = params.hospitalId;
    map[CommonKeys.K_Profile_pic] = params.profilePic!.isNotEmpty ? multipartFile : params.profilePic;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.updateStaffProfile(formData);
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