

import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/update_appointment_model.dart';

class GetAppointmentEvent extends BaseEvent {
  String? id;
  String? date;
  String? search;

  GetAppointmentEvent({
    this.id,
    this.date,
    this.search
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
  String hospitalId;
  List reportDescription;

  UpdateAppointmentEvent({
    required this.hospitalId,
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
