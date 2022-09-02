import '../../../../core/base/base_bloc.dart';
import '../../data/model/send_patient_feedback.dart';

class SendDoctorFeedbackEvent extends BaseEvent {
  String? patientId,hospitalId,staffId,doctorId,comment,ratings;

  SendDoctorFeedbackEvent({
    this.patientId,
    this.ratings,
    this.comment,
    this.doctorId,
    this.staffId,
    this.hospitalId,
  });
}

class SendDoctorFeedbackSuccessEvent extends BaseEvent {
  SendDoctorFeedbackModel? model;

  SendDoctorFeedbackSuccessEvent({this.model});
}