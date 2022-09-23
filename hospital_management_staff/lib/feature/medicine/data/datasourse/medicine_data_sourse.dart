import 'package:hospital_management_staff/feature/medicine/data/model/add_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/delete_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/update_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/add_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/get_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/update_medicine_usecase.dart';

abstract class MedicineDataSource {
  Future<AddMedicineModel> addMedicineCall(AddMedicineParams params);
  Future<GetMedicineModel> getMedicineCall(GetMedicineParams params);
  Future<UpdateMedicineModel> updateMedicineCall(UpdateMedicineParams params);
  Future<DeleteMedicineModel> deleteMedicineCall(DeleteMedicineParams params);
}