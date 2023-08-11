import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odd_sprat/src/config/app_route.dart';
import 'package:odd_sprat/src/core/error/response_status.dart';
import 'package:odd_sprat/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:odd_sprat/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:odd_sprat/src/features/soccer/presentation/widgets/block_dialog.dart';

import '../../../../../config/app_constants.dart';
import '../../../../../core/auth/auth_service.dart';

class SignupScreen extends StatefulWidget {
  late final AuthService authService;
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool isLoading = false;
  String? userNameError;
  String? passwordError;
  String? confirmPasswordError;
  String? emailError;

  void _validateEmail(String value) {
    if (value.isEmpty) {
      emailError = 'Please enter your email';
    } else if (!EmailValidator.validate(value)) {
      emailError = 'Please enter a valid email address';
    } else {
      emailError = null;
    }
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

  bool _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPasswordError = 'Please confirm your password';
      return false;
    } else if (value != _passwordController.text) {
      confirmPasswordError = 'Passwords do not match';
      return false;
    } else {
      confirmPasswordError = null;
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const SizedBox(height: 32.0),
                      Image.asset(
                        'assets/images/Oddsprat_Logo.png',
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      // Username
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.person,
                              color: AppColors.labelTextStyle),
                          labelStyle:
                              TextStyle(color: AppColors.labelTextStyle),
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
                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: AppColors.labelTextStyle),
                          floatingLabelStyle: AppStyles.floatingLabelTextStyle,
                          focusedBorder: AppStyles.focusedBorder,
                          enabledBorder: AppStyles.enabledBorder,
                          border: AppStyles.enabledBorder,
                          prefixIcon: Icon(Icons.mail_outline,
                              color: AppColors.labelTextStyle),
                        ),
                        style: const TextStyle(color: AppColors.background),
                        onChanged: (value) {
                          setState(() {
                            _validateEmail(value);
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return emailError;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          labelStyle:
                              const TextStyle(color: AppColors.labelTextStyle),
                          floatingLabelStyle: AppStyles.floatingLabelTextStyle,
                          focusedBorder: AppStyles.focusedBorder,
                          enabledBorder: AppStyles.enabledBorder,
                          border: AppStyles.enabledBorder,
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: AppColors.labelTextStyle),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                      const SizedBox(height: 16.0),
                      // Confirm Password
                      TextFormField(
                        style: const TextStyle(
                          color: AppColors.background,
                        ),
                        controller: _confirmPasswordController,
                        obscureText: !confirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle:
                              const TextStyle(color: AppColors.labelTextStyle),
                          floatingLabelStyle: AppStyles.floatingLabelTextStyle,
                          focusedBorder: AppStyles.focusedBorder,
                          enabledBorder: AppStyles.enabledBorder,
                          border: AppStyles.enabledBorder,
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: AppColors.labelTextStyle),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  confirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.labelTextStyle,
                                ),
                                onPressed: () {
                                  setState(() {
                                    confirmPasswordVisible =
                                        !confirmPasswordVisible;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _validateConfirmPassword(value);
                          });
                        },
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return confirmPasswordError;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      // Sign Up Button
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthLoadSuccess) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.soccerLayout);
                            }
                            if (state is AuthLoadFailed &&
                                state.message ==
                                    DataSource.networkConnectError
                                        .getFailure()
                                        .message) {
                              buildBlockAlert(
                                  context: context, message: state.message);
                            }
                          },
                          builder: (context, state) {
                            final loading = state is AuthLoading;
                            return ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().signUpWithEmail(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      name: _usernameController.text.trim());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.background.withOpacity(0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                minimumSize: const Size(double.infinity, 50.0),
                                // minimumSize: const Size(150, 50),
                              ),
                              child: loading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Signup',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                            );
                          },
                        ),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Or Continue as Guest Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.soccerLayout);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                                color: AppColors.labelTextStyle),
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
                            icon: const Icon(Icons.facebook),
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
                              'Already have an account?',
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
                                Navigator.pushReplacementNamed(
                                    context, Routes.login);
                              },
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: AppColors.background,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
