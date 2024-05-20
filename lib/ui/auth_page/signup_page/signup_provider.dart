import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salicta_mobile/ui/auth_page/signup_page/signup_cubit.dart';
import 'package:salicta_mobile/ui/auth_page/signup_page/signup_view.dart';


class SignUpProvider extends BlocProvider<SignUpCubit> {
  SignUpProvider({
    Key? key,
  }) : super(
          key: key,
          create: (context) => SignUpCubit(context),
          child: const SignUpView(),
        );
}
