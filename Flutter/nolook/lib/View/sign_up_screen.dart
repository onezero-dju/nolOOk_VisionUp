import 'package:flutter/material.dart';
import 'package:nolook/Controller/user_register.dart';
import 'package:nolook/Model/user.dart';
import 'package:nolook/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _userController = UserController();
  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _userController.register(
          _emailController.text,
          _passwordController.text,
          _userNameController.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful')),
          );
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드를 내리는 동작
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: '이메일',
                  obscureText: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.024),
                CustomTextFormField(
                  controller: _userNameController,
                  labelText: '이름',
                  obscureText: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.024),
                CustomTextFormField(
                  controller: _passwordController,
                  labelText: '비밀번호',
                  obscureText: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // 회원가입 버튼 동작 정의
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('회원가입 성공')),
                      );
                      _register();
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // 버튼 색상 설정
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.018),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.1),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
