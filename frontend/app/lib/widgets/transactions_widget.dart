import 'package:flutter/material.dart';

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 50, right: 60, top: 30, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            
            // Make transaction items scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTransactionItem('- 100,000 ugx', 'savings wallet'),
                    _buildTransactionItem('+ 500,000 ugx', 'savings wallet'),
                    _buildTransactionItem('+ 700,000 ugx', 'savings wallet'),
                    _buildTransactionItem('- 650,000 ugx', 'savings wallet'),
                    _buildTransactionItem('+ 700,000 ugx', 'savings wallet'),
                    _buildTransactionItem('+ 2,000,000 ugx', 'savings wallet'),
                    _buildTransactionItem('- 300,000 ugx', 'savings wallet'),
                    _buildTransactionItem('+ 1,500,000 ugx', 'savings wallet'),
                    _buildTransactionItem('- 250,000 ugx', 'savings wallet'),
                    _buildTransactionItem('+ 800,000 ugx', 'savings wallet'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTransactionItem(String amount, String type) {
    bool isPositive = amount.startsWith('+');
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isPositive ? Colors.green : Colors.red,
            ),
          ),
          Text(
            type,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}