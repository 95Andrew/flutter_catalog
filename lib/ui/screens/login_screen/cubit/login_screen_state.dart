part of 'login_screen_cubit.dart';

@immutable
abstract class LoginScreenState {}

class LoginScreenInitial extends LoginScreenState {}


class LoginScreenLoading extends LoginScreenState {}

class LoginScreenError extends LoginScreenState {
  final String message;

  LoginScreenError({this.message});
}

class LoginScreenSuccess extends LoginScreenState {}
