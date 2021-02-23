import 'package:flutter/material.dart';

class MyWeight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
            // backgroundImage: NetworkImage(
            //     "https://avatars.githubusercontent.com/u/61030658?s=460&u=d20e8090a747c89e057faf767bc9f0a90d0d2e11&v=4"),
            ),
        title: Text('60 kg'),
        subtitle: Text('90 kg'),
      ),
    );
  }
}
