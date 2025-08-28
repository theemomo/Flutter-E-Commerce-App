import 'package:e_commerce/utils/app_router.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.checkAuthStatus();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) => current is AuthSuccess || current is AuthInitial,
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  primaryColor: Colors.deepPurple,
                  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
                  scaffoldBackgroundColor: Colors.white,
                  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
                ),
                initialRoute: state is AuthSuccess ? AppRoutes.homeRoute : AppRoutes.loginRoute,
                // home: const CustomBottomNavbar(),
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
