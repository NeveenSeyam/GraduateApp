import 'package:flutter/material.dart';
import '../screen/form_screen.dart' as Form;

class DropDwon extends StatefulWidget {
  const DropDwon({Key? key}) : super(key: key);

  @override
  _DropDwonState createState() => _DropDwonState();
}

class _DropDwonState extends State<DropDwon> {
  String dropdownButton = "Wallet";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 15),
        child: DropdownButton<String>(
          underline: const SizedBox(),
          isExpanded: true,
          focusColor: Colors.white,
          value: dropdownButton,
          //elevation: 5,
          style: const TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: <String>[
            'Wallet',
            'Wallet2',
            'Wallet3',
            'Wallet4',
            'Wallet5',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: const Text(
            "Please choose a langauage",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onChanged: (String? value) {
            setState(() {
              dropdownButton = value!;
            });
          },
        ),
      ),
    );
  }
}
