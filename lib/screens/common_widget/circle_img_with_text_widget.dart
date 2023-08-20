import 'package:flutter/material.dart';

typedef MyCallback = void Function();
class CircleImageWithTextUnder extends StatelessWidget {
  const CircleImageWithTextUnder({
    super.key,this.haveStory=true,required this.size, required this.urlImg, required this.callback, required this.text,
  });
  final double size;
  final String urlImg;
  final MyCallback callback;
  final String text;
  final bool haveStory ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: haveStory,
              child: Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color.fromRGBO(251, 170, 71, 1),Color.fromRGBO(217, 26, 70, 1),Color.fromRGBO(166, 15, 147, 1)],
                    )
                ),
              ),
            ),
            Container(
              width: size-5,
              height: size-5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: size-10,
              height: size-10,
              child: CircleAvatar(
                backgroundImage: AssetImage(urlImg),
              ),
            ),
          ],
        ),
        SizedBox(height: 4,),
        Visibility(
          visible: text!="",
          child: Text(text,
            style: TextStyle(
                fontSize: size/6,
                fontWeight: FontWeight.w600),),
        ),
      ],
    );
  }
}