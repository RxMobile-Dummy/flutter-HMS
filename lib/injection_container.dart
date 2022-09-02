import 'dart:collection';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hospital_management/core/api_call/baseClient.dart';
import 'package:hospital_management/features/appoinment/data/datasource/appointment_data_source.dart';
import 'package:hospital_management/features/appoinment/data/datasource/appointment_data_source_impl.dart';
import 'package:hospital_management/features/appoinment/data/repositories/appointment_repositories.dart';
import 'package:hospital_management/features/appoinment/domain/repositories/appointment_repositories.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/book_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/delete_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/update_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management/features/authentication/data/datasource/authentication_data_source.dart';
import 'package:hospital_management/features/authentication/data/datasource/authentication_data_source_impl.dart';
import 'package:hospital_management/features/authentication/data/repositories/authentication_repositories.dart';
import 'package:hospital_management/features/authentication/domain/repositories/authentication_repositories.dart';
import 'package:hospital_management/features/authentication/domain/usecases/add_patient_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_allergies_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_food_preference_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_injuries_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_medication_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/get_surgery_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/sign_in_patient_usecase.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/food_preference_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/injuries_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/medication_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/surgery_bloc.dart';
import 'package:hospital_management/features/doctor/data/datasource/doctor_data_source.dart';
import 'package:hospital_management/features/doctor/data/datasource/doctor_data_source_impl.dart';
import 'package:hospital_management/features/doctor/data/repositories/doctor_repositories.dart';
import 'package:hospital_management/features/doctor/domain/repositories/doctor_repositories.dart';
import 'package:hospital_management/features/doctor/domain/usecases/filter_doctor_usecase.dart';
import 'package:hospital_management/features/doctor/domain/usecases/get_doctor_usecase.dart';
import 'package:hospital_management/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:hospital_management/features/feedback/data/datasource/feedback_data_source.dart';
import 'package:hospital_management/features/feedback/data/datasource/feedback_data_source_impl.dart';
import 'package:hospital_management/features/feedback/data/repositories/feedback_repositories.dart';
import 'package:hospital_management/features/feedback/domain/repositories/feedback_repositories.dart';
import 'package:hospital_management/features/feedback/domain/usecases/send_doctor_feedback.dart';
import 'package:hospital_management/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:hospital_management/features/profile/data/datasource/patient_profile_data_source.dart';
import 'package:hospital_management/features/profile/data/datasource/patient_profile_data_source_impl.dart';
import 'package:hospital_management/features/profile/data/repositories/patient_profile_repositories.dart';
import 'package:hospital_management/features/profile/domain/repositories/patient_profile_repositories.dart';
import 'package:hospital_management/features/profile/domain/usecases/get_patient_profile_usecase.dart';
import 'package:hospital_management/features/profile/domain/usecases/update_patient_profile_usecase.dart';
import 'package:hospital_management/features/profile/presentation/bloc/patient_profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authentication/presentation/bloc/allergies_bloc.dart';


final Sl = GetIt.instance;

Future<void> init() async {
  var dio = await createDioClient();
  Sl.registerFactory<Dio>(() => dio);

 Sl.registerSingleton(ApiClient(Sl.get()));
 //bloc
  Sl.registerFactory(() => AuthenticationBloc(
    addPatientUsecase: Sl.call(),
    signInPatientUsecase: Sl.call(),
    forgotPasswordUsecase: Sl.call(),
    resetPasswordUsecase: Sl.call()
  ));
  Sl.registerFactory(() => AllergiesBloc(getAllergiesUsecase: Sl.call()));
  Sl.registerFactory(() => MedicationBloc(getMedicationUsecase: Sl.call()));
  Sl.registerFactory(() => InjuryBloc(getInjuriesUsecase: Sl.call()));
  Sl.registerFactory(() => SurgeryBloc(getSurgeryUsecase: Sl.call()));
  Sl.registerFactory(() => FoodPreferenceBloc(getFoodPreferenceUsecase: Sl.call()));
  Sl.registerFactory(() => DoctorBloc(getDoctorUsecase: Sl.call(),filterDoctorUsecase: Sl.call()));
  Sl.registerFactory(() => AppointmentBloc(
      bookAppointmentUsecase: Sl.call(),
      getAppointmentUsecase: Sl.call(),
    deleteAppointmentUsecase: Sl.call(),
    updateAppointmentUsecase: Sl.call(),
  ));
  Sl.registerFactory(() => PatientProfileBloc(
      getPatientProfileUsecase: Sl.call(),
  updatePatientUsecase: Sl.call()));
  Sl.registerFactory(() => FeedbackBloc(sendDoctorFeedbackUsecase: Sl.call()));

  // Use cases
  Sl.registerLazySingleton(() => GetAllergiesUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => GetMedicationUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => GetInjuriesUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => GetSurgeryUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => GetFoodPreferenceUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => AddPatientUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => SignInPatientUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => ForgotPasswordUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => ResetPasswordUsecase(authenticationRepositories: Sl()));
  Sl.registerLazySingleton(() => GetPatientProfileUsecase(patientProfileRepositories: Sl()));
  Sl.registerLazySingleton(() => UpdatePatientUsecase(patientProfileRepositories: Sl()));
  Sl.registerLazySingleton(() => GetDoctorUsecase(doctorRepositories: Sl()));
  Sl.registerLazySingleton(() => BookAppointmentUsecase(appointmentRepositories: Sl()));
  Sl.registerLazySingleton(() => GetAppointmentUsecase(appointmentRepositories: Sl()));
  Sl.registerLazySingleton(() => SendDoctorFeedbackUsecase(feedbackRepositories: Sl()));
  Sl.registerLazySingleton(() => DeleteAppointmentUsecase(appointmentRepositories: Sl()));
  Sl.registerLazySingleton(() => UpdateAppointmentUsecase(appointmentRepositories: Sl()));
  Sl.registerLazySingleton(() => FilterDoctorUsecase(doctorRepositories: Sl()));


  // Repository
  Sl.registerLazySingleton<AuthenticationRepositories>(
        () => AuthenticationRepositoriesImpl(authenticationDataSource: Sl()),
  );

  Sl.registerLazySingleton<PatientProfileRepositories>(
        () => PatientProfileRepositoriesImpl(profileDataSource: Sl()),
  );

  Sl.registerLazySingleton<DoctorRepositories>(
        () => DoctorRepositoriesImpl(doctorDataSource: Sl()),
  );

  Sl.registerLazySingleton<AppointmentRepositories>(
        () => AppointmentRepositoriesImpl(appointmentDataSource: Sl()),
  );

  Sl.registerLazySingleton<FeedbackRepositories>(
        () => FeedbackRepositoriesImpl(feedbackDataSource: Sl()),
  );

  // Local Data sources
  Sl.registerLazySingleton<AuthenticationDataSource>(
        () => AuthenticationDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<PatientProfileDataSource>(
        () => PatientProfileDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<DoctorDataSource>(
        () => DoctorDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<AppointmentDataSource>(
        () => AppointmentDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<FeedbackDataSource>(
        () => FeedbackDataSourceImpl(Sl.get()),
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


