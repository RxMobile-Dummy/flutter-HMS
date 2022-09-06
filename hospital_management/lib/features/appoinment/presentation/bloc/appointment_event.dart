import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/delete_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';

import '../../../../core/base/base_bloc.dart';

class BookAppointmentEvent extends BaseEvent {
  String? firstName,lastName,bookingTime,doctorId,patientId,staffId,hospitalId,
  mobileNumber,timeSlot,statusId,appointmentDate,fileData,disease,patientProfilePic;

  BookAppointmentEvent({
    this.appointmentDate,
    this.statusId,
    this.timeSlot,
    this.mobileNumber,
    this.staffId,
    this.patientId,
    this.doctorId,
    this.bookingTime,
    this.lastName,
    this.fileData,
    this.hospitalId,
    this.firstName,
    this.patientProfilePic,
    this.disease
});
}

class BookAppointmentSuccessEvent extends BaseEvent {
  BookAppointmentModel? model;

  BookAppointmentSuccessEvent({this.model});
}

class GetAppointmentEvent extends BaseEvent {
  String? id;
  String? date;

  GetAppointmentEvent({
    this.id,
    this.date
  });
}

class GetAppointmentSuccessEvent extends BaseEvent {
  GetAppointmentModel? model;

  GetAppointmentSuccessEvent({this.model});
}


class DeleteAppointmentEvent extends BaseEvent {
  String? appointmentId;

  DeleteAppointmentEvent({
    this.appointmentId
  });
}

class DeleteAppointmentSuccessEvent extends BaseEvent {
  DeleteAppointmentModel? model;

  DeleteAppointmentSuccessEvent({this.model});
}

class UpdateAppointmentEvent extends BaseEvent {
  String? firstName,lastName,bookingTime,doctorId,patientId,staffId,hospitalId,
      mobileNumber,timeSlot,statusId,appointmentDate,fileData,disease,patientProfilePic,appointmentId;

  UpdateAppointmentEvent({
    this.appointmentDate,
    this.statusId,
    this.timeSlot,
    this.mobileNumber,
    this.staffId,
    this.patientId,
    this.doctorId,
    this.bookingTime,
    this.lastName,
    this.fileData,
    this.hospitalId,
    this.firstName,
    this.patientProfilePic,
    this.disease,
    this.appointmentId
  });
}

class UpdateAppointmentSuccessEvent extends BaseEvent {
  UpdateAppointmentModel? model;

  UpdateAppointmentSuccessEvent({this.model});
}

