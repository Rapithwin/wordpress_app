import 'package:flutter/material.dart';

class AddQuantity extends StatefulWidget {
  const AddQuantity(
      {super.key,
      required this.minNumber,
      required this.maxNumber,
      required this.iconSize,
      required this.value,
      required this.valueChanged});
  final int minNumber;
  final int maxNumber;
  final double iconSize;
  final int value;
  final ValueChanged valueChanged;

  @override
  State<AddQuantity> createState() => _AddQuantityState();
}

class _AddQuantityState extends State<AddQuantity> {
  late int value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            setState(
              () {
                value =
                    value == widget.minNumber ? widget.minNumber : value -= 1;
                widget.valueChanged(value);
              },
            );
          },
          splashRadius: 10,
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: widget.iconSize,
          child: Text(
            value.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(
              () {
                value =
                    value == widget.maxNumber ? widget.maxNumber : value += 1;
                widget.valueChanged(value);
              },
            );
          },
          splashRadius: 10,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
