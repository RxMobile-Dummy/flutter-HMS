import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';

import '../../../../core/base/base_bloc.dart';
import '../../data/model/filter_doctor_model.dart';

class GetDoctorEvent extends BaseEvent {
  String specialistField;
  GetDoctorEvent({required this.specialistField});
}

class GetDoctorSuccessEvent extends BaseEvent {
  GetDoctorModel? model;

  GetDoctorSuccessEvent({this.model});
}

class FilterDoctorEvent extends BaseEvent {
  String specialistField;

  FilterDoctorEvent({required this.specialistField});
}

class FilterDoctorSuccessEvent extends BaseEvent {
  FilterDoctorModel? model;

  FilterDoctorSuccessEvent({this.model});
}