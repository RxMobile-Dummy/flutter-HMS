import 'dart:collection';

import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/core/strings/strings.dart';
import 'package:hospital_management/features/doctor/data/datasource/doctor_data_source.dart';
import 'package:hospital_management/features/doctor/data/model/filter_doctor_model.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';
import 'package:hospital_management/features/doctor/domain/usecases/filter_doctor_usecase.dart';
import 'package:hospital_management/features/doctor/domain/usecases/get_doctor_usecase.dart';

import '../../../../core/api_call/baseClient.dart';

class DoctorDataSourceImpl implements DoctorDataSource {
  final ApiClient _apiClient;

  DoctorDataSourceImpl(this._apiClient);

  @override
  Future<GetDoctorModel> getDoctorCall(GetDoctorParams params) async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Specialist_Field] = params.specialistField;
    final response = await _apiClient.getDoctor(map);
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
  Future<FilterDoctorModel> filterDoctorCall(FilterDoctorParams params) async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Specialist_Field] = params.specialistField;
    final response = await _apiClient.filterDoctor(map);
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




}