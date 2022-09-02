// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baseClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://d373-180-211-112-179.in.ngrok.io/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GetAllergiesModel> getAllergies() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllergiesModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/get_allergies/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllergiesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMedicationModel> getMedication() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMedicationModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/get_current_medications/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMedicationModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetInjuriesModel> getInjuries() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetInjuriesModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/get_past_injuries/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetInjuriesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetSurgeryModel> getSurgery() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetSurgeryModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/get_past_surgeries/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetSurgeryModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetFoodPreferenceModel> getFoodPreference() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetFoodPreferenceModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/get_food_preferences/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetFoodPreferenceModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddPatientModel> addPatient(formData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = formData;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddPatientModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/add_patient',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddPatientModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignInPatientModel> signInPatient(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SignInPatientModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/patient_sign_in',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignInPatientModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgotPasswordModel> forgotPassword(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForgotPasswordModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/patient_forgot_password/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForgotPasswordModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResetPasswardModel> resetPassword(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResetPasswardModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/patient_reset_password',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResetPasswardModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPatientProfileModel> getPatientProfile(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPatientProfileModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/get_patient_details',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPatientProfileModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdatePatientProfileModel> updatePatientProfile(formData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = formData;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdatePatientProfileModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'patient/update_patient_details',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdatePatientProfileModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetDoctorModel> getDoctor(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetDoctorModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'doctor/get_doctor_details',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetDoctorModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookAppointmentModel> bookAppointment(formData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = formData;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookAppointmentModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'appointment/add_new_appointment',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookAppointmentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAppointmentModel> getAppointmentDetails(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAppointmentModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'appointment/get_appointment_details',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAppointmentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SendDoctorFeedbackModel> sendDoctorFeedback(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SendDoctorFeedbackModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'doctor/add_doctor_feedback',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SendDoctorFeedbackModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteAppointmentModel> deleteAppointment(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteAppointmentModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'appointment/delete_appointment_details',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteAppointmentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateAppointmentModel> updateAppointment(formData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = formData;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateAppointmentModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'appointment/update_appointment_details',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateAppointmentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FilterDoctorModel> filterDoctor(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FilterDoctorModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'doctor/get_doctor_filter',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FilterDoctorModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
