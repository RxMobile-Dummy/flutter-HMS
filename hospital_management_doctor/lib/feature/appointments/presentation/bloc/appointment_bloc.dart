import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/failure/error_object.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/update_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/update_appointment_usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_state.dart';
import 'package:hospital_management_doctor/feature/profile/domain/usecases/update_profile_usecase.dart';

class AppointmentBloc extends Bloc<BaseEvent, BaseState> {
  GetAppointmentUsecase? getAppointmentUsecase;
  GetAppointmentStatusUsecase? getAppointmentStatusUsecase;
  UpdateAppointmentUsecase? updateAppointmentUsecase;

  AppointmentBloc(
      {required this.getAppointmentUsecase,required this.getAppointmentStatusUsecase,
      required this.updateAppointmentUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetAppointmentEvent) {
        getAppointmentCall(
            id: event.id,
            date: event.date);
      }else if (event is GetAppointmentStatusEvent) {
        getAppointmentStatusCall(
            id: event.id,);
      }  else if (event is UpdateAppointmentEvent) {
        updateAppointmentCall(
            reportDescription: event.reportDescription,
        medicineId: event.medicineId,
        statusId: event.statusId,
        patientId: event.patientId,
        appointmentId: event.appointmentId.toString(),
        doctorId: event.doctorId,
        hospitalId: event.hospitalId);
      }else if (event is GetAppointmentSuccessEvent) {
        GetAppointmentModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(GetAppointmentState(model: model));
        }
      }else if (event is GetAppointmentStatusSuccessEvent) {
        GetAppointmentStatusModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(GetAppointmentStatusState(model: model));
        }
      } else if (event is UpdateAppointmentSuccessEvent) {
        UpdateAppointmentModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(UpdateAppointmentState(model: model));
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

  updateAppointmentCall({
    String? doctorId, patientId, appointmentId, medicineId, statusId, hospitalId, reportDescription,
  }) {
    updateAppointmentUsecase!
        .call(UpdateAppointmentParams(
        hospitalId: hospitalId,
    doctorId: doctorId ?? "",
    appointmentId: appointmentId,
    patientId: patientId,
    statusId: statusId,
    medicineId: medicineId,
    reportDescription: reportDescription))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateAppointmentSuccessEvent(model: onSuccess));
      });
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