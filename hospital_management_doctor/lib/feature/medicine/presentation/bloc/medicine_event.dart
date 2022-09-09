import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/feature/medicine/data/model/get_medicine_model.dart';

class GetMedicineEvent extends BaseEvent {
  String? id;

  GetMedicineEvent({
    this.id,
  });
}

class GetMedicineSuccessEvent extends BaseEvent {
  GetMedicineModel? model;

  GetMedicineSuccessEvent({this.model});
}