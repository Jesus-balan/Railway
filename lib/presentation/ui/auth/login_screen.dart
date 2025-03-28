import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:railway/presentation/bloc/auth/auth_bloc.dart';
import 'package:railway/presentation/ui/auth/register_screen.dart';
import 'package:railway/presentation/ui/home/booking_screen.dart';
import 'package:railway/presentation/widgets/textfield_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF053149),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
             if (state is AuthSuccess) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => BookingScreen()));
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          },
          builder: (context, state) {
            return Stack(
              children: [
                /// **Top Logo**
                Positioned(
                  top: size.height * 0.1,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(
                      Icons.train,
                      color: Colors.white,
                      size: size.width * 0.18,
                    ),
                  ),
                ),

                /// **White Container - Login Form**
                Positioned(
                  top: size.height * 0.3,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.04),

                          /// **Login Title**
                          Center(
                            child: Text(
                              "Login",
                              style: GoogleFonts.lora(
                                fontSize: size.width * 0.09,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(height: size.height * 0.04),

                          /// **Email Field**
                          CustomTextField(
                            prefixIcon: Icons.email,
                            label: 'Email',
                            controller: emailController,
                          ),

                          SizedBox(height: size.height * 0.02),

                          /// **Password Field**
                          CustomTextField(
                            prefixIcon: Icons.password,
                            label: 'Password',
                            controller: passwordController,
                          ),

                          SizedBox(height: size.height * 0.04),

                          /// **Login Button**
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF053149),
                                padding: EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                context.read<AuthBloc>().add(SignInEvent(emailController.text, passwordController.text));
                              },
                              child: state is AuthLoading
                                      ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                              :Text(
                                "Login",
                                style: GoogleFonts.lora(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: size.height * 0.08),

                          /// **Sign Up Navigation**
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.lora(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  children: [
                                    TextSpan(text: "Don't have an account? "),
                                    TextSpan(
                                      text: "Sign Up",
                                      style: GoogleFonts.lora(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Colors
                                                .blueAccent, // Highlight color
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
