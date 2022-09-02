import 'dart:collection';

import 'package:hospital_management/features/feedback/data/datasource/feedback_data_source.dart';
import 'package:hospital_management/features/feedback/data/model/send_patient_feedback.dart';
import 'package:hospital_management/features/feedback/domain/usecases/send_doctor_feedback.dart';

import '../../../../core/api_call/baseClient.dart';

class FeedbackDataSourceImpl implements FeedbackDataSource {
  final ApiClient _apiClient;

  FeedbackDataSourceImpl(this._apiClient);


  @override
  Future<SendDoctorFeedbackModel> sendDoctorCall(SendDoctorFeedbackParams params) async {
    var map =  HashMap<String, dynamic>();
    map["patient_id"] = params.patientId;
    map["hospital_id"] = params.hospitalId;
    map["staff_id"] = params.staffId;
    map["doctor_id"] = params.doctorId;
    map["comment"] = params.comment;
    map["rating"] = params.ratings;
    final response = await _apiClient.sendDoctorFeedback(map);
    print(response.error);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print('failed');
    }
    return data;
  }



}