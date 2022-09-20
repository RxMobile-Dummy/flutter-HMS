import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/usecase.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/domain/repositories/authentication_repositories.dart';

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