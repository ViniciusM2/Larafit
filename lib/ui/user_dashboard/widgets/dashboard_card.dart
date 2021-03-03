import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard({
    this.title = '',
    this.subtitle = '',
    this.imageUrl,
  });
  final String title;
  final String subtitle;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: imageUrl != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (imageUrl != null)
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (
                          context,
                          child,
                          loadingProgress,
                        ) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    this.title,
                    style: Get.textTheme.bodyText2
                        .copyWith(color: Colors.grey[700]),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    this.subtitle,
                    style: Get.textTheme.headline5,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
