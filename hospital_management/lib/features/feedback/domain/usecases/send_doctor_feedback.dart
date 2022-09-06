import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../../data/model/send_patient_feedback.dart';
import '../repositories/feedback_repositories.dart';

class SendDoctorFeedbackUsecase extends UseCase<SendDoctorFeedbackModel, SendDoctorFeedbackParams> {
  final FeedbackRepositories? feedbackRepositories;

  SendDoctorFeedbackUsecase({this.feedbackRepositories});

  @override
  Stream<Either<Failure, SendDoctorFeedbackModel>> call(SendDoctorFeedbackParams params) {
    return feedbackRepositories!.sendDoctorFeedbackCall(params);
  }

}

class SendDoctorFeedbackParams extends Equatable {
  String patientId;
  String hospitalId;
  String staffId;
  String doctorId;
  String comment;
  String ratings;

  SendDoctorFeedbackParams({
    required this.doctorId,
    required this.hospitalId,
    required this.patientId,
    required this.staffId,
    required this.comment,
    required this.ratings
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['doctorId'] = this.doctorId;
    data['hospitalId'] = this.hospitalId;
    data['patientId'] = this.patientId;
    data['staffId'] = this.staffId;
    data['comment'] = this.comment;
    data['ratings'] = this.ratings;

    return data;
  }
}