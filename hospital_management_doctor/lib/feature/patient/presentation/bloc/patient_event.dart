import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';

class GetPatientEvent extends BaseEvent {
  String doctorId;
  String search;

  GetPatientEvent({required this.doctorId, required this.search});
}

class GetPatientSuccessEvent extends BaseEvent {
  GetPatientModel? model;

  GetPatientSuccessEvent({this.model});
}