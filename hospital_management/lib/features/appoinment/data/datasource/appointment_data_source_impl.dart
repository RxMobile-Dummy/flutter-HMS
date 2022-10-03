import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/core/strings/strings.dart';

import 'package:hospital_management/features/appoinment/data/datasource/appointment_data_source.dart';
import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/delete_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_status_model.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/book_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/delete_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/update_appointment_usecase.dart';

import '../../../../core/api_call/baseClient.dart';
import 'package:path/path.dart' as pathManager;


class AppointmentDataSourceImpl implements AppointmentDataSource {
  final ApiClient _apiClient;

  AppointmentDataSourceImpl(this._apiClient);

  @override
  Future<BookAppointmentModel> bookAppointmentCall(BookAppointmentParams params) async {
    MultipartFile? multipartFileForReport;
    if(params.fileData!.isNotEmpty) {
      if(!params.fileData![0].contains(CommonKeys.K_Appointment_Files)) {
        multipartFileForReport =
        await MultipartFile.fromFile(params.fileData ?? "", filename: pathManager.basename(params.fileData ?? ""));
      }
    }
    MultipartFile? multipartFileForProfilePic;
    if(params.patientProfilePic!.isNotEmpty) {
      if(!params.patientProfilePic![0].contains(CommonKeys.K_Patient_Profile_Pic_Files)) {
        multipartFileForProfilePic =
        await MultipartFile.fromFile(params.patientProfilePic ?? "", filename: pathManager.basename(params.patientProfilePic ?? ""));
      }
    }
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_First_Name] = params.firstName;
    map[CommonKeys.K_Last_Name] = params.lastName;
    map[CommonKeys.K_Mobile_Number] = params.mobileNumber;
    map[CommonKeys.K_Booking_Time] = params.bookingTime;
    map[CommonKeys.K_Doctor_Id] = params.doctorId;
    map[CommonKeys.K_Patient_Id] = params.patientId;
    map[CommonKeys.K_Staff_Id] = params.staffId;
    map[CommonKeys.K_Time_Slot] = params.timeSlot;
    map[CommonKeys.K_Status_Id] = params.statusId;
    map[CommonKeys.K_Appointment_Date] = params.appointmentDate;
    map[CommonKeys.K_Hospital_Id] = params.hospitalId;
    map[CommonKeys.K_Disease] = params.disease;
    map[CommonKeys.K_Patient_Profile_Pic] = params.patientProfilePic!.isNotEmpty ? multipartFileForProfilePic : params.patientProfilePic;
    map[CommonKeys.K_File_Data] =  params.fileData!.isNotEmpty ? multipartFileForReport : params.fileData;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.bookAppointment(formData);
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

  @override
  Future<GetAppointmentModel> getAppointmentCall(GetAppointmentParams params) async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Id] = params.id;
    map[CommonKeys.K_Date] = params.date;
    final response = await _apiClient.getAppointmentDetails(map);
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

  @override
  Future<DeleteAppointmentModel> deleteAppointmentCall(DeleteAppointmentParams params) async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Id] = params.appointmentId;
    final response = await _apiClient.deleteAppointment(map);
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

  @override
  Future<UpdateAppointmentModel> updateAppointmentCall(UpdateAppointmentParams params) async {
    MultipartFile? multipartFileForReport;
    if(params.fileData!.isNotEmpty) {
      if(!params.fileData![0].contains(CommonKeys.K_Appointment_Files)) {
        multipartFileForReport =
        await MultipartFile.fromFile(
          params.fileData ?? "",
          filename: pathManager.basename(params.fileData ?? ""),
        );
      }
    }
    MultipartFile? multipartFileForProfilePic;
    if(params.patientProfilePic!.isNotEmpty) {
      if(!params.patientProfilePic![0].contains(CommonKeys.K_Patient_Profile_Pic_Files)) {
        multipartFileForProfilePic =
        await MultipartFile.fromFile(
          params.patientProfilePic ?? "",
          filename: pathManager.basename(params.patientProfilePic ?? ""),
        );
      }
    }
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_First_Name] = params.firstName;
    map[CommonKeys.K_Last_Name] = params.lastName;
    map[CommonKeys.K_Mobile_Number] = params.mobileNumber;
    map[CommonKeys.K_Booking_Time] = params.bookingTime;
    map[CommonKeys.K_Doctor_Id] = params.doctorId;
    map[CommonKeys.K_Patient_Id] = params.patientId;
    map[CommonKeys.K_Staff_Id] = params.staffId;
    map[CommonKeys.K_Time_Slot] = params.timeSlot;
    map[CommonKeys.K_Status_Id] = params.statusId;
    map[CommonKeys.K_Appointment_Date] = params.appointmentDate;
    map[CommonKeys.K_Hospital_Id] = params.hospitalId;
    map[CommonKeys.K_Disease] = params.disease;
    map[CommonKeys.K_Appointment_Id] = params.appointmentId;
    map[CommonKeys.K_Patient_Profile_Pic] = params.patientProfilePic!.isNotEmpty ? multipartFileForProfilePic : params.patientProfilePic;
    map[CommonKeys.K_File_Data] =  params.fileData!.isNotEmpty ? multipartFileForReport : params.fileData;
    FormData formData =  FormData.fromMap(map);
    final response = await _apiClient.updateAppointment(formData);
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



}