import 'package:e_commerce/utils/app_router.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await handelNotification();
}

// Future<void> handelNotification() async {
//   // request permission
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   NotificationSettings settings = await messaging.requestPermission();
//   debugPrint('User granted permission: ${settings.authorizationStatus}');

//   // handling foreground messages
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     debugPrint('Got a message whilst in the foreground!');
//     debugPrint('Message data: ${message.data}');

//     if (message.notification != null) {
//       final String title = message.notification!.title ?? "";
//       final String body = message.notification!.body ?? "";
//       debugPrint('Message also contained a notification: ${message.notification}');
//       debugPrint('Message also contained a notification: $title');
//       debugPrint('Message also contained a notification: $body');

//       showDialog(
//         context: navigatorKey.currentContext!,
//         builder: (_) {
//           return AlertDialog(
//             title: Text(title),
//             content: Text(body),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(navigatorKey.currentContext!).pop();
//                 },
//                 child: const Text("Ok"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   });
// }

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
                navigatorKey: navigatorKey,
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
