import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/auth_page/login_page/login_cubit.dart';
import 'package:salicta_mobile/ui/auth_page/login_page/login_state.dart';
import 'package:salicta_mobile/ui/auth_page/signup_page/signup_provider.dart';
import 'package:salicta_mobile/ui/home_page/views/home_view.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_view.dart';
import 'package:salicta_mobile/ui/widgets/common_snack_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late FocusNode _viewFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;

  late LoginCubit loginBloc;
  late RootCubit rootBloc;

  bool _showPassword = false;


  Future<void> _loginClicked() async {
    ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.loadingSnackBar);

    final email = (_emailController.text).trim();
    final password = (_passwordController.text).trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar.showErrorSnackBar("Email or Password is Empty!"));
      return;
    }

    if(!GetUtils.isEmail(email)){
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar.showErrorSnackBar("Please Enter Valid Email"));
      return;
    }
    await loginBloc.userLogin(email, password);
  }

  @override
  void initState() {
    super.initState();

    loginBloc = BlocProvider.of<LoginCubit>(context);
    rootBloc = BlocProvider.of<RootCubit>(context);


    _viewFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _viewFocus.dispose();
    _emailFocus.dispose();
    _emailController.dispose();
    _passwordFocus.dispose();
    _passwordController.dispose();
    super.dispose();
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

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _forgotPassword() async {
  }


  @override
  Widget build(BuildContext context) {
    final scaffold= Scaffold(
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
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 10, top: 30),
                  child: Text(
                    "Hello !",
                    style: kMerriweather30TinGrey.copyWith(
                        color: primaryGreen,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 30),
                  child: Text(
                    "WELCOME BACK",
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
                          offset: Offset(0, 8),
                          blurRadius: 40,
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
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            focusNode: _emailFocus,
                            validator: _emailValidator,
                            cursorColor: kOffBlack,
                            decoration: inputDecorationConst.copyWith(
                                labelText: "Email",
                                fillColor: primaryGreen.withOpacity(0.2)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 15),
                          child: TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            validator: _passwordValidator,
                            obscureText: !_showPassword,
                            cursorColor: kOffBlack,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: inputDecorationConst.copyWith(
                              labelText: "Password",
                              fillColor: primaryGreen.withOpacity(0.2),
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
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: _forgotPassword,
                          child: Text(
                            "Forgot Password",
                            style: kNunitoSansSemiBold18.copyWith(
                              fontSize: 16,
                              color: primaryGreen.withOpacity(0.8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: _loginClicked,
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
                                "Sign In",
                                style: kNunitoSansSemiBold18.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpProvider(),
                              ),
                            );
                          },
                          child: Text(
                            "SIGN UP",
                            style: kNunitoSansSemiBold18.copyWith(
                              color: primaryGreen,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
        BlocListener<LoginCubit, LoginState>(
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
        BlocListener<LoginCubit, LoginState>(
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
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (pre, current) =>
          pre.email != current.email && current.email.isNotEmpty,
          listener: (context, state) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();

            rootBloc.handleUserLogged(state.email);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RootView(
                  email: state.email,
                ),
              ),
            );
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => true,
        child: scaffold,
      ),
    );
  }
}
