import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Access extends StatefulWidget {
  const Access({super.key});

  @override
  State createState() => _AccessState();
}

class _AccessState extends State<Access> with TickerProviderStateMixin {
  late AnimationController _ssscreenController;
  late Animation<Offset> _ssscreenOffsetAnimation;
  late Animation<double> _ssscreenFadeAnimation;

  late AnimationController _tttscreenController;
  late Animation<Offset> _tttscreenOffsetAnimation;
  late Animation<double> _tttscreenFadeAnimation;

  @override
  void initState() {
    super.initState();

    _ssscreenController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _ssscreenOffsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _ssscreenController, curve: Curves.easeOut),
    );
    _ssscreenFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ssscreenController, curve: Curves.easeIn),
    );

    _tttscreenController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _tttscreenOffsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _tttscreenController, curve: Curves.easeOut),
    );
    _tttscreenFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _tttscreenController, curve: Curves.easeIn),
    );

    _ssscreenController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _tttscreenController.forward();
    });
  }

  @override
  void dispose() {
    _ssscreenController.dispose();
    _tttscreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF403c3c),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SVG Icon
                SvgPicture.asset(
                  'assets/icon_whitey.svg',
                  height: 130,
                  color: Colors.white, // ensures visible
                ),
                const SizedBox(height: 20),
                
                // SAVE SENTE text
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SlideTransition(
                      position: _ssscreenOffsetAnimation,
                      child: FadeTransition(
                        opacity: _ssscreenFadeAnimation,
                        child: Text(
                          'SAVE',
                          style: GoogleFonts.inter(
                            fontSize: 55,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                    SlideTransition(
                      position: _tttscreenOffsetAnimation,
                      child: FadeTransition(
                        opacity: _tttscreenFadeAnimation,
                        child: Text(
                          'SENTE',
                          style: GoogleFonts.inter(
                            fontSize: 55,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                
                // Buttons
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      _buildButton('LOGIN', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignIn()),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildButton('SIGN UP', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUp()),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onTap) {
    double scale = 1.0;

    return StatefulBuilder(
      builder: (context, setButtonState) {
        return GestureDetector(
          onTapDown: (_) => setButtonState(() => scale = 0.9),
          onTapUp: (_) => setButtonState(() => scale = 1.0),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Access(),
  ));
}