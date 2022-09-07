import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hospital_management_doctor/feature/profile/data/datasourse/profile_data_sourse.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/update_profile_model.dart';
import 'package:hospital_management_doctor/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:hospital_management_doctor/feature/profile/domain/usecases/update_profile_usecase.dart';

import '../../../../core/api_call/baseClient.dart';
import 'package:path/path.dart' as pathManager;

class ProfileDataSourceImpl implements ProfileDataSource {
  final ApiClient _apiClient;

  ProfileDataSourceImpl(this._apiClient);

  @override
  Future<GetProfileModel> getProfileCall(GetProfileParams params) async {
     var map =  HashMap<String, dynamic>();
    map['id'] = params.id.toString();
    final response = await _apiClient.getDoctorProfile(map);
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
  Future<UpdateProfileModel> updateProfileCall(UpdateProfileParams params) async {
    MultipartFile? multipartFile;
    if(params.profilePic!.isNotEmpty) {
      if(!params.profilePic![0].contains("doctor/app/doctor_images")) {
        multipartFile =
            await MultipartFile.fromFile(
          params.profilePic ?? "",
          filename: pathManager.basename(params.profilePic ?? ""),
        );
      }
    }
    var map =  HashMap<String, dynamic>();
    map['doctor_id'] = params.doctorId;
    map['first_name'] = params.firstName;
    map['last_name'] = params.lastName;
    map['contact_number'] = params.mobileNumber;
    map['email'] = params.email;
    map['profile_pic'] = params.profilePic!.isNotEmpty ? multipartFile : params.profilePic;
    map['gender'] = params.gender;
    map['date_of_birth'] = params.dateOfBirth;
    map['blood_group'] = params.bloodGroup;
    map['years_of_experience'] = params.yearOfExperience;
    map['next_available_at'] = params.nextAvailableAt;
    map['specialist_field'] = params.specialistField;
    map['education'] = params.education;
    map['about'] = params.about;
    map['hospital_id'] = params.hospitalId;
    map['in_clinic_appointment_fees'] = params.fees;
   // map['rating'] = params.rating;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.updateDoctorProfile(formData);
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