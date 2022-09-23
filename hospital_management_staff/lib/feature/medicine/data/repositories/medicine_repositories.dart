import 'package:dartz/dartz.dart';
import 'package:hospital_management_staff/core/failure/error_object.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/medicine/data/datasourse/medicine_data_sourse.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/add_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/delete_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/update_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/domain/repositories/medicine_repositories.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/add_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/get_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/update_medicine_usecase.dart';

class MedicineRepositoriesImpl extends MedicineRepositories{
  MedicineDataSource? medicineDataSource;
  MedicineRepositoriesImpl({this.medicineDataSource});

  @override
  Stream<Either<Failure, AddMedicineModel>> addMedicineCall(AddMedicineParams params) async*{
    try{
      var response = await medicineDataSource!.addMedicineCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, GetMedicineModel>> getMedicineCall(GetMedicineParams params) async*{
    try{
      var response = await medicineDataSource!.getMedicineCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, UpdateMedicineModel>> updateMedicineCall(UpdateMedicineParams params) async* {
    try{
      var response = await medicineDataSource!.updateMedicineCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, DeleteMedicineModel>> deleteMedicineCall(DeleteMedicineParams params) async*{
    try{
      var response = await medicineDataSource!.deleteMedicineCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }




}