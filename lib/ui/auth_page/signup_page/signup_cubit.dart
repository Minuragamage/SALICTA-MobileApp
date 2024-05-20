import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salicta_mobile/db/authentication.dart';
import 'package:salicta_mobile/db/model/customer_model.dart';
import 'package:salicta_mobile/firebase_bloc/spec/query_transformer_utils.dart';
import 'package:salicta_mobile/ui/auth_page/signup_page/signup_state.dart';

import '../../../db/repository/customer_repository.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(BuildContext context) : super(SignUpState.initialState);

  final auth = Authentication();
  final userRepo = CustomerRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  Future<void> createUser({
    required String email,
    required String name,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      if (name.isEmpty) {
        errorEvent("Name can`t be Empty");
        emit(state.clone(processing: false));
        return;
      }

      if (email.isEmpty) {
        errorEvent("Email can`t be Empty");
        emit(state.clone(processing: false));
        return;
      }

      if (!isValidEmail(email)) {
        errorEvent("Please Enter valid Email");
        emit(state.clone(processing: false));
        return;
      }

      final dbUsers = await userRepo.querySingle(
        spec: ComplexWhere('email', isEqualTo: email),
      );


      final users = dbUsers.toList();

      if (users.isNotEmpty) {
        errorEvent("Email is already exist");
        emit(state.clone(processing: false));
        return;
      }

      if (confirmPassword.length < 6 || confirmPassword.isEmpty) {
        errorEvent("Password must have minimum 6 characters");
        emit(state.clone(processing: false));
        return;
      }

      final register = await auth.register(email, confirmPassword);

      if (register!.isEmpty) {
        errorEvent("Something Went wrong");
        emit(state.clone(processing: false));
        return;
      }

      final customer = CustomerModel(
        email: email,
        name: name,
        status: 'pending',
        profileImage: '',
        address: [],
        favourites: [],
      );

      await userRepo.add(
        item: customer,
      );

      emit(state.clone(email: email, registered: true, processing: false));
    } catch (e) {
      emit(state.clone(email: '', registered: false, processing: false));
      return;
    }
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
}
