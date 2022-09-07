import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/core/usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/repositories/authentication_repositories.dart';

class ForgotPasswordUsecase extends UseCase<ForgotPasswordModel, ForgotPasswordParams> {
  final AuthenticationRepositories? authenticationRepositories;

  ForgotPasswordUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, ForgotPasswordModel>> call(ForgotPasswordParams params) {
    return authenticationRepositories!.forgotPasswordCall(params);
  }

}

class ForgotPasswordParams extends Equatable {
  String email;

  ForgotPasswordParams({
    required this.email,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.email;

    return data;
  }
}