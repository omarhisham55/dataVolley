import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/features/registration/presentation/cubit/registration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:data_volley_match/injection.dart' as di;

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  bool passwordObscure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: RegistrationCubit.createEmailUserFormKey,
      child: Column(
        children: [
          SharedWidgets.hintTextField(
            context: context,
            hintText: 'email',
            controller: di.injection<RegistrationCubit>().emailController,
            keyboardType: TextInputType.emailAddress,
            validate: (value) {
              return value!.isEmpty ? 'Enter valid email' : null;
            },
          ),
          SharedWidgets.hintTextField(
            context: context,
            hintText: 'password',
            controller: di.injection<RegistrationCubit>().passwordController,
            keyboardType: TextInputType.text,
            validate: (value) {
              return value!.length < 6
                  ? 'Enter valid password length: 6'
                  : null;
            },
            obscureText: passwordObscure,
            suffixIcon: GestureDetector(
              onTap: () => setState(
                () {
                  passwordObscure = !passwordObscure;
                },
              ),
              child: Icon(
                passwordObscure
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined,
              ),
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: Divider(height: 100, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Or',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Expanded(
                child: Divider(height: 100, color: Colors.grey),
              ),
            ],
          ),
          SharedWidgets.googleButton(
            context,
            () => di.injection<RegistrationCubit>().createGoogleUser(),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool passwordObscure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: RegistrationCubit.loginUserFormKey,
      child: Column(
        children: [
          SharedWidgets.hintTextField(
            context: context,
            hintText: 'email',
            controller: di.injection<RegistrationCubit>().emailController,
            validate: (value) {
              return value!.isEmpty ? 'Enter valid email' : null;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          SharedWidgets.hintTextField(
            context: context,
            hintText: 'password',
            controller: di.injection<RegistrationCubit>().passwordController,
            validate: (value) {
              return value!.length < 6
                  ? 'Enter valid password length: 6'
                  : null;
            },
            keyboardType: TextInputType.text,
            obscureText: passwordObscure,
            suffixIcon: GestureDetector(
              onTap: () => setState(
                () {
                  passwordObscure = !passwordObscure;
                },
              ),
              child: Icon(
                passwordObscure
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
