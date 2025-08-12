

// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_drawing/path_drawing.dart';
import 'access_screen.dart';

class AnimatedPathPainter extends CustomPainter {
  final double progress;
  AnimatedPathPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Combine your SVG paths: main rectangle, line, and circle
    final paths = [
      // Rectangle path
      "M18.94,151.21H686a110,110,0,0,1,110,110v287a110,110,0,0,1-110,110H111a110,110,0,0,1-110-110V169.15A17.94,17.94,0,0,1,18.94,151.21Z",
      // Horizontal line
      "M1.5 256.71 L792.5 259.71",
      // Circle
      "M646.5,454.21a66.5,66.5 0 1,0 0,133a66.5,66.5 0 1,0 0,-133"
    ];


    // Draw each path with scaling and progress
    for (final data in paths) {
      final path = parseSvgPathData(data);

      // Scale to fit size (130x130 scaled from original 797x659.21)
      final matrix4 = Matrix4.identity();
      matrix4.scale(size.width / 797, size.height / 659.21);
      final scaledPath = path.transform(matrix4.storage);

      // Animate progressively
      final metrics = scaledPath.computeMetrics().toList();
      for (final metric in metrics) {
        final extract = metric.extractPath(0, metric.length * progress);
        canvas.drawPath(extract, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Access()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF403c3c),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated SVG drawing
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: AnimatedPathPainter(_controller.value),
                    size: const Size(160, 130),
                  );
                },
              ),
              const SizedBox(height: 30),

              // Single line text
              Text(
                'SAVE SENTE',
                style: GoogleFonts.inter(
                  fontSize: 55,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: Splash(),
  ));
}
