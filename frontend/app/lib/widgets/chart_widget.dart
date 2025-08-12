// import 'package:flutter/material.dart';

// class Chart extends StatelessWidget {
//   const Chart({super.key});

//   // Dummy transaction data for 12 months
//   static const List<double> depositsData = [
//     1500, 1800, 2200, 2800, 2400, 3200, 2900, 3500, 3100, 3800, 4200, 3900
//   ];
  
//   static const List<double> withdrawalsData = [
//     1200, 1400, 1600, 2100, 1800, 2400, 2200, 2800, 2500, 3000, 3200, 2900
//   ];
  
//   static const List<String> months = [
//     'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//     'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Chart container
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: Colors.grey.shade200),
//             ),
//             child: Column(
//               children: [
//                 // Chart area
//                 Expanded(
//                   child: CustomPaint(
//                     size: const Size(double.infinity, double.infinity),
//                     painter: TransactionChartPainter(),
//                   ),
//                 ),
                
//                 const SizedBox(height: 16),
                
//                 // Month labels
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: months.map((month) => Text(
//                     month,
//                     style: const TextStyle(
//                       fontSize: 10,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )).toList(),
//                 ),
//               ],
//             ),
//           ),
//         ),
        
//         // Chart legend
//         const SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 16,
//                   height: 3,
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Deposits',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 30),
//             Row(
//               children: [
//                 Container(
//                   width: 16,
//                   height: 3,
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Withdrawals',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class TransactionChartPainter extends CustomPainter {
//   // Dummy transaction data
//   static const List<double> depositsData = [
//     1500, 1800, 2200, 2800, 2400, 3200, 2900, 3500, 3100, 3800, 4200, 3900
//   ];
  
//   static const List<double> withdrawalsData = [
//     1200, 1400, 1600, 2100, 1800, 2400, 2200, 2800, 2500, 3000, 3200, 2900
//   ];

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke;

//     // Chart dimensions
//     final chartWidth = size.width - 40;
//     final chartHeight = size.height - 40;
//     final stepX = chartWidth / 11; // 12 points, 11 steps
//     const maxY = 5000.0;
    
//     // Draw grid lines
//     final gridPaint = Paint()
//       ..color = Colors.grey.shade300
//       ..strokeWidth = 0.5;
    
//     // Horizontal grid lines
//     for (int i = 0; i <= 5; i++) {
//       final y = 20 + (chartHeight * i / 5);
//       canvas.drawLine(
//         Offset(20, y),
//         Offset(size.width - 20, y),
//         gridPaint,
//       );
//     }
    
//     // Vertical grid lines
//     for (int i = 0; i <= 11; i++) {
//       final x = 20 + (stepX * i);
//       canvas.drawLine(
//         Offset(x, 20),
//         Offset(x, size.height - 20),
//         gridPaint,
//       );
//     }

//     // Draw deposits line (green)
//     paint.color = Colors.green;
//     final depositsPath = Path();
//     for (int i = 0; i < depositsData.length; i++) {
//       final x = 20 + (stepX * i);
//       final y = size.height - 20 - (depositsData[i] / maxY * chartHeight);
      
//       if (i == 0) {
//         depositsPath.moveTo(x, y);
//       } else {
//         depositsPath.lineTo(x, y);
//       }
      
//       // Draw dots
//       canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.green);
//       canvas.drawCircle(Offset(x, y), 4, Paint()
//         ..color = Colors.white
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2);
//     }
//     canvas.drawPath(depositsPath, paint);

//     // Draw withdrawals line (red)
//     paint.color = Colors.red;
//     final withdrawalsPath = Path();
//     for (int i = 0; i < withdrawalsData.length; i++) {
//       final x = 20 + (stepX * i);
//       final y = size.height - 20 - (withdrawalsData[i] / maxY * chartHeight);
      
//       if (i == 0) {
//         withdrawalsPath.moveTo(x, y);
//       } else {
//         withdrawalsPath.lineTo(x, y);
//       }
      
//       // Draw dots
//       canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.red);
//       canvas.drawCircle(Offset(x, y), 4, Paint()
//         ..color = Colors.white
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2);
//     }
//     canvas.drawPath(withdrawalsPath, paint);

