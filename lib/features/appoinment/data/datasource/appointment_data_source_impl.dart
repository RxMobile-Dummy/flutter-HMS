import 'dart:collection';
import 'package:dio/dio.dart';

import 'package:hospital_management/features/appoinment/data/datasource/appointment_data_source.dart';
import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/delete_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/book_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/delete_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/update_appointment_usecase.dart';

import '../../../../core/api_call/baseClient.dart';
import 'package:path/path.dart' as pathManager;
import 'package:http/http.dart' as http;


class AppointmentDataSourceImpl implements AppointmentDataSource {
  final ApiClient _apiClient;

  AppointmentDataSourceImpl(this._apiClient);

  @override
  Future<BookAppointmentModel> bookAppointmentCall(BookAppointmentParams params) async {
    MultipartFile multipartFileForReport =
        await MultipartFile.fromFile(params.fileData ?? "", filename: pathManager.basename(params.fileData ?? ""));
    MultipartFile multipartFileForProfilePic =
    await MultipartFile.fromFile(params.patientProfilePic ?? "", filename: pathManager.basename(params.patientProfilePic ?? ""));
    var map =  HashMap<String, dynamic>();
    map['first_name'] = params.firstName;
    map['last_name'] = params.lastName;
    map['mobile_number'] = params.mobileNumber;
    map['booking_time'] = params.bookingTime;
    map['doctor_id'] = params.doctorId;
    map['patient_id'] = params.patientId;
    map['staff_id'] = params.staffId;
    map['time_slot'] = params.timeSlot;
    map['status_id'] = params.statusId;
    map['appointment_date'] = params.appointmentDate;
    map['hospital_id'] = params.hospitalId;
    map['hospital_id'] = params.hospitalId;
    map['disease'] = params.disease;
    map['patient_profile_pic'] = multipartFileForProfilePic;
    map['file_data'] =  multipartFileForReport;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.bookAppointment(formData);
    print(response.error);
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
  Future<GetAppointmentModel> getAppointmentCall(GetAppointmentParams params) async {
    var map =  HashMap<String, dynamic>();
    map["id"] = params.id;
    map["date"] = params.date;
    final response = await _apiClient.getAppointmentDetails(map);
    print(response.error);
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
  Future<DeleteAppointmentModel> deleteAppointmentCall(DeleteAppointmentParams params) async {
    var map =  HashMap<String, dynamic>();
    map["id"] = params.appointmentId;
    final response = await _apiClient.deleteAppointment(map);
    print(response.error);
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
    MultipartFile? multipartFileForReport;
    if(params.fileData!.isNotEmpty) {
      if(!params.fileData![0].contains("appointment_files")) {
        multipartFileForReport =
        await MultipartFile.fromFile(
          params.fileData ?? "",
          filename: pathManager.basename(params.fileData ?? ""),
        );
      }
    }
    MultipartFile? multipartFileForProfilePic;
    if(params.patientProfilePic!.isNotEmpty) {
      if(!params.patientProfilePic![0].contains("patient_profile_pic_files")) {
        multipartFileForProfilePic =
        await MultipartFile.fromFile(
          params.patientProfilePic ?? "",
          filename: pathManager.basename(params.patientProfilePic ?? ""),
        );
      }
    }
   /* MultipartFile multipartFileForReport =
        await MultipartFile.fromFile(params.fileData ?? "", filename: pathManager.basename(params.fileData ?? ""));*/
   /* MultipartFile multipartFileForProfilePic =
        await MultipartFile.fromFile(params.patientProfilePic ?? "", filename: pathManager.basename(params.patientProfilePic ?? ""));*/
    var map =  HashMap<String, dynamic>();
    map['first_name'] = params.firstName;
    map['last_name'] = params.lastName;
    map['mobile_number'] = params.mobileNumber;
    map['booking_time'] = params.bookingTime;
    map['doctor_id'] = params.doctorId;
    map['patient_id'] = params.patientId;
    map['staff_id'] = params.staffId;
    map['time_slot'] = params.timeSlot;
    map['status_id'] = params.statusId;
    map['appointment_date'] = params.appointmentDate;
    map['hospital_id'] = params.hospitalId;
    map['hospital_id'] = params.hospitalId;
    map['disease'] = params.disease;
    map['appointment_id'] = params.appointmentId;
    map['patient_profile_pic'] = params.patientProfilePic!.isNotEmpty ? multipartFileForProfilePic : params.patientProfilePic;
    map['file_data'] =  params.fileData!.isNotEmpty ? multipartFileForReport : params.fileData;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.updateAppointment(formData);
    print(response.error);
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