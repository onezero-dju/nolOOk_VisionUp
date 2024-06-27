import 'package:flutter/material.dart';
import 'package:nolook/Controller/user_controller.dart';
import 'package:nolook/View/memo_screen.dart';
import 'package:nolook/View/register_screen.dart';
import 'package:nolook/widgets/custom_text_field.dart';

//로그인 화면이다
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _userController = UserController();
  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _userController.login(
          _emailController.text,
          _passwordController.text,
        );
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MemoScreen(),
            ),
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
      backgroundColor: const Color.fromARGB(255, 242, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 243, 235),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드를 내리는 동작
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      'nolOOk',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.09,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.14),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: '이메일',
                  obscureText: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.024),
                CustomTextFormField(
                  controller: _passwordController,
                  labelText: '비밀번호',
                  obscureText: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.017),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // 이메일/비밀번호 찾기 동작 정의
                    },
                    child: const Text(
                      '이메일/비밀번호 찾기 >',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ElevatedButton(
                  onPressed: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const MemoScreen(),
                    //   ),
                    // );

                    _login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // 버튼 색상 설정
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.1),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 이메일로 회원가입 버튼 동작 정의
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // 버튼 색상 설정
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.1),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '이메일로 회원가입',
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
