import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/features/feedback/data/model/send_patient_feedback.dart';
import 'package:hospital_management/features/feedback/domain/usecases/send_doctor_feedback.dart';
import 'package:hospital_management/features/feedback/presentation/bloc/feedback_event.dart';
import 'package:hospital_management/features/feedback/presentation/bloc/feedback_state.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';

class FeedbackBloc extends Bloc<BaseEvent, BaseState> {
  SendDoctorFeedbackUsecase? sendDoctorFeedbackUsecase;


  FeedbackBloc(
      {required this.sendDoctorFeedbackUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is SendDoctorFeedbackEvent) {
        sendDoctorFeedbackCall(
           ratings: event.ratings,
          comment: event.comment,
           doctorId: event.doctorId,
          hospitalId: event.hospitalId,
          patientId: event.patientId,
          staffId: event.staffId
        );
      } else if (event is SendDoctorFeedbackSuccessEvent) {
        SendDoctorFeedbackModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(SendDoctorFeedbackState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  sendDoctorFeedbackCall({String? patientId,doctorId,hospitalId,staffId,ratings,comment}) {
    sendDoctorFeedbackUsecase!
        .call(SendDoctorFeedbackParams(
        staffId: staffId,
      patientId: patientId ?? "",
      hospitalId: hospitalId,
      doctorId: doctorId,
      comment: comment,
      ratings: ratings,
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(SendDoctorFeedbackSuccessEvent(model: onSuccess));
      });
    });
  }


}