import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/delete_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_status_model.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';

import '../../../../core/base/base_bloc.dart';

class BookAppointmentState extends BaseState {
  BookAppointmentModel? model;

  BookAppointmentState({this.model});
}
class GetAppointmentState extends BaseState {
  GetAppointmentModel? model;

  GetAppointmentState({this.model});
}

class DeleteAppointmentState extends BaseState {
  DeleteAppointmentModel? model;

  DeleteAppointmentState({this.model});
}

class UpdateAppointmentState extends BaseState {
  UpdateAppointmentModel? model;

  UpdateAppointmentState({this.model});
}

class GetAppointmentStatusState extends BaseState {
  GetAppointmentStatusModel? model;

  GetAppointmentStatusState({this.model});
}
