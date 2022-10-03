

import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/update_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/update_appointment_usecase.dart';

abstract class AppointmentDataSource {
  Future<GetAppointmentModel> getAppointmentCall(GetAppointmentParams params);
  Future<GetAppointmentStatusModel> getAppointmentStatusCall(GetAppointmentStatusParams params);
  Future<UpdateAppointmentModel> updateAppointmentCall(UpdateAppointmentParams params);
}