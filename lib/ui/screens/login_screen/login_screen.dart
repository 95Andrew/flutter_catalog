import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/data/repository/login_repository.dart';
import 'package:flutter_catalog/ui/screens/catalog_screen/catalog_screen.dart';
import 'package:flutter_catalog/ui/screens/login_screen/cubit/login_screen_cubit.dart';
import 'package:flutter_catalog/ui/shared/const_strings.dart';
import 'package:flutter_catalog/ui/shared/gradient_background.dart';
import 'package:flutter_catalog/ui/util/app_colors.dart';
import 'package:flutter_catalog/ui/util/ui_helpers.dart';
import 'package:flutter_catalog/ui/widgets/custom_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginScreenCubit cubit = LoginScreenCubit(LoginRepository());
  final FocusNode _loginFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is LoginScreenInitial) {
              return buildForm();
            }
            if (state is LoginScreenLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return buildForm();
          },
          listener: (context, state) {
            if (state is LoginScreenError) {
              FocusScope.of(context).requestFocus(new FocusNode());
              composeRedMessage(state.message).show(context);
            }
            if (state is LoginScreenSuccess) {
              Get.offAll(() => CatalogScreen());
            }
          },
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalSpaceBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTextFormFieldLogin(),
            verticalSpacer(verticalSpaceMedium),
            buildTextFormFieldPassword(),
            verticalSpacer(verticalSpaceBig),
            CustomButton(
              text: login,
              onTap: () {
                _sendLoginData();
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldPassword() {
    return TextFormField(
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      obscureText: cubit.obscurePasswordText,
      onChanged: (val) {
        cubit.emit(LoginScreenInitial());
      },
      decoration: InputDecoration(
          suffixIcon: cubit.passwordController.text.isEmpty
              ? SizedBox()
              : IconButton(
                  icon: Icon(cubit.obscurePasswordText ? Icons.visibility : Icons.visibility_off, color: colorIconButton),
                  onPressed: () {
                    if (cubit.passwordController.text.isNotEmpty) {
                      cubit.obscurePasswordText = !cubit.obscurePasswordText;
                      cubit.emit(LoginScreenInitial());
                    }
                  },
                ),
          labelText: password.toUpperCase()),
      controller: cubit.passwordController,
      validator: (value) => value.isEmpty ? enterPassword : null,
      onFieldSubmitted: (val) {
        _sendLoginData();
      },
    );
  }

  TextFormField buildTextFormFieldLogin() {
    return TextFormField(
      focusNode: _loginFocusNode,
      onChanged: (val) {
        cubit.ignoreLogin = cubit.loginController.text.isEmpty;
        cubit.emit(LoginScreenInitial());
      },
      onFieldSubmitted: (val) {
        _loginFocusNode.nextFocus();
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: login.toUpperCase(),
          suffixIcon: IgnorePointer(
            ignoring: cubit.ignoreLogin,
            child: IconButton(
                icon: Icon(Icons.highlight_remove, color: cubit.ignoreLogin ? Colors.transparent : colorIconButton),
                onPressed: () {
                  cubit.loginController.clear();
                  cubit.ignoreLogin = true;
                  cubit.emit(LoginScreenInitial());
                }),
          )),
      controller: cubit.loginController,
      validator: (value) => value.isEmpty ? enterLogin : null,
    );
  }

  _sendLoginData() {
    if (_formKey.currentState.validate()) {
      cubit.login();
    }
  }
}
