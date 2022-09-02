import 'package:hospital_management/features/feedback/data/model/send_patient_feedback.dart';

import '../../domain/usecases/send_doctor_feedback.dart';

abstract class FeedbackDataSource {
  Future<SendDoctorFeedbackModel> sendDoctorCall(SendDoctorFeedbackParams params);
}