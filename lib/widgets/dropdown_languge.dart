import 'package:flutter/material.dart';
import '../utils/colors.dart';


const List<String> listLanguage = <String>['Vietnamese', 'English'];
class DropdownLanguage extends StatefulWidget {
  const DropdownLanguage({super.key});

  @override
  State<DropdownLanguage> createState() => _DropdownLanguageState();
}

class _DropdownLanguageState extends State<DropdownLanguage> {
  String dropdownValue = listLanguage.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text("ssdvsv"),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      style: const TextStyle(color: Colors.deepPurple),
      underline: SizedBox(),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: listLanguage.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(color: textColor),),
        );
      }).toList(),
    );
  }
}