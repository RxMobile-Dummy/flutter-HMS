import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/failure/error_object.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/update_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/update_appointment_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_state.dart';

class AppointmentBloc extends Bloc<BaseEvent, BaseState> {
  GetAppointmentUsecase? getAppointmentUsecase;
  UpdateAppointmentUsecase? updateAppointmentUsecase;

  AppointmentBloc(
      {required this.getAppointmentUsecase,required this.updateAppointmentUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetAppointmentEvent) {
        getAppointmentCall(
            id: event.id,
            date: event.date,
        search: event.search);
      }else if (event is UpdateAppointmentEvent) {
        updateAppointmentCall(
            reportDescription: event.reportDescription,
            patientId: event.patientId,
            appointmentId: event.appointmentId.toString(),
            doctorId: event.doctorId,
            hospitalId: event.hospitalId);
      }else if (event is UpdateAppointmentSuccessEvent) {
        UpdateAppointmentModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(UpdateAppointmentState(model: model));
        }
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
    String? search,
  }) {
    getAppointmentUsecase!
        .call(GetAppointmentParams(
        id: id ?? '',
        date: date ?? "",
    search: search ?? ""))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetAppointmentSuccessEvent(model: onSuccess));
      });
    });
  }


  updateAppointmentCall({
    String? doctorId, patientId, appointmentId, hospitalId,
    List? reportDescription,
  }) {
    updateAppointmentUsecase!
        .call(UpdateAppointmentParams(
        hospitalId: hospitalId,
        doctorId: doctorId ?? "",
        appointmentId: appointmentId,
        patientId: patientId,
        reportDescription: reportDescription ?? []))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateAppointmentSuccessEvent(model: onSuccess));
      });
    });
  }

}