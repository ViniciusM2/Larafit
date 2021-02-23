import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:larafit/ui/user_dashboard/cards/my_weight.dart';

class UserDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sua saúde'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: StaggeredGridView.count(
          staggeredTiles: [
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 1),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 1),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 1),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 1),
          ],
          crossAxisCount: 4,
          children: [
            MyWeight(),
            MyWeight(),
            MyWeight(),
            MyWeight(),
            MyWeight(),
            MyWeight(),
            MyWeight(),
            MyWeight(),
          ],
        ),
      ),
    );
  }
}
