
import 'dart:collection';


import 'package:dio/dio.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/sign_in_staff.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/add_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/delete_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/update_medicine_model.dart';
import 'package:hospital_management_staff/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';
import 'package:retrofit/retrofit.dart';



part 'base_client.g.dart';

@RestApi(baseUrl: 'https://067c-180-211-112-179.in.ngrok.io/')
abstract class  ApiClient {

  factory ApiClient(Dio dio) = _ApiClient;

  @POST('staff/staff_sign_in')
  Future<SignInStaffModel> doctorLogIn(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('staff/forget_password')
  Future<ForgotPasswordModel> forgotPassword(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('staff/staff_reset_password')
  Future<ResetPasswardModel> resetPassword(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('staff/get_staff_details')
  Future<GetProfileModel> getStaffProfile(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('staff/update_staff_details')
  Future<UpdateProfileModel> updateStaffProfile(
      @Body() FormData formData);

  @POST('patient/get_patient_details')
  Future<GetPatientModel> getPatient(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('appointment/get_appointment_details')
  Future<GetAppointmentModel> getAppointment(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('appointment/get_appointment_status')
  Future<GetAppointmentStatusModel> getAppointmentStatus(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('medicine/add_medicine')
  Future<AddMedicineModel> addMedicine(
      @Body() FormData formData);

  @POST('medicine/get_medicine_details')
  Future<GetMedicineModel> getMedicine(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('medicine/update_medicine_details')
  Future<UpdateMedicineModel> updateMedicine(
      @Body() FormData formData);

  @POST('medicine/delete_medicine_details')
  Future<DeleteMedicineModel> deleteMedicine(
      @Body() HashMap<String, dynamic> hashMap,);

}