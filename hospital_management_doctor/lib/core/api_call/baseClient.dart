
import 'dart:collection';


import 'package:dio/dio.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_report_model.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/update_appointment_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_doctor/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/update_profile_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../feature/authentication/data/model/sign_in_doctor.dart';


part 'baseClient.g.dart';

@RestApi(baseUrl: 'https://a0ef-180-211-112-179.in.ngrok.io/')
abstract class  ApiClient {

  factory ApiClient(Dio dio) = _ApiClient;
  //
  @POST('doctor/doctor_sign_in')
  Future<SignInDoctorModel> doctorLogIn(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('doctor/forget_password')
  Future<ForgotPasswordModel> forgotPassword(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('doctor/doctor_reset_password')
  Future<ResetPasswardModel> resetPassword(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('doctor/get_doctor_details')
  Future<GetProfileModel> getDoctorProfile(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('doctor/update_doctor_details')
  Future<UpdateProfileModel> updateDoctorProfile(
      @Body() FormData formData);

  @POST('appointment/get_appointment_details')
  Future<GetAppointmentModel> getAppointment(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('appointment/update_appointment_details')
  Future<UpdateAppointmentModel> updateAppointment(
      @Body() FormData formData);

  @POST('appointment/get_appointment_status')
  Future<GetAppointmentStatusModel> getAppointmentStatus(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('medicine/get_medicine_details')
  Future<GetMedicineModel> getMedicine(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('patient/get_patient_details')
  Future<GetPatientModel> getPatient(
      @Body() HashMap<String, dynamic> hashMap,);

  @GET('patient_report/get_report_data')
  Future<GetReportListModel> getReportList();
}