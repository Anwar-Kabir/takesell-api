import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/screens/bottom_navbar.dart';
import './providers/auth_provider.dart';
import './providers/data_provider.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => DataProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          home: auth.isAuthenticated ?   const BottomNavbar() : const LoginScreen(),
          routes: {
            '/login': (ctx) => const LoginScreen(),
            '/signup': (ctx) => const SignupScreen(),
            '/home': (ctx) =>   const HomePage(),
          },
        ),
      ),
    );
  }
}
