class Author {
  String gender, speciality, profession;
  int age;
  bool isDoctor;
  String firstName, lastName;

  Author(
      {this.gender,
      this.firstName,
      this.lastName,
      this.speciality,
      this.profession,
      this.age,
      this.isDoctor});

  factory Author.fromJSON(var map) {
    return map == null
        ? Author()
        : Author(
            firstName: map["first_name"],
            lastName: map["last_name"],
            age: int.parse(map["age"].toString()) ?? 0,
            isDoctor: map["is_doctor"] ?? false,
            gender: map["gender"],
            speciality: map["speciality"],
            profession: map["profession"],
          );
  }

  @override
  String toString() {
    return 'Author{gender: $gender, speciality: $speciality, profession: $profession, age: $age, isDoctor: $isDoctor, firstName: $firstName, lastName: $lastName}';
  }
}

class ForumQuestion {
  String id, authorId, topic, title, question;
  List views;
  DateTime askedOn;
  bool solved;
  String solutionId;
  List upVotes, downVotes;
  List<ForumMessage> messages;
  Author author;
  int noOfViews, noOfUpVotes, noOfDownVotes;

  ForumQuestion(
      {this.id,
      this.authorId,
      this.topic,
      this.title,
      this.question,
      this.views,
      this.askedOn,
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
      askedOn: DateTime.parse(map['askedOn']),
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
      "askedOn": forumQuestion.askedOn,
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
    for (var c in jsonList) {
      final q = ForumQuestion.fromJSON(c);
      _forumQuestions[q.id] = q;
    }
    return _forumQuestions;
  }

  @override
  String toString() {
    return 'Forum{ authorId: $authorId, topic: $topic, title: $title, question: $question, views: $views, askedOn: $askedOn, solved: $solved, messages: $messages}';
  }
}

class ForumMessage {
  String id;
  String forumId, authorId;
  String answer, tips;
  DateTime answeredOn;
  List upVotes, downVotes;
  Author author;

  ForumMessage(
      {this.id,
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
      answeredOn: DateTime.parse(map['answeredOn']),
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
      answeredOn: DateTime.parse(map['answeredOn']),
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
