import 'dart:collection';

import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/core/strings/strings.dart';
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
    map[CommonKeys.K_Patient_Id] = params.patientId;
    map[CommonKeys.K_Hospital_Id] = params.hospitalId;
    map[CommonKeys.K_Staff_Id] = params.staffId;
    map[CommonKeys.K_Doctor_Id] = params.doctorId;
    map[CommonKeys.K_Comment] = params.comment;
    map[CommonKeys.K_Rating] = params.ratings;
    final response = await _apiClient.sendDoctorFeedback(map);
    print(response.error);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print(Strings.kFailed);
    }
    return data;
  }



}