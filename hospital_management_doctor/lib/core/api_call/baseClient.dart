
import 'dart:collection';


import 'package:dio/dio.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/reset_password_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../feature/authentication/data/model/sign_in_doctor.dart';


part 'baseClient.g.dart';

@RestApi(baseUrl: 'https://426d-180-211-112-179.in.ngrok.io/')
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
}