import 'package:flutter/material.dart';

class ProfileGrid extends StatelessWidget {
  // Danh sách các URL hình ảnh
  final List<String> imageUrls = [
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    "assets/avt_default.png",
    // Thêm các URL hình ảnh khác vào đây
  ];

  @override
  Widget build(BuildContext context) {
    // Số cột trong lưới
    final int columnCount = 3;

    return GridView.builder(
      // Số lượng hình ảnh
      itemCount: imageUrls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        crossAxisSpacing: 2, // Khoảng cách giữa các cột
        mainAxisSpacing: 2, // Khoảng cách giữa các hàng
      ),
      itemBuilder: (context, index) {
        return Image.asset(
          imageUrls[index],
          fit: BoxFit.cover,
          width: 125,
          height: 125,
        );
      },
    );
  }
}
