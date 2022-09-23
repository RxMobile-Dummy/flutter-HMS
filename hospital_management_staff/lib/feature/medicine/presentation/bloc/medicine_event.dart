import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/add_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/delete_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/update_medicine_model.dart';

class AddMedicineEvent extends BaseEvent {
  String name;
  String photo;
  String price;
  String quantity;
  String prescriptionRequired;
  String stockOfItem;
  String description;
  String itemCategory;
  String itemSubCategory;
  String mg;
  String soldItem;
  String manufactureDate;
  String expiryDate;

  AddMedicineEvent({
    required this.name,
    required this.photo,
    required this.price,
    required this.quantity,
    required this.prescriptionRequired,
    required this.stockOfItem,
    required this.description,
    required this.itemCategory,
    required this.itemSubCategory,
    required this.mg,
    required this.soldItem,
    required this.manufactureDate,
    required this.expiryDate
  });
}

class AddMedicineSuccessEvent extends BaseEvent {
  AddMedicineModel? model;

  AddMedicineSuccessEvent({this.model});
}

class GetMedicineEvent extends BaseEvent {
  String id;
  String name;

  GetMedicineEvent({
    required this.id,
    required this.name,
  });
}

class GetMedicineSuccessEvent extends BaseEvent {
  GetMedicineModel? model;

  GetMedicineSuccessEvent({this.model});
}

class UpdateMedicineEvent extends BaseEvent {
  String name;
  String photo;
  String price;
  String quantity;
  String prescriptionRequired;
  String stockOfItem;
  String description;
  String itemCategory;
  String itemSubCategory;
  String mg;
  String soldItem;
  String manufactureDate;
  String expiryDate;
  String medicineId;

  UpdateMedicineEvent({
    required this.name,
    required this.photo,
    required this.price,
    required this.quantity,
    required this.prescriptionRequired,
    required this.stockOfItem,
    required this.description,
    required this.itemCategory,
    required this.itemSubCategory,
    required this.mg,
    required this.soldItem,
    required this.manufactureDate,
    required this.expiryDate,
    required this.medicineId
  });
}

class UpdateMedicineSuccessEvent extends BaseEvent {
  UpdateMedicineModel? model;

  UpdateMedicineSuccessEvent({this.model});
}

class DeleteMedicineEvent extends BaseEvent {
  String id;

  DeleteMedicineEvent({
    required this.id,
  });
}

class DeleteMedicineSuccessEvent extends BaseEvent {
  DeleteMedicineModel? model;

  DeleteMedicineSuccessEvent({this.model});
}