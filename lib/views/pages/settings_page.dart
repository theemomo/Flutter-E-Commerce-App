import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    current is AuthErrorLoggingOut || current is AuthLoggedOut,
                listener: (context, state) {
                  if (state is AuthLoggedOut) {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(AppRoutes.loginRoute, (route) => false);
                  } else if (state is AuthErrorLoggingOut) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error logging out: ${state.error}")));
                  }
                },
                buildWhen: (previous, current) => current is AuthLoggingOut,
                builder: (context, state) {
                  if (state is AuthLoggingOut) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.red));
                  }
                  return TextButton(
                    onPressed: () async {
                      await BlocProvider.of<AuthCubit>(context).logout();
                    },
                    child: const Text("Log Out", style: TextStyle(color: AppColors.red)),
                  );
                },
              ),
              TextButton(
                onPressed: () async {
                  // await BlocProvider.of<AuthCubit>(context).logout();
                },
                child: const Text("Remove My Account", style: TextStyle(color: AppColors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
