import 'package:dartz/dartz.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/add_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/delete_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/update_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/add_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/get_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/update_medicine_usecase.dart';

abstract class MedicineRepositories {
  Stream<Either<Failure, AddMedicineModel>> addMedicineCall(AddMedicineParams params);
  Stream<Either<Failure, GetMedicineModel>> getMedicineCall(GetMedicineParams params);
  Stream<Either<Failure, UpdateMedicineModel>> updateMedicineCall(UpdateMedicineParams params);
  Stream<Either<Failure, DeleteMedicineModel>> deleteMedicineCall(DeleteMedicineParams params);
}