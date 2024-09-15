import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/managers/login_form_manager.dart';
import 'package:rest_api/screens/widget/custom_text_form_field.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use ChangeNotifierProvider to manage state via LoginFormManager
    return ChangeNotifierProvider(
      create: (_) => LoginFormManager(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LoginFormManager>(
            builder: (context, manager, child) {
              return Form(
                key: manager.formKey, // Attach form key
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Welcome Back",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: manager.emailController,
                      labelText: 'Email',
                      icon: Icons.email,
                      validator: manager.validateEmail,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: manager.passwordController,
                      labelText: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: manager.validatePassword,
                    ),
                    const SizedBox(height: 20),
                    manager.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () => manager.submit(context),
                            child: const Text('Login'),
                          ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/signup');
                      },
                      child: const Text("Don't have an account? Sign up here"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
