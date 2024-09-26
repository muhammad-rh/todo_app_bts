part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginOnSuccess extends LoginState {}

final class LoginOnLoading extends LoginState {}

final class LoginOnFailed extends LoginState {
  const LoginOnFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

final class LoginOnError extends LoginState {
  const LoginOnError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
