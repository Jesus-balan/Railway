import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:railway/presentation/bloc/auth/auth_bloc.dart';
import 'package:railway/presentation/ui/auth/login_screen.dart';
import 'package:railway/presentation/ui/home/booking_screen.dart';
import 'package:railway/presentation/widgets/textfield_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

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
                Positioned(
                  top: size.height * 0.05,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lora(
                        fontSize: size.width * 0.09,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.15,
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
                          CustomTextField(
                            prefixIcon: Icons.person,
                            label: 'First Name',
                            controller: firstNameController,
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomTextField(
                            prefixIcon: Icons.person,
                            label: 'Last Name',
                            controller: lastNameController,
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomTextField(
                            prefixIcon: Icons.email,
                            label: 'Email',
                            controller: emailController,
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomTextField(
                            prefixIcon: Icons.password,
                            label: 'Password',
                            controller: passwordController,
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomTextField(
                            prefixIcon: Icons.phone,
                            label: 'Phone Number',
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: size.height * 0.04),

                          /// **Sign Up Button**
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
                               context.read<AuthBloc>().add(SignUpEvent(emailController.text, passwordController.text));
                              },
                              child: state is AuthLoading
                                      ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                              :Text(
                                "Sign Up",
                                style: GoogleFonts.lora(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                          /// **Sign In Navigation**
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
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
                                    TextSpan(text: "Already have an account? "),
                                    TextSpan(
                                      text: "Sign In",
                                      style: GoogleFonts.lora(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
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
