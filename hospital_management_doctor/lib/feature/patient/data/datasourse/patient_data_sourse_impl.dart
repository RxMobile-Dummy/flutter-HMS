import 'dart:collection';

import 'package:hospital_management_doctor/core/api_call/baseClient.dart';
import 'package:hospital_management_doctor/core/common_keys/common_keys.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/feature/patient/data/datasourse/patient_data_sourse.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_doctor/feature/patient/domain/usecases/get_patient_usecase.dart';

class PatientDataSourceImpl implements PatientDataSource {
  final ApiClient _apiClient;

  PatientDataSourceImpl(this._apiClient);

  @override
  Future<GetPatientModel> getPatientCall(GetPatientParams params) async{
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Doctor_Id] = params.doctorId;
    map[CommonKeys.K_Search] = params.search;
    final response = await _apiClient.getPatient(map);
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