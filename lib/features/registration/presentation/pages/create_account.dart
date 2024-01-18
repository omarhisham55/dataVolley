import 'package:data_volley_match/config/routes/routes.dart';
import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/core/utils/strings.dart';
import 'package:data_volley_match/features/match_layout/presentation/pages/app_entry/app_entry.dart';
import 'package:data_volley_match/features/registration/presentation/cubit/registration_cubit.dart';
import 'package:data_volley_match/features/registration/presentation/widgets/account_form.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              RegistrationStrings.createAccount,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const CreateAccountForm(),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, Routes.login),
                              child: EasyRichText(
                                '${RegistrationStrings.goToLogin} login',
                                defaultStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                patternList: [
                                  EasyRichTextPattern(
                                    targetString: 'login',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SharedWidgets.outlinedButton(
                        'Submit',
                        () {
                          return RegistrationCubit
                                  .createEmailUserFormKey.currentState!
                                  .validate()
                              ? BlocProvider.of<RegistrationCubit>(context)
                                  .createEmailUser()
                              : null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const AppEntry();
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
