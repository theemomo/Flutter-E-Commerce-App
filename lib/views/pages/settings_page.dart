import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/views/widgets/settings_widget.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SettingsWidget(
                image: "https://cdn-icons-png.flaticon.com/512/9458/9458229.png",
                onItemTapped: () {
                  Navigator.pushNamed(context, AppRoutes.deleteAddressRoute);
                },
                subTitle: "Click here to delete address",
                title: "Addresses",
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SettingsWidget(
                image: "https://cdn-icons-png.flaticon.com/512/2529/2529497.png",
                onItemTapped: () {
                  Navigator.pushNamed(context, AppRoutes.deletePaymentCardsRoute);
                },
                subTitle: "Click here to delete cards",
                title: "Payment Cards",
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SettingsWidget(
                image: "https://cdn-icons-png.flaticon.com/512/1000/1000966.png",
                onItemTapped: () {
                  Navigator.pushNamed(context, AppRoutes.changePasswordRoute);
                },
                subTitle: "Change your password",
                title: "Passwords",
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SettingsWidget(
                image: "https://cdn-icons-png.flaticon.com/512/10421/10421464.png",
                onItemTapped: () {},
                subTitle: "Change your email",
                title: "Email",
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

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
                    child: Text(
                      "Log Out",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: AppColors.red),
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () async {
                  // await BlocProvider.of<AuthCubit>(context).logout();
                },
                child: BlocConsumer<AuthCubit, AuthState>(
                  listenWhen: (previous, current) =>
                    current is ErrorDeletingAccount || current is AccountDeleted,
                  listener: (context, state) {
                    if (state is AccountDeleted) {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(AppRoutes.loginRoute, (route) => false);
                  } else if (state is ErrorDeletingAccount) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error Deleting Account: ${state.message}")));
                  }
                  },
                  buildWhen: (previous, current) => current is DeletingAccount,
                  builder: (context, state) {
                    if (state is DeletingAccount) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.red));
                  }
                  return TextButton(
                    onPressed: () async {
                      await BlocProvider.of<AuthCubit>(context).deleteMyAccount();
                    },
                    child: Text(
                      "Delete My Account",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: AppColors.red),
                    ),
                  );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
