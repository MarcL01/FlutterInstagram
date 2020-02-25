import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_instagram/dummydata.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        "Instagram",
        style: TextStyle(
          fontFamily: "Billabong",
          fontSize: 40.0,
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.camera_alt,
          color: Colors.black,
        ),
        onPressed: onOpenCamera,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.send,
            color: Colors.black,
          ),
          onPressed: onOpenMessages,
        ),
      ],
    );
  }

  Widget _buildStoriesBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            "Stories",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,
            onPressed: onClickWatchAll,
            child: Text("Watch all"),
          ),
        ],
      ),
    );
  }

  Widget _buildStories() {
    return SizedBox(
      height: 90.0,
      child: ListView.builder(
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          StoryDescriber storyData =
              DummyData.stories[index]; // Get some fake story data
          return _buildStory(storyData);
        },
        itemCount: DummyData.stories.length,
      ),
    );
  }

  Widget _buildStory(StoryDescriber storyDescriber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 60.0,
            width: 60.0,
            decoration: ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(
                  color: Color(0xFFDE5F50),
                  width: 2,
                ),
              ),
              image: DecorationImage(
                image: NetworkImage(storyDescriber.pfp),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(storyDescriber.name),
        ],
      ),
    );
  }

  void onOpenCamera() {
    print("Clicked open camera!");
  }

  void onOpenMessages() {
    print("Clicked open messages!");
  }

  void onClickWatchAll() {
    print("Clicked watch all!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () {
          Completer completer = Completer();
          Timer(Duration(seconds: 2), () {
            completer.complete();
          });
          return completer.future;
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildStoriesBar();
            } else if (index == 1) {
              return _buildStories();
            }
            Post post = DummyData.posts[index - 2];
            return PostWidget(
              postData: post,
            );
          },
          itemCount: DummyData.posts.length + 2,
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  Post postData;
  int commentCount = 0;

  PostWidget({Key key, this.postData}) : super(key: key); // Constructor

  Widget _buildHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            minRadius: 15,
            backgroundImage: NetworkImage(postData.pfp),
          ),
        ),
        Text(postData.username),
        Spacer(),
        IconButton(icon: Icon(Icons.more_horiz), onPressed: onClickMore)
      ],
    );
  }

  Widget _buildButtonBar() {
    return Row(
      children: <Widget>[
        IconButton(icon: Icon(Icons.favorite_border), onPressed: onClickLike),
        IconButton(
            icon: Icon(Icons.chat_bubble_outline), onPressed: onClickComments),
        IconButton(icon: Icon(Icons.send), onPressed: onClickShare),
        Spacer(),
        IconButton(icon: Icon(Icons.bookmark_border), onPressed: onClickSave),
      ],
    );
  }

  Widget _buildLikes() {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 8.0,
      ),
      child: Text(
        NumberFormat.compact().format(postData.likes) + " likes",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNameDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: postData.username,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            WidgetSpan(
              child: SizedBox(
                width: 5,
              ),
            ),
            TextSpan(
              text: postData.description,
            ),
          ],
        ),
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildTimeago() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: Text(
        postData.timeago.toUpperCase(),
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildComments() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: postData.comments.take(3).map((comment) {
          return Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: comment.username,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                WidgetSpan(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                TextSpan(
                  text: comment.comment,
                ),
              ],
            ),
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }).toList(),
      ),
    );
  }

  void onClickMore() {
    print("Clicked more!");
  }

  void onClickLike() {
    print("Clicked like!");
  }

  void onClickComments() {
    print("Clicked comments!");
  }

  void onClickShare() {
    print("Clicked share!");
  }

  void onClickSave() {
    print("Clicked save!");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          Image.network(postData.image),
          _buildButtonBar(),
          _buildLikes(),
          _buildNameDescription(),
          _buildTimeago(),
          _buildComments(),
        ],
      ),
    );
  }
}