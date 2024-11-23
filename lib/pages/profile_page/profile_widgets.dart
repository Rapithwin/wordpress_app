import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {},
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
                Text(
                  text,
                  style: textTheme.titleMedium?.copyWith(
                      color: Colors.black54,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
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
