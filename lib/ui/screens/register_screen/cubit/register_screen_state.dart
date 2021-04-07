part of 'register_screen_cubit.dart';

@immutable
abstract class RegisterScreenState {}

class RegisterScreenInitial extends RegisterScreenState {}

class RegisterScreenLoading extends RegisterScreenState {}

class RegisterScreenError extends RegisterScreenState with EquatableMixin {
  final String message;

  RegisterScreenError({this.message});

  @override
  List<Object> get props => [message];
}

class RegisterScreenSuccess extends RegisterScreenState {}
