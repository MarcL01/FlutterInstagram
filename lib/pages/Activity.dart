import 'package:flutter/material.dart';
import 'package:flutter_instagram/dummydata.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actvity"),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        MapEntry activityEntry = DummyData.activities.entries.elementAt(index);
        return Column(
          children: activityEntry.value.map((a) => ActivityTile(activity: a,)).toList(),
        );
      },
      itemCount: DummyData.activities.length,),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final Activity activity;
  ActivityTile({Key key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(activity.type.toString());
  }

  

}
