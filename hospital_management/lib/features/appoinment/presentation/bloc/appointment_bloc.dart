import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/delete_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/book_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/delete_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/update_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_event.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_state.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';

class AppointmentBloc extends Bloc<BaseEvent, BaseState> {
  BookAppointmentUsecase? bookAppointmentUsecase;
  GetAppointmentUsecase? getAppointmentUsecase;
  DeleteAppointmentUsecase? deleteAppointmentUsecase;
  UpdateAppointmentUsecase? updateAppointmentUsecase;

  AppointmentBloc(
      {required this.bookAppointmentUsecase,
      required this.getAppointmentUsecase,
      required this.deleteAppointmentUsecase,
      required this.updateAppointmentUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is BookAppointmentEvent) {
        bookAppointmentCall(
            doctorId: event.doctorId,
            firstName: event.firstName,
            lastName: event.lastName,
            appointmentDate: event.appointmentDate,
            bookingTime: event.bookingTime,
            fileData: event.fileData,
            hospitalId: event.hospitalId,
            mobileNumber: event.mobileNumber,
            patientId: event.patientId,
            staffId: event.staffId,
            statusId: event.statusId,
            timeSlot: event.timeSlot,
            patientProfilePic: event.patientProfilePic,
            disease: event.disease);
      } else if (event is UpdateAppointmentEvent) {
        updateAppointmentCall(
            doctorId: event.doctorId,
            firstName: event.firstName,
            lastName: event.lastName,
            appointmentDate: event.appointmentDate,
            bookingTime: event.bookingTime,
            fileData: event.fileData,
            hospitalId: event.hospitalId,
            mobileNumber: event.mobileNumber,
            patientId: event.patientId,
            staffId: event.staffId,
            statusId: event.statusId,
            timeSlot: event.timeSlot,
            patientProfilePic: event.patientProfilePic,
            disease: event.disease,
        appointmentId: event.appointmentId);
      } else if (event is DeleteAppointmentEvent) {
        deleteAppointmentCall(appointmentId: event.appointmentId);
      } else if (event is GetAppointmentEvent) {
        getAppointmentCall(
            id: event.id,
        date: event.date);
      } else if (event is BookAppointmentSuccessEvent) {
        BookAppointmentModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(BookAppointmentState(model: model));
        }
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
      } else if (event is DeleteAppointmentSuccessEvent) {
        DeleteAppointmentModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(DeleteAppointmentState(model: model));
        }
      } else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }

  bookAppointmentCall(
      {String? firstName,
      lastName,
      bookingTime,
      doctorId,
      patientId,
      staffId,
      hospitalId,
      mobileNumber,
      timeSlot,
      statusId,
      appointmentDate,
      fileData,
      disease,
      patientProfilePic}) {
    bookAppointmentUsecase!
        .call(BookAppointmentParams(
            doctorId: doctorId,
            lastName: lastName,
            firstName: firstName,
            patientId: patientId,
            mobileNumber: mobileNumber,
            statusId: statusId,
            appointmentDate: appointmentDate,
            bookingTime: bookingTime,
            fileData: fileData,
            hospitalId: hospitalId,
            staffId: staffId,
            timeSlot: timeSlot,
            disease: disease,
            patientProfilePic: patientProfilePic))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(BookAppointmentSuccessEvent(model: onSuccess));
      });
    });
  }

  updateAppointmentCall(
      {String? firstName,
        lastName,
        bookingTime,
        doctorId,
        patientId,
        staffId,
        hospitalId,
        mobileNumber,
        timeSlot,
        statusId,
        appointmentDate,
        fileData,
        disease,
        patientProfilePic,appointmentId}) {
    updateAppointmentUsecase!
        .call(UpdateAppointmentParams(
        doctorId: doctorId,
        lastName: lastName,
        firstName: firstName,
        patientId: patientId,
        mobileNumber: mobileNumber,
        statusId: statusId,
        appointmentDate: appointmentDate,
        bookingTime: bookingTime,
        fileData: fileData,
        hospitalId: hospitalId,
        staffId: staffId,
        timeSlot: timeSlot,
        disease: disease,
        patientProfilePic: patientProfilePic,
    appointmentId: appointmentId))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateAppointmentSuccessEvent(model: onSuccess));
      });
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

  deleteAppointmentCall({
    String? appointmentId,
  }) {
    deleteAppointmentUsecase!
        .call(DeleteAppointmentParams(appointmentId: appointmentId ?? ''))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(DeleteAppointmentSuccessEvent(model: onSuccess));
      });
    });
  }
}
