import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/usecase.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/update_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/domain/repositories/medicine_repositories.dart';

class UpdateMedicineUsecase extends UseCase<UpdateMedicineModel, UpdateMedicineParams> {
  final MedicineRepositories? medicineRepositories;

  UpdateMedicineUsecase({this.medicineRepositories});

  @override
  Stream<Either<Failure, UpdateMedicineModel>> call(UpdateMedicineParams params) {
    return medicineRepositories!.updateMedicineCall(params);
  }

}

class UpdateMedicineParams extends Equatable {
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

  UpdateMedicineParams({
    required this.name,
    required this.description,
    required this.photo,
    required this.itemCategory,
    required this.itemSubCategory,
    required this.mg,
    required this.prescriptionRequired,
    required this.price,
    required this.quantity,
    required this.soldItem,
    required this.stockOfItem,
    required this.expiryDate,
    required this.manufactureDate,
    required this.medicineId
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['itemCategory'] = this.itemCategory;
    data['itemSubCategory'] = this.itemSubCategory;
    data['mg'] = this.mg;
    data['prescriptionRequired'] = this.prescriptionRequired;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['soldItem'] = this.soldItem;
    data['expiryDate'] = this.expiryDate;
    data['manufactureDate'] = this.manufactureDate;
    data['medicineId'] = this.medicineId;

    return data;
  }
}