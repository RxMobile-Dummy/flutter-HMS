import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/usecase.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_staff/feature/authentication/domain/repositories/authentication_repositories.dart';

class ResetPasswordUsecase extends UseCase<ResetPasswardModel, ResetPasswordParams> {
  final AuthenticationRepositories? authenticationRepositories;

  ResetPasswordUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, ResetPasswardModel>> call(ResetPasswordParams params) {
    return authenticationRepositories!.resetPasswordCall(params);
  }

}

class ResetPasswordParams extends Equatable {
  String OTP;
  String password;

  ResetPasswordParams({
    required this.OTP,
    required this.password,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['OTP'] = this.OTP;
    data['password'] = this.password;

    return data;
  }
}