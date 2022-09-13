import 'dart:collection';

import 'package:hospital_management_doctor/core/api_call/baseClient.dart';
import 'package:hospital_management_doctor/feature/patient/data/datasourse/patient_data_sourse.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_doctor/feature/patient/domain/usecases/get_patient_usecase.dart';

class PatientDataSourceImpl implements PatientDataSource {
  final ApiClient _apiClient;

  PatientDataSourceImpl(this._apiClient);

  @override
  Future<GetPatientModel> getPatientCall(GetPatientParams params) async{
    var map =  HashMap<String, dynamic>();
    map["doctor_id"] = params.doctorId;
    map["search"] = params.search;
    final response = await _apiClient.getPatient(map);
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