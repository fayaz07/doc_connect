import 'package:doc_connect/data_models/author.dart';
import 'package:hive/hive.dart';

part 'forum.g.dart';

@HiveType(typeId: 5)
class ForumQuestion {
  @HiveField(1)
  String id;

  @HiveField(2)
  String authorId;

  @HiveField(3)
  String topic;

  @HiveField(4)
  String title;

  @HiveField(5)
  String question;

  @HiveField(6)
  List views;

  @HiveField(7)
  DateTime createdAt;

  @HiveField(8)
  bool solved;

  @HiveField(9)
  String solutionId;

  @HiveField(10)
  List upVotes;

  @HiveField(11)
  List downVotes;

  @HiveField(12)
  List<ForumMessage> messages;

  @HiveField(13)
  Author author;

  @HiveField(14)
  int noOfViews;

  @HiveField(15)
  int noOfUpVotes;

  @HiveField(16)
  int noOfDownVotes;

  ForumQuestion(
      {this.id,
      this.authorId,
      this.topic,
      this.title,
      this.question,
      this.views,
      this.createdAt,
      this.solved,
      this.solutionId,
      this.upVotes,
      this.downVotes,
      this.messages,
      this.author,
      this.noOfViews,
      this.noOfUpVotes,
      this.noOfDownVotes});

  factory ForumQuestion.fromJSON(var map) {
    return ForumQuestion(
      id: map['_id'],
      authorId: map['authorId'],
      author: map["author"] != null
          ? map["author"][0] != null
          ? Author.fromJSON(map["author"][0])
          : Author()
          : Author(),
      topic: map['topic'],
      title: map['title'],
      solutionId: map["solutionId"],
      question: map['question'],
      views: map['views'] ?? [],
      createdAt: DateTime.parse(map['createdAt']),
      solved: map['solved'],
      messages: map['messages'] ?? [],
      upVotes: map['upVotes'] ?? [],
      downVotes: map['downVotes'] ?? [],
      noOfViews: map['noOfViews'],
      noOfUpVotes: map['noOfUpVotes'],
      noOfDownVotes: map['noOfDownVotes'],
    );
  }

  static Map toJSON(ForumQuestion forumQuestion) {
    return {
      "_id": forumQuestion.id,
      "authorId": forumQuestion.authorId,
      "topic": forumQuestion.topic,
      "title": forumQuestion.title,
      "question": forumQuestion.question,
      "views": forumQuestion.views,
      "createdAt": forumQuestion.createdAt,
      "solved": forumQuestion.solved,
      "messages": forumQuestion.messages,
      "upVotes": forumQuestion.upVotes,
      "downVotes": forumQuestion.downVotes,
    };
  }

  static Map toJSONForNewQuestion(ForumQuestion forumQuestion) {
    return {
      "topic": forumQuestion.topic,
      "title": forumQuestion.title,
      "question": forumQuestion.question,
    };
  }

  static Map<String, ForumQuestion> parseAsMap(var jsonList) {
    Map<String, ForumQuestion> _forumQuestions = Map();
    if (jsonList == null) return _forumQuestions;
    for (var c in jsonList) {
      final q = ForumQuestion.fromJSON(c);
      _forumQuestions[q.id] = q;
    }
    return _forumQuestions;
  }

  @override
  String toString() {
    return 'Forum{ authorId: $authorId, topic: $topic, title: $title, question: $question, views: $views, askedOn: $createdAt, solved: $solved, messages: $messages}';
  }
}

@HiveType(typeId: 6)
class ForumMessage {
  String id;
  String forumId, authorId;
  String answer, tips;
  DateTime answeredOn;
  List upVotes, downVotes;
  Author author;

  ForumMessage({this.id,
    this.forumId,
    this.authorId,
    this.author,
    this.answer,
    this.tips,
    this.upVotes,
    this.downVotes,
    this.answeredOn});

  factory ForumMessage.fromJSON(var map) {
    return ForumMessage(
      id: map["_id"],
      forumId: map['forumId'],
      authorId: map['authorId'],
      author: Author.fromJSON(map['author'] != null
          ? map['author'][0] != null ? map['author'][0] : {}
          : {}),
      answer: map['answer'],
      tips: map['tips'],
      upVotes: map['upVotes'] ?? [],
      downVotes: map['downVotes'] ?? [],
      answeredOn: DateTime.parse(map['createdAt']),
    );
  }

  static ForumMessage selfFromJSON(var map) {
    return ForumMessage(
      id: map["_id"],
      forumId: map['forumId'],
      answer: map['answer'],
      tips: map['tips'],
      upVotes: map['upVotes'] ?? [],
      downVotes: map['downVotes'] ?? [],
      answeredOn: DateTime.parse(map['createdAt']),
    );
  }

  static Map<String, dynamic> toJSON(ForumMessage message) {
    return {
      "forumId": message.forumId,
      "authorId": message.authorId,
      "answer": message.answer,
      "tips": message.tips,
    };
  }

  static List<ForumMessage> getResponsesFromList(var jsonList) {
    List<ForumMessage> forumResponses = [];
    for (var d in jsonList) {
      forumResponses.add(ForumMessage.fromJSON(d));
    }
    return forumResponses;
  }

  @override
  String toString() {
    return 'ForumMessage{forumId: $forumId, authorId: $authorId, answer: $answer, tips: $tips, answeredOn: $answeredOn, upVotes: $upVotes, downVotes: $downVotes, author: $author}';
  }
}
