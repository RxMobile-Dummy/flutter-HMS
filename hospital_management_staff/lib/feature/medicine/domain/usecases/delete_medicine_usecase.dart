import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/usecase.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/delete_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/domain/repositories/medicine_repositories.dart';

class DeleteMedicineUsecase extends UseCase<DeleteMedicineModel, DeleteMedicineParams> {
  final MedicineRepositories? medicineRepositories;

  DeleteMedicineUsecase({this.medicineRepositories});

  @override
  Stream<Either<Failure, DeleteMedicineModel>> call(DeleteMedicineParams params) {
    return medicineRepositories!.deleteMedicineCall(params);
  }

}

class DeleteMedicineParams extends Equatable {
  String id;

  DeleteMedicineParams({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;

    return data;
  }
}