import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/feature/medicine/data/model/get_medicine_model.dart';

class GetMedicineState extends BaseState {
  GetMedicineModel? model;

  GetMedicineState({this.model});
}
