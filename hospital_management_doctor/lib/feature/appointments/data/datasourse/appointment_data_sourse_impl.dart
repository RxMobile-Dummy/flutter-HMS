import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hospital_management_doctor/core/api_call/baseClient.dart';
import 'package:hospital_management_doctor/core/common_keys/common_keys.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/feature/appointments/data/datasourse/appointment_data_sourse.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/update_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/update_appointment_usecase.dart';

class AppointmentDataSourceImpl implements AppointmentDataSource {
  final ApiClient _apiClient;

  AppointmentDataSourceImpl(this._apiClient);

  @override
  Future<GetAppointmentModel> getAppointmentCall(GetAppointmentParams params) async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Date] = params.date;
    map[CommonKeys.K_Doctor_Id] = params.id;
    final response = await _apiClient.getAppointment(map);
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
  Future<GetAppointmentStatusModel> getAppointmentStatusCall(GetAppointmentStatusParams params) async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Id] = params.id;
    final response = await _apiClient.getAppointmentStatus(map);
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
  Future<UpdateAppointmentModel> updateAppointmentCall(UpdateAppointmentParams params) async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Report_Description] = params.reportDescription;
    map[CommonKeys.K_Doctor_Id] = params.doctorId;
    map[CommonKeys.K_Patient_Id] = params.patientId;
    map[CommonKeys.K_Appointment_Id] = params.appointmentId;
    map[CommonKeys.K_Medicine_Id] = params.medicineId;
    map[CommonKeys.K_Hospital_Id] = params.hospitalId;
    map[CommonKeys.K_Status_Id] = params.statusId;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.updateAppointment(formData);
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