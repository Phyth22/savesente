import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_in_screen.dart';
import 'terms_of_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPressed = false;
  bool isPasswordVisible = false;
  bool agreedToTerms = false;
  bool isLoading = false;

  // Store validation errors separately
  String? firstNameError;
  String? lastNameError;
  String? emailError;
  String? phoneNumberError;
  String? passwordError;

  // VALIDATIONS
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password cannot be empty.";
    if (value.length > 35) return "Password too long (max 35).";
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) return "Must contain a lowercase letter.";
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) return "Must contain an uppercase letter.";
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) return "Must contain a number.";
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return "Phone number cannot be empty.";
    final phoneRegExp = RegExp(r'^(\+256|0)\d{9}$');
    if (!phoneRegExp.hasMatch(value)) return "Invalid phone number format.";
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email cannot be empty.";
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) return "Invalid email format.";
    return null;
  }

  String? validateRequiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName cannot be empty.";
    }
    return null;
  }

  Future<void> _handleSignUp() async {
    if (!agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("You must agree to the Terms & Conditions to proceed."),
          backgroundColor: Colors.red,
          margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Clear previous errors
    setState(() {
      firstNameError = null;
      lastNameError = null;
      emailError = null;
      phoneNumberError = null;
      passwordError = null;
    });

    // Validate fields and store errors
    firstNameError = validateRequiredField(firstNameController.text, "First Name");
    lastNameError = validateRequiredField(lastNameController.text, "Last Name");
    emailError = validateEmail(emailController.text);
    phoneNumberError = validatePhoneNumber(phoneNumberController.text);
    passwordError = validatePassword(passwordController.text);

    // If there are validation errors, update state and return
    if (firstNameError != null || 
        lastNameError != null || 
        emailError != null || 
        phoneNumberError != null || 
        passwordError != null) {
      setState(() {});
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Your signup logic (API call, DB storage, etc.) goes here
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Account created successfully!"),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Text(
                      'Hey there!',
                      style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      'Please enter your profile details',
                      style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 35),

                  // First Name
                  _buildTextField(
                    "First Name",
                    firstNameController,
                    maxLength: 15,
                    error: firstNameError,
                    hintText: "Enter first name",
                  ),

                  // Last Name
                  _buildTextField(
                    "Last Name",
                    lastNameController,
                    maxLength: 25,
                    error: lastNameError,
                    hintText: "Enter last name",
                  ),

                  // Email
                  _buildTextField(
                    "Email",
                    emailController,
                    maxLength: 50,
                    error: emailError,
                    hintText: "eg savesente@gmail.com",
                    inputType: TextInputType.emailAddress,
                  ),

                  // Phone Number
                  _buildTextField(
                    "Phone Number",
                    phoneNumberController,
                    maxLength: 13,
                    error: phoneNumberError,
                    hintText: "eg +256771234567",
                    inputType: TextInputType.phone,
                  ),

                  // Password
                  _buildPasswordField(),

                  const SizedBox(height: 10),

                  // Terms & Conditions Checkbox
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: agreedToTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            agreedToTerms = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Terms()),
                            );

                            if (result == true) {
                              setState(() {
                                agreedToTerms = true;
                              });
                            }
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: GoogleFonts.raleway(fontSize: 16, color: Colors.black),
                              children: [
                                const TextSpan(text: "I agree to the "),
                                TextSpan(
                                  text: "Terms of Service",
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                              
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // // SIGN UP BUTTON
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: GestureDetector(
                  //     onTapDown: (_) => setState(() => isPressed = true),
                  //     onTapUp: (_) => setState(() => isPressed = false),
                  //     onTapCancel: () => setState(() => isPressed = false),
                  //     onTap: isLoading ? null : _handleSignUp,
                  //     child: AnimatedContainer(
                  //       duration: const Duration(milliseconds: 150),
                  //       decoration: BoxDecoration(
                  //         color: isPressed ? Colors.white : const Color(0xFF222222), // off-black default
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border.all(
                  //           color: isPressed ? Colors.black : Colors.transparent,
                  //           width: 1.5,
                  //         ),
                  //       ),
                  //       alignment: Alignment.center,
                  //       child: isLoading
                  //           ? const CircularProgressIndicator(
                  //               strokeWidth: 2,
                  //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  //             )
                  //           : Text(
                  //               'SIGN UP',
                  //               style: GoogleFonts.raleway(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w300,
                  //                 color: isPressed ? Colors.black : Colors.white,
                  //               ),
                  //             ),
                  //     ),
                  //   ),
                  // ),

                  // SIGN UP BUTTON
Center(
  child: SizedBox(
    width: 180, // same fixed width as LOGIN button
    height: 50,
    child: GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: isLoading ? null : _handleSignUp,
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
            ? const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                'SIGN UP',
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: isPressed ? Colors.black : Colors.white,
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
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.raleway(fontSize: 16, color: Colors.black),
                          children: const [
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Login Now",
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

  // FIELD STYLE USING CONTAINER
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLength = 100,
    TextInputType inputType = TextInputType.text,
    String? error,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Focus(
          child: Builder(
            builder: (context) {
              final hasFocus = Focus.of(context).hasFocus;
              
              return Container(
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
                  keyboardType: inputType,
                  maxLength: maxLength,
                  // Remove validator since we're handling validation manually
                  validator: (_) => null,
                  decoration: InputDecoration(
                    hintText: hintText,
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    hintStyle: TextStyle(color: Colors.grey[500]),
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
        const SizedBox(height: 10),
      ],
    );
  }

  // PASSWORD FIELD
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        Focus(
          child: Builder(
            builder: (context) {
              final hasFocus = Focus.of(context).hasFocus;
              
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: passwordError != null 
                        ? Colors.red 
                        : hasFocus 
                            ? Colors.black 
                            : Colors.grey[400]!,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  maxLength: 35,
                  // Remove validator since we're handling validation manually
                  validator: (_) => null,
                  decoration: InputDecoration(
                    hintText: "Include Uppercase, Lowercase & a Number",
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Error message displayed outside and below the input field
        if (passwordError != null) ...[
          const SizedBox(height: 6),
          Text(
            passwordError!,
            style: GoogleFonts.raleway(
              fontSize: 13,
              color: Colors.red[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        const SizedBox(height: 10),
      ],
    );
  }
}