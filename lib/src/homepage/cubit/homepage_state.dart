part of 'homepage_cubit.dart';

sealed class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

final class HomepageInitial extends HomepageState {}

final class HomepageOnLoading extends HomepageState {}

final class HomepageOnSuccess extends HomepageState {}

final class HomepageOnFailed extends HomepageState {
  const HomepageOnFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

final class HomepageOnError extends HomepageState {
  const HomepageOnError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
