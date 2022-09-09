import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/update_appointment_model.dart';

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

class GetAppointmentStatusEvent extends BaseEvent {
  String? id;

  GetAppointmentStatusEvent({
    this.id,
  });
}

class GetAppointmentStatusSuccessEvent extends BaseEvent {
  GetAppointmentStatusModel? model;

  GetAppointmentStatusSuccessEvent({this.model});
}

class UpdateAppointmentEvent extends BaseEvent {
  String doctorId;
  String patientId;
  String appointmentId;
  String medicineId;
  String statusId;
  String hospitalId;
  String reportDescription;

  UpdateAppointmentEvent({
    required this.statusId,
    required this.hospitalId,
    required this.medicineId,
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.reportDescription
  });
}

class UpdateAppointmentSuccessEvent extends BaseEvent {
  UpdateAppointmentModel? model;

  UpdateAppointmentSuccessEvent({this.model});
}
