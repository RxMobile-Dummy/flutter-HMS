
import 'dart:collection';


import 'package:dio/dio.dart';
import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/delete_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_alleries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_food_prefrence_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_injuries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_medication_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_surgery_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_in_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';
import 'package:hospital_management/features/doctor/data/model/filter_doctor_model.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/features/profile/data/model/update_patient_profile_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/authentication/data/model/forgot_password_model.dart';
import '../../features/authentication/data/model/reset_password_model.dart';
import '../../features/feedback/data/model/send_patient_feedback.dart';

part 'baseClient.g.dart';

@RestApi(baseUrl: 'https://d373-180-211-112-179.in.ngrok.io/')
abstract class  ApiClient {

  factory ApiClient(Dio dio) = _ApiClient;
  //
  @GET('patient/get_allergies/')
  Future<GetAllergiesModel> getAllergies();

  @GET('patient/get_current_medications/')
  Future<GetMedicationModel> getMedication();

  @GET('patient/get_past_injuries/')
  Future<GetInjuriesModel> getInjuries();

  @GET('patient/get_past_surgeries/')
  Future<GetSurgeryModel> getSurgery();

  @GET('patient/get_food_preferences/')
  Future<GetFoodPreferenceModel> getFoodPreference();

  @POST('patient/add_patient')
  Future<AddPatientModel> addPatient(
      @Body() FormData formData);

  @POST('patient/patient_sign_in')
  Future<SignInPatientModel> signInPatient(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('patient/patient_forgot_password/')
  Future<ForgotPasswordModel> forgotPassword(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('patient/patient_reset_password')
  Future<ResetPasswardModel> resetPassword(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('patient/get_patient_details')
  Future<GetPatientProfileModel> getPatientProfile(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('patient/update_patient_details')
  Future<UpdatePatientProfileModel> updatePatientProfile(
      @Body() FormData formData);

  @POST('doctor/get_doctor_details')
  Future<GetDoctorModel> getDoctor(@Body() HashMap<String, dynamic> hashMap,);

  @POST('appointment/add_new_appointment')
  Future<BookAppointmentModel> bookAppointment(
      @Body() FormData formData);

  @POST('appointment/get_appointment_details')
  Future<GetAppointmentModel> getAppointmentDetails(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('doctor/add_doctor_feedback')
  Future<SendDoctorFeedbackModel> sendDoctorFeedback(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('appointment/delete_appointment_details')
  Future<DeleteAppointmentModel> deleteAppointment(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('appointment/update_appointment_details')
  Future<UpdateAppointmentModel> updateAppointment(
      @Body() FormData formData);

  @POST('doctor/get_doctor_filter')
  Future<FilterDoctorModel> filterDoctor(
      @Body() HashMap<String, dynamic> hashMap,);
}