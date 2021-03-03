import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AtitudeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Nome da Atitude',
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Duração',
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
