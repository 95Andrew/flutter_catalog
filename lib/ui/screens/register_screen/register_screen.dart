import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/data/repository/register_repository.dart';
import 'package:flutter_catalog/ui/screens/login_screen/login_screen.dart';
import 'package:flutter_catalog/ui/screens/register_screen/cubit/register_screen_cubit.dart';
import 'package:flutter_catalog/ui/shared/const_strings.dart';
import 'package:flutter_catalog/ui/shared/gradient_background.dart';
import 'package:flutter_catalog/ui/util/app_colors.dart';
import 'package:flutter_catalog/ui/util/ui_helpers.dart';
import 'package:flutter_catalog/ui/widgets/custom_button.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterScreenCubit cubit = RegisterScreenCubit(RegisterRepository());

  final _formKey = GlobalKey<FormState>();
  final FocusNode _loginFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: BlocConsumer<RegisterScreenCubit, RegisterScreenState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is RegisterScreenInitial) {
              return buildForm();
            }
            if (state is RegisterScreenLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return buildForm();
          },
          listener: (context, state) {
            if (state is RegisterScreenSuccess) {
              Get.offAll(() => LoginScreen());
            }
            if (state is RegisterScreenError) {
              FocusScope.of(context).requestFocus(new FocusNode());
              composeRedMessage(state.message).show(context);
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
              text: register,
              onTap: () {
                _sendRegisterData();
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
        cubit.emit(RegisterScreenInitial());
      },
      decoration: InputDecoration(
          suffixIcon: cubit.passwordController.text.isEmpty
              ? SizedBox()
              : IconButton(
                  icon: Icon(cubit.obscurePasswordText ? Icons.visibility : Icons.visibility_off, color: colorIconButton),
                  onPressed: () {
                    if (cubit.passwordController.text.isNotEmpty) {
                      cubit.obscurePasswordText = !cubit.obscurePasswordText;
                      cubit.emit(RegisterScreenInitial());
                    }
                  },
                ),
          labelText: password.toUpperCase()),
      controller: cubit.passwordController,
      validator: (value) => value.isEmpty ? enterPassword : null,
      onFieldSubmitted: (val) {
        _sendRegisterData();
      },
    );
  }

  TextFormField buildTextFormFieldLogin() {
    return TextFormField(
      focusNode: _loginFocusNode,
      onFieldSubmitted: (val) {
        _loginFocusNode.nextFocus();
      },
      onChanged: (val) {
        cubit.ignoreLogin = cubit.loginController.text.isEmpty;
        cubit.emit(RegisterScreenInitial());
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: login.toUpperCase(),
          suffixIcon: IgnorePointer(
            ignoring: cubit.ignoreLogin,
            child: IconButton(
                icon: Icon(Icons.highlight_remove, color: cubit.ignoreLogin ? Colors.transparent : colorIconButton),
                onPressed: () {
                  print(cubit.ignoreLogin.toString());
                  cubit.loginController.clear();
                  cubit.ignoreLogin = true;
                  cubit.emit(RegisterScreenInitial());
                }),
          )),
      controller: cubit.loginController,
      validator: (value) => value.isEmpty ? enterLogin : null,
    );
  }

  _sendRegisterData() {
    if (_formKey.currentState.validate()) {
      cubit.register();
    }
  }
}
