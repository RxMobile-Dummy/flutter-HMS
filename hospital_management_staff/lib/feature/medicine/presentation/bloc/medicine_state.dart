import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/add_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/delete_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/update_medicine_model.dart';

class AddMedicineState extends BaseState {
  AddMedicineModel? model;

  AddMedicineState({this.model});
}

class GetMedicineState extends BaseState {
  GetMedicineModel? model;

  GetMedicineState({this.model});
}

class UpdateMedicineState extends BaseState {
  UpdateMedicineModel? model;

  UpdateMedicineState({this.model});
}

class DeleteMedicineState extends BaseState {
  DeleteMedicineModel? model;

  DeleteMedicineState({this.model});
}

