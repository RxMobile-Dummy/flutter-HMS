import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/failure/error_object.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_state.dart';

class AppointmentBloc extends Bloc<BaseEvent, BaseState> {
  GetAppointmentUsecase? getAppointmentUsecase;

  AppointmentBloc(
      {required this.getAppointmentUsecase,})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetAppointmentEvent) {
        getAppointmentCall(
            id: event.id,
            date: event.date);
      } else if (event is GetAppointmentSuccessEvent) {
        GetAppointmentModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(GetAppointmentState(model: model));
        }
      } else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getAppointmentCall({
    String? id,
    String? date,
  }) {
    getAppointmentUsecase!
        .call(GetAppointmentParams(
        id: id ?? '',
        date: date ?? ""))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetAppointmentSuccessEvent(model: onSuccess));
      });
    });
  }


}