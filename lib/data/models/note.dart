// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime date;

  Note({
  this.id,
  required this.title, 
  required this.content, 
  required this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'date': date.millisecondsSinceEpoch,
    };
  }

  

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(int.parse(map['date'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);
}
