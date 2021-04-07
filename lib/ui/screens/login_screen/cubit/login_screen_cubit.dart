import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/data/repository/login_repository.dart';
import 'package:meta/meta.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  bool ignoreLogin = true;
  bool obscurePasswordText = true;
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginRepository loginRepository;
  LoginScreenCubit(this.loginRepository) : super(LoginScreenInitial());

  Future<void> login({String username, String password}) async {
    emit(LoginScreenLoading());
    final response = await loginRepository.login(username: loginController.text, password: passwordController.text);
    response.fold((error) {
      LoginScreenError(message: error.message);
    }, (result) {
      emit(LoginScreenSuccess());
    });
  }
}