//     // Draw Y-axis labels
//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//     );
    
//     for (int i = 0; i <= 5; i++) {
//       final value = (maxY * i / 5).toInt();
//       final y = size.height - 20 - (chartHeight * i / 5);
      
//       textPainter.text = TextSpan(
//         text: '\$${(value / 1000).toStringAsFixed(0)}K',
//         style: const TextStyle(
//           color: Colors.grey,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       );
//       textPainter.layout();
//       textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }


import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  // Dummy transaction data for 12 months
  static const List<double> depositsData = [
    1500, 1800, 2200, 2800, 2400, 3200, 2900, 3500, 3100, 3800, 4200, 3900
  ];

  static const List<double> withdrawalsData = [
    1200, 1400, 1600, 2100, 1800, 2400, 2200, 2800, 2500, 3000, 3200, 2900
  ];

  static const List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280, // Fixed height to fit chart + legend
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            // Chart area
            Expanded(
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: TransactionChartPainter(),
              ),
            ),

            const SizedBox(height: 16),

            // Month labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: months
                  .map(
                    (month) => Text(
                      month,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 16),

            // Chart legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [

                        const Text(
                      'Deposits',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
const SizedBox(width: 8),
                    Container(
                      width: 16,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    
                
                  ],
                ),
                const SizedBox(width: 60),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Withdrawals',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionChartPainter extends CustomPainter {
  // Dummy transaction data
  static const List<double> depositsData = [
    1500, 1800, 2200, 2800, 2400, 3200, 2900, 3500, 3100, 3800, 4200, 3900
  ];

  static const List<double> withdrawalsData = [
    1200, 1400, 1600, 2100, 1800, 2400, 2200, 2800, 2500, 3000, 3200, 2900
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Chart dimensions
    final chartWidth = size.width - 40;
    final chartHeight = size.height - 40;
    final stepX = chartWidth / 11; // 12 points, 11 steps
    const maxY = 5000.0;

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 0.5;

    // Horizontal grid lines
    for (int i = 0; i <= 5; i++) {
      final y = 20 + (chartHeight * i / 5);
      canvas.drawLine(
        Offset(20, y),
        Offset(size.width - 20, y),
        gridPaint,
      );
    }

    // Vertical grid lines
    for (int i = 0; i <= 11; i++) {
      final x = 20 + (stepX * i);
      canvas.drawLine(
        Offset(x, 20),
        Offset(x, size.height - 20),
        gridPaint,
      );
    }

    // Draw deposits line (green)
    paint.color = Colors.green;
    final depositsPath = Path();
    for (int i = 0; i < depositsData.length; i++) {
      final x = 20 + (stepX * i);
      final y = size.height - 20 - (depositsData[i] / maxY * chartHeight);

      if (i == 0) {
        depositsPath.moveTo(x, y);
      } else {
        depositsPath.lineTo(x, y);
      }

      // Draw dots
      canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.green);
      canvas.drawCircle(
          Offset(x, y),
          4,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
    canvas.drawPath(depositsPath, paint);

    // Draw withdrawals line (red)
    paint.color = Colors.red;
    final withdrawalsPath = Path();
    for (int i = 0; i < withdrawalsData.length; i++) {
      final x = 20 + (stepX * i);
      final y = size.height - 20 - (withdrawalsData[i] / maxY * chartHeight);

      if (i == 0) {
        withdrawalsPath.moveTo(x, y);
      } else {
        withdrawalsPath.lineTo(x, y);
      }

      // Draw dots
      canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.red);
      canvas.drawCircle(
          Offset(x, y),
          4,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
    canvas.drawPath(withdrawalsPath, paint);

    // Draw Y-axis labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i <= 5; i++) {
      final value = (maxY * i / 5).toInt();
      final y = size.height - 20 - (chartHeight * i / 5);

      textPainter.text = TextSpan(
        text: '\$${(value / 1000).toStringAsFixed(0)}K',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
