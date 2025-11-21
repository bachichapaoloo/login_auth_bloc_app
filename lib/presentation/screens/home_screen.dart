import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_auth_bloc_app/logic/auth_bloc/auth_bloc.dart';
import 'package:login_auth_bloc_app/logic/auth_bloc/auth_event.dart';
import 'package:login_auth_bloc_app/logic/auth_bloc/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // 2. Listen for the "Unauthenticated" state
        if (state is AuthUnauthenticated) {
          // 3. Navigate to Login and ERASE history
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (route) => false, // This predicate removes all previous routes
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Optional: Display username if you have it
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    return Text("Welcome, ${state.username}!");
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TRIGGER LOGOUT
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
