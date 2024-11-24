import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 5.0),
                  child: Icon(
                    icon,
                    size: 25,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.black54,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black45,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
