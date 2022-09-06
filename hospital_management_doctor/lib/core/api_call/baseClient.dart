
import 'dart:collection';


import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


part 'baseClient.g.dart';

@RestApi(baseUrl: 'https://426d-180-211-112-179.in.ngrok.io/')
abstract class  ApiClient {

  factory ApiClient(Dio dio) = _ApiClient;
  //
  @GET('patient/get_allergies/')
  Future<dynamic> getAllergies();
}