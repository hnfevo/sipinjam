import 'package:flutter/material.dart';
import '../../home/screens/home_screen.dart';
import '../screens/register_screen.dart';
import '../../../core/constants.dart';
import '../../../widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password harus diisi')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/sp_logo.png', height: 60, width: 100),
            const SizedBox(height: 8),
            const Text(AppStrings.appName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryRed)),
            const SizedBox(height: 30),
            InputField(controller: _usernameController, label: 'Username'),
            const SizedBox(height: 16),
            InputField(controller: _passwordController, label: 'Password', isPassword: true),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleLogin,
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Belum memiliki akun? '),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
                  child: const Text('Register'),
                ),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Text(AppStrings.footerText, style: TextStyle(fontSize: 12, color: Colors.black54), textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}