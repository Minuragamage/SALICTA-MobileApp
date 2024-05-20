import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salicta_mobile/db/authentication.dart';
import 'package:salicta_mobile/db/repository/customer_repository.dart';
import 'package:salicta_mobile/firebase_bloc/spec/query_transformer_utils.dart';
import 'package:salicta_mobile/ui/auth_page/login_page/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(BuildContext context) : super(LoginState.initialState);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authentication = Authentication();
  final _userRepository = CustomerRepository();

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    _addErr(error);
    super.onError(error, stackTrace);
  }

  void _addErr(e) {
    if (e is StateError) {
      return;
    }
    try {
      errorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      );
    } catch (e) {
      errorEvent("Something went wrong. Please try again !");
    }
  }

  void errorEvent(String error) {
    emit(state.clone(error: ''));
    emit(state.clone(error: error));
  }

  Future<void> userLogin(String emails, String password) async {
    try {
      emit(state.clone(processing: true));
      if (isValidEmail(emails)) {

        final dbUsers = await _userRepository.querySingle(
          spec: ComplexWhere('email', isEqualTo: emails),
        );

        final dbUser = dbUsers.toList(growable: false);


        if (dbUser.isNotEmpty) {
          final userEmail = await _authentication.login(emails, password);

          if (userEmail != null) {
            if (userEmail.isNotEmpty) {
              emit(state.clone(email: userEmail, error: ""));
            }
          } else {
            errorEvent('Sorry..Something went wrong. Please contact us..');
            emit(
              state.clone(email: '', processing: false),
            );
          }

        } else {
          emit(state.clone(processing: false));
          errorEvent('Sorry..Something went wrong. Please contact us..');
          return;
        }
      } else {
        emit(state.clone(
          error: "Invalid Email...Please Try Again",
        ));
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.clone(error: "No user found for that email."));
        return;
      } else if (e.code == 'wrong-password') {
        emit(state.clone(error: "Wrong password provided for that user."));
        return;
      }
    }
  }

  restPassword(String email) async {
    if (isValidEmail(email)) {
      final fetchEmail =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (fetchEmail.isEmpty) {
        errorEvent("Invalid Email...Please Try Again");
        return;
      }
      try {
        await _authentication.sendPasswordResetEmail(email);
      } catch (e) {
        errorEvent("Invalid Email...Please Try Again");
      }
    } else {
      errorEvent("Invalid Email...Please Try Again");
      return;
    }
  }
}
