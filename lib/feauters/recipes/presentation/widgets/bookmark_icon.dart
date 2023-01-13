
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 66, height: 23,
      child: Stack (
        children:[ ClipPath(
          clipper: MyCustomCliper(),
          child: Container(width: 66, height: 23,
          color: Color(0xFF2ECC71),),
        ),
        Align ( alignment: Alignment.centerRight, child: Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Text('1', style: TextStyle(color: Colors.white),),
        ))
        ]
      ),
    );
  }
}
class MyCustomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path =Path()
    ..lineTo(size.width,0)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..lineTo(size.height, size.height/2 ) 
    ..close()
;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }

}