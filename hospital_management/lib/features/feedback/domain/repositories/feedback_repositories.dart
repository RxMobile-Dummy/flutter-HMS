import 'package:dartz/dartz.dart';
import 'package:hospital_management/features/feedback/data/model/send_patient_feedback.dart';

import '../../../../core/failure/failure.dart';
import '../usecases/send_doctor_feedback.dart';

abstract class FeedbackRepositories {
  Stream<Either<Failure, SendDoctorFeedbackModel>> sendDoctorFeedbackCall(SendDoctorFeedbackParams params);
}