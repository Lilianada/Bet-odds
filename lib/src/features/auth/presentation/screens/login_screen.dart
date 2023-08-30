import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resultizer/src/config/app_route.dart';
import 'package:resultizer/src/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../config/app_constants.dart';
import '../cubit/auth_state.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? emailError;
  String? passwordError;
  bool isLoading = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail(String value) {
    if (value.isEmpty) {
      emailError = 'Please enter your email';
    } else if (!EmailValidator.validate(value)) {
      emailError = 'Please enter a valid email address';
    } else {
      emailError = null;
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

  bool _validateInputs() {
    bool isValid = true;

    if (_emailController.text.isEmpty) {
      setState(() {
        emailError = 'Please enter a email';
      });
      isValid = false;
    }

    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 6) {
      setState(() {
        passwordError = 'Password must be at least 6 characters long';
      });
      isValid = false;
    }

    return isValid;
  }

  void _handleSignIn() async {
    final authCubit = context.read<AuthCubit>();

    setState(() {
      isLoading = true;
    });

    authCubit.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // React based on state changes of AuthCubit
    final state = authCubit.state;

    setState(() {
      isLoading = false;
    });

    if (state is AuthLoadFailed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    } else if (state is AuthLoadSuccess) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.soccerLayout,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logos/Resultizer_Logo_Black1.png',
                height: 100,
              ),
              const SizedBox(height: 10),
              // email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon:
                      Icon(Icons.person, color: AppColors.labelTextStyle),
                  labelStyle: TextStyle(color: AppColors.labelTextStyle),
                  floatingLabelStyle: AppStyles.floatingLabelTextStyle,
                  focusedBorder: AppStyles.focusedBorder,
                  enabledBorder: AppStyles.enabledBorder,
                  border: AppStyles.enabledBorder,
                ),
                style: const TextStyle(color: AppColors.background),
                onChanged: (value) {
                  setState(() {
                    _validateEmail(value);
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
                child: ElevatedButton(
                  onPressed: () async {
                    if (_validateInputs()) {
                      _handleSignIn();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(double.infinity, 50.0),
                    // minimumSize: const Size(150, 50),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.soccerLayout,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.transparent,
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
                        Navigator.pushNamed(context, '/signup');
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
      ),
    );
  }
}
