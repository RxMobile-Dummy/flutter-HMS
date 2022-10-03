import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/failure/error_object.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_state.dart';

class AppointmentStatusBloc extends Bloc<BaseEvent, BaseState> {
  GetAppointmentStatusUsecase? getAppointmentStatusUsecase;


  AppointmentStatusBloc(
      {required this.getAppointmentStatusUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetAppointmentStatusEvent) {
        getAppointmentStatusCall(
          id: event.id,);
      }   else if (event is GetAppointmentStatusSuccessEvent) {
        GetAppointmentStatusModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(GetAppointmentStatusState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getAppointmentStatusCall({
    String? id,
  }) {
    getAppointmentStatusUsecase!
        .call(GetAppointmentStatusParams(
      id: id ?? '',))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetAppointmentStatusSuccessEvent(model: onSuccess));
      });
    });
  }

}