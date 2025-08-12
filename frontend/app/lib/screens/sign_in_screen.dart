// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_up_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPressed = false;
  bool isLoading = false;
  String errorMessage = "";
  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  // Store validation errors separately
  String? emailError;
  String? passwordError;

  // Validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email cannot be empty.";
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) return "Invalid email format.";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password cannot be empty.";
    if (value.length > 35) return "Password too long (max 35).";
    return null;
  }

  Future<void> _signIn() async {
    // Clear previous errors
    setState(() {
      emailError = null;
      passwordError = null;
    });

    // Validate fields and store errors
    emailError = validateEmail(emailController.text);
    passwordError = validatePassword(passwordController.text);

    // If there are validation errors, update state and return
    if (emailError != null || passwordError != null) {
      setState(() {});
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      // Simulate API request
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      setState(() {
        errorMessage = "Login failed. Please try again.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Text(
                      'Enter your email and',
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.9),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      'password to login',
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.9),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  // Email Field
                  _buildTextField(
                    label: "Email",
                    controller: emailController,
                    hint: "Enter valid email",
                    error: emailError,
                  ),

                  // Password Field
                  _buildTextField(
                    label: "Password",
                    controller: passwordController,
                    hint: "Sshhh!",
                    isPassword: true,
                    error: passwordError,
                  ),

                  if (errorMessage.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        errorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 30),

                  // // LOGIN BUTTON
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: GestureDetector(
                  //     onTapDown: (_) => setState(() => isPressed = true),
                  //     onTapUp: (_) => setState(() => isPressed = false),
                  //     onTapCancel: () => setState(() => isPressed = false),
                  //     onTap: isLoading ? null : _signIn,
                  //     child: AnimatedContainer(
                  //       duration: const Duration(milliseconds: 150),
                  //       decoration: BoxDecoration(
                  //         color: isPressed ? Colors.white : const Color(0xFF403c3c), // off-black default
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border.all(
                  //           color: isPressed ? const Color(0xFF403c3c) : Colors.transparent,  
                  //           width: 1.5,
                  //         ),
                  //       ),

                  //       alignment: Alignment.center,
                  //       child: isLoading
                  //           ? const DottedLoader()
                  //           : Text(
                  //               "LOGIN",
                  //               style: GoogleFonts.raleway(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w300,
                  //                 color: isPressed ? const Color(0xFF403c3c) : Colors.white,
                  //               ),
                  //             ),
                  //     ),
                  //   ),
                  // ),

                  // LOGIN BUTTON
Center(
  child: SizedBox(
    width: 150, // adjust this value to control button width
    height: 50,
    child: GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: isLoading ? null : _signIn,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isPressed ? Colors.white : const Color(0xFF403c3c),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isPressed ? const Color(0xFF403c3c) : Colors.transparent,
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const DottedLoader()
            : Text(
                "LOGIN",
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: isPressed ? const Color(0xFF403c3c) : Colors.white,
                ),
              ),
      ),
    ),
  ),
),


                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: const [
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: "Register Now",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
    String? error,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 8),
          Focus(
            child: Builder(
              builder: (context) {
                final hasFocus = Focus.of(context).hasFocus;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: error != null 
                          ? Colors.red 
                          : hasFocus 
                              ? Colors.black 
                              : Colors.grey[400]!,
                      width: 1.3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: controller,
                    obscureText: isPassword && !isPasswordVisible,
                    // Remove validator since we're handling validation manually
                    validator: (_) => null,
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18,
                      ),
                      suffixIcon: isPassword
                          ? IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          // Error message displayed outside and below the input field
          if (error != null) ...[
            const SizedBox(height: 6),
            Text(
              error,
              style: GoogleFonts.raleway(
                fontSize: 13,
                color: Colors.red[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

// Custom Dotted Loader
class DottedLoader extends StatefulWidget {
  const DottedLoader({super.key});

  @override
  _DottedLoaderState createState() => _DottedLoaderState();
}

class _DottedLoaderState extends State<DottedLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            double opacity = _animation.value;
            if (index == 1) opacity = 1 - opacity;
            return Opacity(
              opacity: opacity,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Dot(),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  
    @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
