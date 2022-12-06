// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String? email;
  String? first_name;
  String? last_name;
  String? avatar;
  String? job;
  String? name;
  UserModel({
    this.id,
    this.email,
    this.first_name,
    this.last_name,
    this.avatar,
    this.job,
    this.name,
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? first_name,
    String? last_name,
    String? avatar,
    String? job,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      avatar: avatar ?? this.avatar,
      job: job ?? this.job,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'avatar': avatar,
      'job': job,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      avatar: map['avatar'],
      job: map['job'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, first_name: $first_name, last_name: $last_name, avatar: $avatar,  job: $job,  name: $name)';
  }
}
