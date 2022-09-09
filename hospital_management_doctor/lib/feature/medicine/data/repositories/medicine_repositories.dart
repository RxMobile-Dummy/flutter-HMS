import 'package:dartz/dartz.dart';
import 'package:hospital_management_doctor/core/failure/error_object.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/feature/medicine/data/datasourse/medicine_data_sourse.dart';
import 'package:hospital_management_doctor/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_doctor/feature/medicine/domain/repositories/medicine_repositories.dart';
import 'package:hospital_management_doctor/feature/medicine/domain/usecases/get_medicine_usecase.dart';

class MedicineRepositoriesImpl extends MedicineRepositories{
  MedicineDataSource? medicineDataSource;
  MedicineRepositoriesImpl({this.medicineDataSource});

  @override
  Stream<Either<Failure, GetMedicineModel>> getMedicineCall(GetMedicineParams params) async* {
    try{
      var response = await medicineDataSource!.getMedicineCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }


}