import 'package:flutter/material.dart';

class NewFeedScreen extends StatelessWidget{
  NewFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width*0.3,
        leading: Container(
          margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
          child: Image.asset(
            "assets/logo.png",
            width: MediaQuery.of(context).size.width,
          ),
        ),
        actions: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: const InkWell(
                child: Icon(Icons.live_tv_outlined),
              )),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: const InkWell(
                child: Icon(Icons.send_outlined),
              )),
        ],
      ),
      body: Text("data"),
    );
  }

}