import 'dart:convert';

import 'package:flutter/material.dart';

class DummyData {
  static List<StoryDescriber> stories = [
    StoryDescriber(
      pfp: "https://loremflickr.com/320/240/profile?lock=101",
      name: "gaston",
    ),
    StoryDescriber(
      pfp: "https://loremflickr.com/320/240/profile?lock=102",
      name: "shannon",
    ),
    StoryDescriber(
      pfp: "https://loremflickr.com/320/240/profile?lock=103",
      name: "keenan",
    ),
    StoryDescriber(
      pfp: "https://loremflickr.com/320/240/profile?lock=104",
      name: "ebba",
    ),
    StoryDescriber(
      pfp: "https://loremflickr.com/320/240/profile?lock=105",
      name: "karley",
    ),
    StoryDescriber(
      pfp: "https://loremflickr.com/320/240/profile?lock=106",
      name: "helena",
    ),
    StoryDescriber(
      pfp: "https://loremflickr.com/320/240/profile?lock=107",
      name: "lilla",
    ),
    StoryDescriber(
      pfp: "https://loremflickr.com/320/240/profile?lock=108",
      name: "zita",
    ),
  ];
  static List<Post> posts = [
    Post(
        pfp: "https://loremflickr.com/320/240/profile?lock=1",
        username: "jessica.runolfsson",
        image: "http://loremflickr.com/640/480/cats?lock=2",
        likes: 97598,
        description: "Illo alias repudiandae qui dolor minima exercitationem.",
        timeago: "3 hours ago",
        comments: [
          Comment(username: "ilene", comment: "in expedita est ea"),
          Comment(
              username: "gabriella",
              comment:
                  "Fugiat sapiente quo id non harum repudiandae iure quas fugit."),
          Comment(username: "edmond", comment: "qui sed nemo"),
        ]),
    Post(
        pfp: "https://loremflickr.com/320/240/profile?lock=3",
        username: "gardner.hickle",
        image: "http://loremflickr.com/640/480/cats?lock=4",
        likes: 75476,
        description:
            "Possimus veniam eaque cum rem debitis tenetur illo. Cumque ut qui corporis autem repellat sunt deserunt beatae. Itaque rem eum rerum hic laboriosam. Debitis voluptate ipsa maiores inventore ex quia velit in. Quod dolore quis voluptas quae aperiam.",
        timeago: "4 hours ago",
        comments: [
          Comment(
            username: "sharon",
            comment:
                "Eum modi dicta consectetur omnis alias quia. Consequatur vel sed expedita. Ipsum voluptas nostrum saepe iste odio perferendis cumque magnam nisi. Ut sit impedit voluptas modi. Voluptatem ducimus nobis aliquid ab saepe vel adipisci asperiores vel. Animi et est reiciendis consequatur unde aut repellendus sunt.",
          ),
          Comment(
            username: "carson",
            comment: "ea facilis fugit",
          ),
          Comment(
            username: "teagan",
            comment:
                "Libero sed corporis commodi id. Accusantium fuga accusamus consequatur praesentium. Voluptate sequi dolorem illum aut sed dolor labore. Velit quia dicta sed minus eius architecto. Est ducimus facilis aut suscipit similique eos quo omnis autem.",
          ),
        ]),
  ];

  static Map<DateTime, List<Activity>> activities = {
    DateTime(2020, 1, 30): [
      Activity(
        type: ActivityType.COMMENTED,
        pfp: "https://s3.amazonaws.com/uifaces/faces/twitter/amayvs/128.jpg",
        username: "katelynn",
        timeago: "2w",
        postThumbnail: "http://loremflickr.com/640/480/food",
        extraData: "@your.name.here",
      ),
      Activity(
        type: ActivityType.STARTED_FOLLOWING,
        pfp: "https://s3.amazonaws.com/uifaces/faces/twitter/lvovenok/128.jpg",
        username: "joelle",
        timeago: "2w",
      ),
      Activity(
        type: ActivityType.MENTIONED_COMMENT,
        pfp: "https://s3.amazonaws.com/uifaces/faces/twitter/scrapdnb/128.jpg",
        username: "maud",
        timeago: "2w",
        postThumbnail: "http://loremflickr.com/640/480/food",
        extraData: "@your.name.here",
      ),
    ]
  };
}

