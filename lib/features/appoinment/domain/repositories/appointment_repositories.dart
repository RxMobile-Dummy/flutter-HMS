import 'package:dartz/dartz.dart';
import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/delete_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';

import '../../../../core/failure/failure.dart';
import '../usecases/book_appointment_usecase.dart';
import '../usecases/delete_appointment_usecase.dart';
import '../usecases/get_appointment_usecase.dart';
import '../usecases/update_appointment_usecase.dart';

abstract class AppointmentRepositories {
  Stream<Either<Failure, BookAppointmentModel>> bookAppointmentCall(BookAppointmentParams params);
  Stream<Either<Failure, GetAppointmentModel>> getAppointmentCall(GetAppointmentParams params);
  Stream<Either<Failure, DeleteAppointmentModel>> deleteAppointmentCall(DeleteAppointmentParams params);
  Stream<Either<Failure, UpdateAppointmentModel>> updateAppointmentCall(UpdateAppointmentParams params);
}