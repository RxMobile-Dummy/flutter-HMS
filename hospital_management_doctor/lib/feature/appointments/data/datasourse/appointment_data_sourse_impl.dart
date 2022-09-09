import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hospital_management_doctor/core/api_call/baseClient.dart';
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
    map["date"] = params.date;
    map["doctor_id"] = params.id;
    final response = await _apiClient.getAppointment(map);
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
  Future<GetAppointmentStatusModel> getAppointmentStatusCall(GetAppointmentStatusParams params) async {
    var map =  HashMap<String, dynamic>();
    map["id"] = params.id;
    final response = await _apiClient.getAppointmentStatus(map);
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
  Future<UpdateAppointmentModel> updateAppointmentCall(UpdateAppointmentParams params) async {
    var map =  HashMap<String, dynamic>();
    map["report_description"] = params.reportDescription;
    map["doctor_id"] = params.doctorId;
    map["patient_id"] = params.patientId;
    map["appointment_id"] = params.appointmentId;
    map["medicine_id"] = params.medicineId;
    map["hospital_id"] = params.hospitalId;
    map["status_id"] = params.statusId;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.updateAppointment(formData);
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