import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final newPasswordController = TextEditingController();
    final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Change Your Password",
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                """
    Instructions for a Strong Password:
    
    1. Use at least 12–16 characters.
    2. Include uppercase (A–Z) and lowercase (a–z) letters.
    3. Add numbers (0–9).
    4. Add symbols (! @ # \$ % ^ & * etc.).
    5. Avoid common words, names, or dates.
    6. Do not reuse old passwords.
    7. Use a passphrase (e.g., BlueHorse!Drinks7Pizza).
    8. Consider using a password manager for extra safety.
    """,

                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Form(
                  key: _passwordFormKey,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      } else if (value.length < 6) {
                        return "Number must be at least 6 digits";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        CupertinoIcons.lock_fill,
                        color: AppColors.grey.withValues(alpha: 0.8),
                      ),
                      fillColor: AppColors.grey.withValues(alpha: 0.1),
                      filled: true,
                      hintText: "Write your new password",
                      hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.8)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    current is UpdatePasswordSuccessfully || current is UpdatingPasswordFailure,
                listener: (context, state) {
                  if (state is UpdatePasswordSuccessfully) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("Password Updated Successfully.")));
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(AppRoutes.loginRoute, (route) => false);
                  } else if (state is UpdatingPasswordFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error Updating Password: ${state.message}")),
                    );
                  }
                },
                buildWhen: (previous, current) => current is UpdatingPassword,
                builder: (context, state) {
                  if (state is UpdatingPassword) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_passwordFormKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).updatePassword(newPasswordController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      child: Text(
                        "Change my password",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
