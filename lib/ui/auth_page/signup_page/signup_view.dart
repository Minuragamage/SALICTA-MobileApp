import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/ui/auth_page/signup_page/signup_cubit.dart';
import 'package:salicta_mobile/ui/auth_page/signup_page/signup_state.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_view.dart';

import '../../../theme/constants.dart';
import '../../widgets/common_snack_bar.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late FocusNode _viewFocus;
  late FocusNode _emailFocus;
  late FocusNode _nameFocus;
  late FocusNode _passwordFocus;
  late FocusNode _confirmPasswordFocus;
  bool passwordVisible = false;

  late SignUpCubit signUpCubit;
  late RootCubit rootBloc;

  @override
  void initState() {
    super.initState();

    signUpCubit = BlocProvider.of<SignUpCubit>(context);
    rootBloc = BlocProvider.of<RootCubit>(context);

    _viewFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _nameFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _viewFocus.dispose();
    _emailFocus.dispose();
    _emailController.dispose();
    _passwordFocus.dispose();
    _nameController.dispose();
    _nameFocus.dispose();
    _passwordController.dispose();
    _confirmPasswordFocus.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _nameValidator(String? val) {
    return _nameController.text.isNotEmpty ? null : 'Please enter your name';
  }

  String? _emailValidator(String? val) {
    return (GetUtils.isEmail(val ?? '')) ? null : 'Please enter your email';
  }

  String? _passwordValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return 'Please enter a password';
    } else {
      if (val!.length < 6) {
        return 'Password should be at least 6 characters long';
      }
      return null;
    }
  }

  String? _confirmPasswordValidator(String? val) {
    return (val == 'password') ? null : "Passwords do not match";
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      // _authController.signUp(name, email, password);
    }
  }

  void _toLoginScreen() {
    Navigator.pop(context);
  }

  void _registerClicked() {
    ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.loadingSnackBar);
    final email = (_emailController.text).trim();
    final name = (_nameController.text).trim();
    final password = (_passwordController.text).trim();
    final confirm = (_confirmPasswordController.text).trim();

    signUpCubit.createUser(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirm,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Flexible(
                      child: Divider(
                        color: kNoghreiSilver,
                        thickness: 1,
                        indent: 30,
                        endIndent: 20,
                      ),
                    ),
                    SvgPicture.asset("assets/furniture_vector.svg"),
                    const Flexible(
                      child: Divider(
                        color: kNoghreiSilver,
                        thickness: 1,
                        indent: 20,
                        endIndent: 30,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, bottom: 30),
                  child: Text(
                    "WELCOME",
                    style: kMerriweatherBold24,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.only(right: 16, left: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x408A959E),
                          offset: Offset(0, 7),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 15,
                          ),
                          child: TextFormField(
                            cursorColor: kOffBlack,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            controller: _nameController,
                            focusNode: _nameFocus,
                            validator: _nameValidator,
                            decoration: inputDecorationConst.copyWith(
                              labelText: "Name",
                              fillColor: primaryGreen.withOpacity(0.2),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 15,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            cursorColor: kOffBlack,
                            focusNode: _emailFocus,
                            controller: _emailController,
                            validator: _emailValidator,
                            decoration: inputDecorationConst.copyWith(
                              labelText: "Email",
                              fillColor: primaryGreen.withOpacity(0.2),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 15,
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            validator: _passwordValidator,
                            obscureText: !_showPassword,
                            textInputAction: TextInputAction.next,
                            cursorColor: kOffBlack,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: inputDecorationConst.copyWith(
                              labelText: "Password",
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, right: 15),
                                child: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: SvgPicture.asset(
                                    "assets/icons/password_visible.svg",
                                    height: 15,
                                    width: 20,
                                  ),
                                ),
                              ),
                              suffixIconConstraints:
                                  const BoxConstraints(maxWidth: 50),
                              fillColor: primaryGreen.withOpacity(0.2),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 15,
                          ),
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocus,
                            validator: _confirmPasswordValidator,
                            obscureText: !_showPassword,
                            enableSuggestions: false,
                            autocorrect: false,
                            cursorColor: kOffBlack,
                            decoration: inputDecorationConst.copyWith(
                              labelText: "Confirm Password",
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, right: 15),
                                child: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: SvgPicture.asset(
                                    "assets/icons/password_visible.svg",
                                    height: 15,
                                    width: 20,
                                  ),
                                ),
                              ),
                              suffixIconConstraints:
                                  const BoxConstraints(maxWidth: 50),
                              fillColor: primaryGreen.withOpacity(0.2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: _registerClicked,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x50303030),
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "SIGN UP",
                              style: kNunitoSansSemiBold18.copyWith(
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have a account?",
                              style: kNunitoSans14.copyWith(
                                fontWeight: FontWeight.w600,
                                color: kGrey,
                              ),
                            ),
                            TextButton(
                              onPressed: _toLoginScreen,
                              child: Text(
                                "SIGN IN",
                                style: kNunitoSans14.copyWith(
                                  color: primaryGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.showErrorSnackBar(state.error));
            } else {

              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
        BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (pre, current) => pre.processing != current.processing,
          listener: (context, state) {
            if (state.processing) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.loadingSnackBar);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
        BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (pre, current) =>
              pre.registered != current.registered ||
              pre.email != current.email,
          listener: (context, state) {
            if (state.registered && state.email.isNotEmpty) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();

              rootBloc.handleUserLogged(state.email);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RootView(
                    email: state.email,
                    fromSignUp: true,
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
