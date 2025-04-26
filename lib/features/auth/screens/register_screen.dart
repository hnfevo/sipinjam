import 'package:flutter/material.dart';
import '../../home/screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../models/user.dart';
import '../../../core/constants.dart';
import '../../../widgets/input_field.dart';
import '../../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  void _handleRegister() async {
    if (_nameController.text.isEmpty ||
        _idController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Semua kolom harus diisi')));
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kata sandi tidak cocok')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authService.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
        nimNidn: _idController.text,
        role: 'mahasiswa', // Default role, bisa ditambahkan dropdown jika perlu
        phone: _phoneController.text,
      );

      if (response['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['message'])));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset('assets/sp_logo.png', height: 60, width: 100),
              const SizedBox(height: 8),
              const Text(AppStrings.appName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryRed)),
              const SizedBox(height: 30),
              InputField(controller: _nameController, label: 'Nama Lengkap'),
              InputField(controller: _idController, label: 'NIDN/NIM'),
              InputField(controller: _emailController, label: 'Email'),
              InputField(controller: _phoneController, label: 'No Hp'),
              InputField(controller: _passwordController, label: 'Kata Sandi', isPassword: true),
              InputField(controller: _confirmPasswordController, label: 'Ketik ulang kata sandi', isPassword: true),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _handleRegister,
                        child: const Text('Register'),
                      ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah punya akun? '),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                    child: const Text('Login'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(AppStrings.footerText, style: TextStyle(fontSize: 12, color: Colors.black54), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}