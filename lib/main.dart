import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:login_auth_bloc_app/core/auth_guard.dart';
import 'package:login_auth_bloc_app/logic/auth_bloc/auth_bloc.dart';
import 'package:login_auth_bloc_app/logic/auth_bloc/auth_event.dart';
import 'package:login_auth_bloc_app/presentation/screens/home_screen.dart';
import 'package:login_auth_bloc_app/presentation/screens/login_screen.dart';
import 'package:login_auth_bloc_app/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('auth_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository())..add(AuthCheckRequested()),
      child: MaterialApp(
        title: 'Auth Flow Assignment',
        routes: {
          '/': (context) => const AuthGuard(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
