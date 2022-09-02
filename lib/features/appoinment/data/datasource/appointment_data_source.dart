import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/delete_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';

import '../../domain/usecases/book_appointment_usecase.dart';
import '../../domain/usecases/delete_appointment_usecase.dart';
import '../../domain/usecases/get_appointment_usecase.dart';
import '../../domain/usecases/update_appointment_usecase.dart';

abstract class AppointmentDataSource {
  Future<BookAppointmentModel> bookAppointmentCall(BookAppointmentParams params);
  Future<GetAppointmentModel> getAppointmentCall(GetAppointmentParams params);
  Future<DeleteAppointmentModel> deleteAppointmentCall(DeleteAppointmentParams params);
  Future<UpdateAppointmentModel> updateAppointmentCall(UpdateAppointmentParams params);
}