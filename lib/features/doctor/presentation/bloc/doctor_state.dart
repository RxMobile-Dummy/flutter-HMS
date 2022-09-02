import 'package:hospital_management/features/doctor/data/model/filter_doctor_model.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';

import '../../../../core/base/base_bloc.dart';

class GetDoctorState extends BaseState {
  GetDoctorModel? model;

  GetDoctorState({this.model});
}

class FilterDoctorState extends BaseState {
  FilterDoctorModel? model;

  FilterDoctorState({this.model});
}