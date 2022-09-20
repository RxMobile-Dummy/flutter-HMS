
import 'dart:collection';


import 'package:dio/dio.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/sign_in_staff.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';
import 'package:retrofit/retrofit.dart';



part 'baseClient.g.dart';

@RestApi(baseUrl: 'https://3408-180-211-112-179.in.ngrok.io/')
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

}