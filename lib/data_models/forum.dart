class ForumQuestion {
  String id, authorId, topic, title, question;
  List views;
  DateTime askedOn;
  bool solved;
  List upVotes, downVotes;
  List<ForumMessage> messages;

  ForumQuestion(
      {this.id,
      this.authorId,
      this.topic,
      this.title,
      this.question,
      this.views,
      this.askedOn,
      this.solved,
      this.messages,
      this.upVotes,
      this.downVotes});

  factory ForumQuestion.fromJSON(var map) {
    return ForumQuestion(
      id: map['_id'],
      authorId: map['authorId'],
      topic: map['topic'],
      title: map['title'],
      question: map['question'],
      views: map['views'] ?? [],
      askedOn: DateTime.parse(map['askedOn']),
      solved: map['solved'],
      messages: map['messages'] ?? [],
      upVotes: map['upVotes'] ?? [],
      downVotes: map['downVotes'] ?? [],
    );
  }

  static Map toJSON(ForumQuestion forum) {
    return {
      "_id": forum.id,
      "authorId": forum.authorId,
      "topic": forum.topic,
      "title": forum.title,
      "question": forum.question,
      "views": forum.views,
      "askedOn": forum.askedOn,
      "solved": forum.solved,
      "messages": forum.messages,
      "upVotes": forum.upVotes,
      "downVotes": forum.downVotes,
    };
  }

  @override
  String toString() {
    return 'Forum{ authorId: $authorId, topic: $topic, title: $title, question: $question, views: $views, askedOn: $askedOn, solved: $solved, messages: $messages}';
  }
}

class ForumMessage {
  String forumId, authorId, author, profession, speciality, photoUrl, location;
  String answer, tips;
  bool doctor;
  DateTime answeredOn;
  List upVotes, downVotes;

  ForumMessage(
      {this.forumId,
      this.authorId,
      this.author,
      this.profession,
      this.speciality,
      this.answer,
      this.tips,
      this.doctor,
      this.upVotes,
      this.downVotes,
      this.photoUrl,
      this.location,
      this.answeredOn});

  factory ForumMessage.fromJSON(var map) {
    return ForumMessage(
      forumId: map['forumId'],
      authorId: map['authorId'],
      author: map['author'],
      profession: map['profession'],
      speciality: map['speciality'],
      answer: map['answer'],
      tips: map['tips'],
      doctor: map['doctor'] ?? false,
      upVotes: map['upVotes'] ?? [],
      downVotes: map['downVotes'] ?? [],
      answeredOn: DateTime.parse(map['answeredOn']),
      photoUrl: map['photoUrl'],
      location: map['location'],
    );
  }

  static toJSON(ForumMessage message) {
    return {
      "forumId": message.forumId,
      "authorId": message.authorId,
      "author": message.author,
      "profession": message.profession,
      "speciality": message.speciality,
      "answer": message.answer,
      "tips": message.tips,
      "doctor": message.doctor,
      "photoUrl": message.photoUrl,
      "location": message.location,
    };
  }

}
