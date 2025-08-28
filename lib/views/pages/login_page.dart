import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    // bool _obscureText = true;

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 29.0, right: 20.0, top: 50.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Login Account",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Please login with your registered account",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Email or Phone Number",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: const [],
                      validator: (value) => value == null || value.isEmpty
                          ? "Please Enter an Email or Phone Number"
                          : null,
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: AppColors.grey.withValues(alpha: 0.8)),
                        fillColor: AppColors.grey.withValues(alpha: 0.1),
                        filled: true,
                        hintText: "Enter Your Email or Phone Number",
                        hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.8)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: AppColors.red),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      "Password",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: const [],
                      validator: (value) =>
                          value == null || value.isEmpty ? "Please Enter a Password" : null,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility),
                          color: AppColors.grey.withValues(alpha: 0.8),
                        ),
                        prefixIcon: Icon(Icons.lock, color: AppColors.grey.withValues(alpha: 0.8)),
                        fillColor: AppColors.grey.withValues(alpha: 0.1),
                        filled: true,
                        hintText: "Enter Your Password",
                        hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.8)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: AppColors.red),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: BlocConsumer<AuthCubit, AuthState>(
                        listenWhen: (previous, current) =>
                            current is AuthSuccess || current is AuthFailure,
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            Navigator.pushNamed(context, AppRoutes.homeRoute);
                          } else if (state is AuthFailure) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(state.error)));
                          }
                        },
                        buildWhen: (previous, current) =>
                            current is AuthLoading || current is AuthSuccess,
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(
                              child: CircularProgressIndicator(color: AppColors.primary),
                            );
                          } else if (state is AuthSuccess) {
                            return Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.homeRoute);
                                },
                                child: const Text(
                                  "Login Successful, proceed to home",
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ),
                            );
                          }
                          return ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await context.read<AuthCubit>().login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                            ),
                            child: Text(
                              "Login",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.registerRoute);
                        },
                        child: Text(
                          "Don't have an account? Register",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Or using other methods",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          null;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.black,
                          shadowColor: Colors.transparent,
                          side: const BorderSide(color: AppColors.grey, width: 0.1),
                        ),
                        icon: CachedNetworkImage(
                          imageUrl: "https://cdn-icons-png.flaticon.com/512/300/300221.png",
                          width: 25,
                        ),
                        label: Text(
                          "Login with Google",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          null;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.black,
                          shadowColor: Colors.transparent,
                          side: const BorderSide(color: AppColors.grey, width: 0.1),
                        ),
                        icon: CachedNetworkImage(
                          imageUrl: "https://cdn-icons-png.flaticon.com/512/5968/5968764.png",
                          width: 25,
                        ),
                        label: Text(
                          "Login with Facebook",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
