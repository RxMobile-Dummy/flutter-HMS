import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';

class GetPatientState extends BaseState {
  GetPatientModel? model;

  GetPatientState({this.model});
}
