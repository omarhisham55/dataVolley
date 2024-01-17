import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/core/utils/strings.dart';
import 'package:data_volley_match/features/registration/presentation/cubit/registration_cubit.dart';
import 'package:data_volley_match/features/registration/presentation/widgets/account_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    RegistrationStrings.existingAccount,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const LoginForm(),
                ],
              ),
            ),
            SharedWidgets.outlinedButton(
              'Submit',
              () => RegistrationCubit.loginUserFormKey.currentState!.validate()
                  ? BlocProvider.of<RegistrationCubit>(context).login()
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
