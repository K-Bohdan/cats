import 'package:flutter/material.dart';

class HistoryButton extends StatelessWidget {
  const HistoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/history'),
        child: Row(
          children: [
            Text(
              'Fact History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Icon(Icons.history, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
