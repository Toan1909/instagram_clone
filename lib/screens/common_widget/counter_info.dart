import 'package:flutter/material.dart';
class CounterInfoWidget extends StatelessWidget {
  const CounterInfoWidget({
    super.key, required this.quantity, required this.name,
  });
  final int? quantity;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Text(quantity.toString(),style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 22)),
          const SizedBox(height: 2,),
          InkWell(
            onTap: (){},
            child: Text(name,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),
          ),
        ],
      ),
    );
  }
}