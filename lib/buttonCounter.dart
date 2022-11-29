import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonCounterCustom extends StatefulWidget {
  ButtonCounterCustom(
      {Key? key, required this.startCounter, required this.currentCounter})
      : super(key: key);

  final int startCounter;
  ValueSetter<int> currentCounter;
  @override
  State<ButtonCounterCustom> createState() => _ButtonCounterCustomState();
}

class _ButtonCounterCustomState extends State<ButtonCounterCustom> {
  int totalBarang = 0;
  @override
  void initState() {
    super.initState();
    totalBarang = widget.startCounter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        (totalBarang > 1)
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    if (totalBarang > 1) {
                      totalBarang = totalBarang - 1;
                      widget.currentCounter(totalBarang);
                    }
                  });
                },
                child: Icon(Icons.remove, color: Colors.red[700]),
              )
            : Container(child: Icon(Icons.remove, color: Colors.grey)),
        Text(totalBarang.toString()),
        GestureDetector(
          onTap: () {
            setState(() {
              totalBarang = totalBarang + 1;
              widget.currentCounter(totalBarang);
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.red[700],
          ),
        ),
      ]),
    );
  }
}
