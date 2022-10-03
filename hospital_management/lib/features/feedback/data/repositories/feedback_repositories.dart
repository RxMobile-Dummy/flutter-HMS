import 'package:dartz/dartz.dart';
import 'package:hospital_management/core/failure/failure.dart';
import 'package:hospital_management/core/strings/strings.dart';
import 'package:hospital_management/features/feedback/data/datasource/feedback_data_source.dart';
import 'package:hospital_management/features/feedback/data/model/send_patient_feedback.dart';
import 'package:hospital_management/features/feedback/domain/repositories/feedback_repositories.dart';
import 'package:hospital_management/features/feedback/domain/usecases/send_doctor_feedback.dart';

import '../../../../core/failure/error_object.dart';

class FeedbackRepositoriesImpl extends FeedbackRepositories{
  FeedbackDataSource? feedbackDataSource;
  FeedbackRepositoriesImpl({this.feedbackDataSource});

  @override
  Stream<Either<Failure, SendDoctorFeedbackModel>> sendDoctorFeedbackCall(SendDoctorFeedbackParams params) async*{
    try{
      var response = await feedbackDataSource!.sendDoctorCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }



}