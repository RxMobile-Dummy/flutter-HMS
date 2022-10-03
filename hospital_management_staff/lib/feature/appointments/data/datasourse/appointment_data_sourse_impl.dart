import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hospital_management_staff/core/api_call/base_client.dart';
import 'package:hospital_management_staff/core/common_keys/common_keys.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/appointments/data/datasourse/appointment_data_sourse.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/update_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/update_appointment_usecase.dart';
import 'package:path/path.dart' as pathManager;

class AppointmentDataSourceImpl implements AppointmentDataSource {
  final ApiClient _apiClient;

  AppointmentDataSourceImpl(this._apiClient);

  @override
  Future<GetAppointmentModel> getAppointmentCall(GetAppointmentParams params) async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Date] = params.date;
    map[CommonKeys.K_Doctor_Id] = params.id;
    map[CommonKeys.K_Search] = params.search;
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

    List listOfIds = [];
    for(int i=0;i<params.reportDescription.length;i++){
      listOfIds.add(params.reportDescription[i]['report_id']);
      // listOfFile.add(params.reportDescription[i]['file_data']);
    }

    map["report_ids"] = listOfIds.join(' , ');
    map[CommonKeys.K_Doctor_Id] = params.doctorId;
    map[CommonKeys.K_Patient_Id] = params.patientId;
    map[CommonKeys.K_Appointment_Id] = params.appointmentId;
    map[CommonKeys.K_Hospital_Id] = params.hospitalId;
    FormData formData =  FormData.fromMap(map);
    List listOfFile = [];
    if(params.reportDescription.isNotEmpty) {
      for(int i=0;i< params.reportDescription.length;i++){
        MultipartFile? multipartFile;
        multipartFile = await MultipartFile.fromFile(
          params.reportDescription[i]['file_data'] ?? "",
          filename: pathManager.basename(params.reportDescription[i]['file_data'] ?? ""),
        );
        formData.files.addAll([
          MapEntry("report_file", multipartFile)
        ]);
       // listOfFile.add(multipartFile);
        params.reportDescription[i].remove("file_data");
        params.reportDescription[i]['file_data'] = multipartFile.filename;
      }
    }
    print(formData.files);
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