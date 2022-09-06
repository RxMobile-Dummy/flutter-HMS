import 'dart:collection';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api_call/baseClient.dart';




final Sl = GetIt.instance;

Future<void> init() async {
  var dio = await createDioClient();
  Sl.registerFactory<Dio>(() => dio);

 Sl.registerSingleton(ApiClient(Sl.get()));
 //bloc

  // Use cases

  // Repository

  // Local Data sources



}

Future<Dio> createDioClient() async {
  Dio dio = Dio();
  // Authorization Headers
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var authToken = prefs.getString('access');
  Map<String, dynamic> headers = {};
  if (authToken != null && authToken != "") {
    headers["Accept"] = 'application/json';
    headers["Authorization"] = authToken;
  }else{
    headers["Accept"] = 'application/json';
  }

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.options.headers = headers;
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) async {
        if (authToken != null && authToken != ''){
          var authToken1 = prefs.getString('access');
          request.headers['Authorization'] = 'Bearer $authToken1';
        }else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var authToken = prefs.getString('access');
          // var authToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTk2NzI5MTIsImVtYWlsIjoicmVlY2hhOTk5QGdtYWlsLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE3MDA0MjQyOTU0In0.68SG-dqGiFRSsqQJqp0hqlHsSnvtaQhRjREk_OmpSdM";
          Map<String, dynamic> headers = {};
          if (authToken != null && authToken != "") {
            request.headers['Authorization'] = 'Bearer $authToken';
          }else{
            request.headers["Accept"] = 'application/json';
          }
        }
        return handler.next(request);
      },
     /* onResponse: (response, handler) {
        response.data = json.decode(response.data['data']);
        print(response.data);
        handler.next(response);
      },*/
      onError: (err, handler) async {
        if (err.response?.statusCode == 401) {
          try {
            //ErrorObject.logout();
            /*  await refreshTokenCall();
            var authToken = prefs.getString('access');
            if (authToken != null || authToken != "") {
              headers["Accept"] = 'application/json';
              headers["Authorization"] = authToken;
              dio.options.headers = headers;
              dio.request(err.requestOptions.path);
            }*/
          } catch (err, st) {
            print(err);
          }
        }else{
          handler.reject(err);
        }
      },
    ),
  );
  return dio;
}


