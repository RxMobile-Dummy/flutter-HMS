import 'package:dartz/dartz.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/update_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/update_appointment_usecase.dart';

abstract class AppointmentRepositories {
  Stream<Either<Failure, GetAppointmentModel>> getAppointmentCall(GetAppointmentParams params);
  Stream<Either<Failure, GetAppointmentStatusModel>> getAppointmentStatusCall(GetAppointmentStatusParams params);
  Stream<Either<Failure, UpdateAppointmentModel>> updateAppointmentCall(UpdateAppointmentParams params);
}