import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odd_sprat/src/config/app_route.dart';
import 'package:odd_sprat/src/core/error/response_status.dart';
import 'package:odd_sprat/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:odd_sprat/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:odd_sprat/src/features/soccer/presentation/widgets/block_dialog.dart';

import '../../../../../config/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? userNameError;
  String? passwordError;
  bool isLoading = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  // @override
  // void initState() {
  //   _usernameController = TextEditingController();
  //   _passwordController = TextEditingController();
  //   super.initState();
  // }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateUserName(String value) {
    if (value.isEmpty) {
      userNameError = 'Please enter your username';
    } else if (value.trim().contains(' ')) {
      userNameError = 'Please enter only one word for your username';
    } else {
      userNameError = null;
    }
  }

  bool _validatePassword(String value) {
    if (value.isEmpty) {
      passwordError = 'Please enter a password';
      return false;
    } else if (value.length < 8) {
      passwordError = 'Password must be at least 8 characters long';
      return false;
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      passwordError = 'Password must contain at least one uppercase letter';
      return false;
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      passwordError = 'Password must contain at least one lowercase letter';
      return false;
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      passwordError = 'Password must contain at least one number';
      return false;
    }
    if (!value.contains(RegExp(r'[!@#\$&*~_]'))) {
      passwordError =
          'Password must contain at least one special character (!@#\$&*~_+)';
      return false;
    } else {
      passwordError = null;
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Oddsprat_Logo.png',
              height: 100,
            ),
            const SizedBox(height: 10),
            // Username
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.person, color: AppColors.labelTextStyle),
                labelStyle: TextStyle(color: AppColors.labelTextStyle),
                floatingLabelStyle: AppStyles.floatingLabelTextStyle,
                focusedBorder: AppStyles.focusedBorder,
                enabledBorder: AppStyles.enabledBorder,
                border: AppStyles.enabledBorder,
              ),
              style: const TextStyle(color: AppColors.background),
              onChanged: (value) {
                setState(() {
                  _validateUserName(value);
                });
              },
              validator: (value) {
                if (value!.isEmpty) return 'Please enter a username';
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[\\s]')),
              ],
            ),
            const SizedBox(height: 16.0),
            // Password
            TextFormField(
              style: const TextStyle(
                color: AppColors.background,
              ),
              controller: _passwordController,
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: AppColors.labelTextStyle),
                floatingLabelStyle: AppStyles.floatingLabelTextStyle,
                focusedBorder: AppStyles.focusedBorder,
                enabledBorder: AppStyles.enabledBorder,
                border: AppStyles.enabledBorder,
                prefixIcon: const Icon(Icons.lock_outline,
                    color: AppColors.labelTextStyle),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.labelTextStyle,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                      confirmPasswordVisible = false;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _validatePassword(value);
                });
              },
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return passwordError;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Navigate to Forgot Password Screen
                },
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(
                    color: AppColors.labelTextStyle,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            // Sign Up Button
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                if (state is AuthLoadSuccess) {
                  Navigator.pushReplacementNamed(context, Routes.soccerLayout);
                }
                if (state is AuthLoadFailed &&
                    state.message ==
                        DataSource.networkConnectError.getFailure().message) {
                  buildBlockAlert(context: context, message: state.message);
                }
              }, builder: (context, state) {
                final loading = state is AuthLoading;
                return ElevatedButton(
                  onPressed: () async {
                    context.read<AuthCubit>().login(
                        email: _usernameController.text.trim(),
                        password: _passwordController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(double.infinity, 50.0),
                    // minimumSize: const Size(150, 50),
                  ),
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                );
              }),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.primary,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                  const Text(
                    'OR',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.primary,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Or Continue as Guest Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.soccerLayout);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: AppColors.labelTextStyle),
                ),
                minimumSize: const Size(double.infinity, 50.0),
              ),
              child: const Text(
                "Continue as Guest",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.labelTextStyle,
                ),
              ),
            ),

            // Placeholder for third-party sign-in buttons
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook, color: AppColors.primary),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: AppColors.background,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.signup);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
