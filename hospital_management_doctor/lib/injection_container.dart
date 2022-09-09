import 'dart:collection';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hospital_management_doctor/feature/appointments/data/datasourse/appointment_data_sourse.dart';
import 'package:hospital_management_doctor/feature/appointments/data/datasourse/appointment_data_sourse_impl.dart';
import 'package:hospital_management_doctor/feature/appointments/data/repositories/appointment_repositories.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/repositories/appointment_repositories.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/update_appointment_usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/data/datasourse/authentication_data_source.dart';
import 'package:hospital_management_doctor/feature/authentication/data/datasourse/authentication_data_source_impl.dart';
import 'package:hospital_management_doctor/feature/authentication/data/repositories/authentication_repositories.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/repositories/authentication_repositories.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/sign_in_doctor_usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management_doctor/feature/medicine/data/datasourse/medicine_data_sourse.dart';
import 'package:hospital_management_doctor/feature/medicine/data/datasourse/medicine_data_sourse_impl.dart';
import 'package:hospital_management_doctor/feature/medicine/data/repositories/medicine_repositories.dart';
import 'package:hospital_management_doctor/feature/medicine/domain/repositories/medicine_repositories.dart';
import 'package:hospital_management_doctor/feature/medicine/domain/usecases/get_medicine_usecase.dart';
import 'package:hospital_management_doctor/feature/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:hospital_management_doctor/feature/profile/data/datasourse/profile_data_sourse.dart';
import 'package:hospital_management_doctor/feature/profile/data/datasourse/profile_data_sourse_impl.dart';
import 'package:hospital_management_doctor/feature/profile/data/repositories/profile_repositories.dart';
import 'package:hospital_management_doctor/feature/profile/domain/repositories/profile_repositories.dart';
import 'package:hospital_management_doctor/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:hospital_management_doctor/feature/profile/domain/usecases/update_profile_usecase.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/api_call/baseClient.dart';




final Sl = GetIt.instance;

Future<void> init() async {
  var dio = await createDioClient();
  Sl.registerFactory<Dio>(() => dio);

 Sl.registerSingleton(ApiClient(Sl.get()));
 //bloc
  Sl.registerFactory(() => AuthenticationBloc(
      signInDoctorUsecase:  Sl.call(),
    forgotPasswordUsecase: Sl.call(),
    resetPasswordUsecase: Sl.call()
  ));
  Sl.registerFactory(() => ProfileBloc(
      getProfileUsecase:  Sl.call(),
    updateProfileUsecase: Sl.call()
  ));
  Sl.registerFactory(() => AppointmentBloc(
      getAppointmentUsecase:  Sl.call(),
    getAppointmentStatusUsecase: Sl.call(),
    updateAppointmentUsecase: Sl.call()
  ));

  Sl.registerFactory(() => MedicineBloc(
      getMedicineUsecase:  Sl.call(),
  ));

  // Use cases
  Sl.registerLazySingleton(() => SignInDoctorUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => ForgotPasswordUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => ResetPasswordUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => GetProfileUsecase(profileRepositories: Sl()));
  Sl.registerLazySingleton(() => UpdateProfileUsecase(profileRepositories: Sl()));
  Sl.registerLazySingleton(() => GetAppointmentUsecase(appointmentRepositories: Sl()));
  Sl.registerLazySingleton(() => GetAppointmentStatusUsecase(appointmentRepositories: Sl()));
  Sl.registerLazySingleton(() => GetMedicineUsecase(medicineRepositories: Sl()));
  Sl.registerLazySingleton(() => UpdateAppointmentUsecase(appointmentRepositories: Sl()));

  // Repository
  Sl.registerLazySingleton<AuthenticationRepositories>(
        () => AuthenticationRepositoriesImpl(authenticationDataSource: Sl()),
  );

  Sl.registerLazySingleton<ProfileRepositories>(
        () => ProfileRepositoriesImpl(profileDataSource: Sl()),
  );

  Sl.registerLazySingleton<AppointmentRepositories>(
        () => AppointmentRepositoriesImpl(appointmentDataSource: Sl()),
  );

  Sl.registerLazySingleton<MedicineRepositories>(
        () => MedicineRepositoriesImpl(medicineDataSource: Sl()),
  );


  // Local Data sources
  Sl.registerLazySingleton<AuthenticationDataSource>(
        () => AuthenticationDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<ProfileDataSource>(
        () => ProfileDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<AppointmentDataSource>(
        () => AppointmentDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<MedicineDataSource>(
        () => MedicineDataSourceImpl(Sl.get()),
  );



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


