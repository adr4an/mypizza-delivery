import 'package:flutter/material.dart';

class QuantityController extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityController({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // The main pill-shaped border
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2), // Subtle border color
          width: 1.2,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // DECREMENT BUTTON
            _buildButton(
              icon: Icons.remove,
              onTap: onDecrement,
            ),
            
            // VERTICAL DIVIDER
            VerticalDivider(
              color: Colors.grey.withValues(alpha: 0.2),
              thickness: 1.2,
              width: 1,
            ),

            // QUANTITY TEXT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            // VERTICAL DIVIDER
            VerticalDivider(
              color: Colors.grey.withValues(alpha: 0.2),
              thickness: 1.2,
              width: 1,
            ),

            // INCREMENT BUTTON
            _buildButton(
              icon: Icons.add,
              onTap: onIncrement,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Icon(
          icon,
          size: 18,
          color: Colors.black54,
        ),
      ),
    );
  }
}