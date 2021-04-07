import 'package:bloc/bloc.dart';
import 'package:either_option/either_option.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/data/dto/error_response.dart';
import 'package:flutter_catalog/data/dto/register_and_login.dart';

import 'package:flutter_catalog/data/repository/register_repository.dart';
import 'package:meta/meta.dart';

part 'register_screen_state.dart';

class RegisterScreenCubit extends Cubit<RegisterScreenState> {
  RegisterRepository registerRepository;
  bool ignoreLogin = true;
  bool obscurePasswordText = true;
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RegisterScreenCubit(this.registerRepository) : super(RegisterScreenInitial());

  Future<void> register({String name, String password}) async {
    emit(RegisterScreenLoading());
    Either<ErrorResponse, LoginResponse> response =
        await registerRepository.register(username: loginController.text, password: passwordController.text);
    response.fold((error) {
      emit(RegisterScreenError(message: error.message));
    }, (result) {
      emit(RegisterScreenSuccess());
    });
  }
}
