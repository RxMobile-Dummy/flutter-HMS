

import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_status.dart';

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

