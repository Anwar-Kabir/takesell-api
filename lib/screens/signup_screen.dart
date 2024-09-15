import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/screens/widget/custom_text_form_field.dart';
 
import '../managers/signup_form_manager.dart';  

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use ChangeNotifierProvider to manage state via SignupFormManager
    return ChangeNotifierProvider(
      create: (_) => SignupFormManager(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SignupFormManager>(
            builder: (context, manager, child) {
              return Form(
                key: manager.formKey, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Create Account",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: manager.nameController,
                      labelText: 'Name',
                      icon: Icons.person,
                      validator: manager.validateName,
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
                            child: const Text('Sign Up'),
                          ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: const Text("Already have an account? Log in here"),
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