enum ActivityType {
  MENTIONED_COMMENT, // mentioned in a comment
  STARTED_FOLLOWING, // started following you
  LIKED_POST, // liked your post
  COMMENTED, // commented on your post
  TAGGED, // tagged you in a post
}

class Activity {
  final ActivityType type;
  final String pfp;
  final String username;
  final String timeago;
  final String postThumbnail;
  final String extraData;

  const Activity({
    this.type,
    this.pfp,
    this.username,
    this.timeago,
    this.postThumbnail,
    this.extraData,
  });
}

class StoryDescriber {
  String pfp;
  String name;
  List<Story> stories;
  StoryDescriber({
    this.pfp,
    this.name,
    this.stories,
  });

  StoryDescriber copyWith({
    String pfp,
    String name,
    List<Story> stories,
  }) {
    return StoryDescriber(
      pfp: pfp ?? this.pfp,
      name: name ?? this.name,
      stories: stories ?? this.stories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pfp': pfp,
      'name': name,
      'stories': List<dynamic>.from(stories.map((x) => x.toMap())),
    };
  }

  static StoryDescriber fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StoryDescriber(
      pfp: map['pfp'],
      name: map['name'],
      stories: List<Story>.from(map['stories']?.map((x) => Story.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static StoryDescriber fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'StoryDescriber pfp: $pfp, name: $name, stories: $stories';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StoryDescriber &&
        o.pfp == pfp &&
        o.name == name &&
        o.stories == stories;
  }

  @override
  int get hashCode => pfp.hashCode ^ name.hashCode ^ stories.hashCode;
}

class Story {
  String image;
  Story({
    this.image,
  });

  Story copyWith({
    String image,
  }) {
    return Story(
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }

  static Story fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Story(
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  static Story fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Story image: $image';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Story && o.image == image;
  }

  @override
  int get hashCode => image.hashCode;
}

class Post {
  String pfp;
  String username;
  String image;
  int likes;
  String description;
  String timeago;
  List<Comment> comments;
  Post({
    this.pfp,
    this.username,
    this.image,
    this.likes,
    this.description,
    this.timeago,
    this.comments,
  });

  Post copyWith({
    String pfp,
    String username,
    String image,
    int likes,
    String description,
    String timeago,
    List<Comment> comments,
  }) {
    return Post(
      pfp: pfp ?? this.pfp,
      username: username ?? this.username,
      image: image ?? this.image,
      likes: likes ?? this.likes,
      description: description ?? this.description,
      timeago: timeago ?? this.timeago,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pfp': pfp,
      'username': username,
      'image': image,
      'likes': likes,
      'description': description,
      'timeago': timeago,
      'comments': List<dynamic>.from(comments.map((x) => x.toMap())),
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      pfp: map['pfp'],
      username: map['username'],
      image: map['image'],
      likes: map['likes'],
      description: map['description'],
      timeago: map['timeago'],
      comments:
          List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Post fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post pfp: $pfp, username: $username, image: $image, likes: $likes, description: $description, timeago: $timeago, comments: $comments';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Post &&
        o.pfp == pfp &&
        o.username == username &&
        o.image == image &&
        o.likes == likes &&
        o.description == description &&
        o.timeago == timeago &&
        o.comments == comments;
  }

  @override
  int get hashCode {
    return pfp.hashCode ^
        username.hashCode ^
        image.hashCode ^
        likes.hashCode ^
        description.hashCode ^
        timeago.hashCode ^
        comments.hashCode;
  }
}

class Comment {
  String username;
  String comment;
  Comment({
    this.username,
    this.comment,
  });

  Comment copyWith({
    String username,
    String comment,
  }) {
    return Comment(
      username: username ?? this.username,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'comment': comment,
    };
  }

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      username: map['username'],
      comment: map['comment'],
    );
  }

  String toJson() => json.encode(toMap());

  static Comment fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Comment username: $username, comment: $comment';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Comment && o.username == username && o.comment == comment;
  }

  @override
  int get hashCode => username.hashCode ^ comment.hashCode;
}
