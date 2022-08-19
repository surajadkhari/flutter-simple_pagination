// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final int page;
  final int totalPages;
  final List<Data> users;
  UserModel({
    required this.page,
    required this.totalPages,
    required this.users,
  });

  UserModel copyWith({
    int? page,
    int? totalPages,
    List<Data>? users,
  }) {
    return UserModel(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'totalPages': totalPages,
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      page: map['page'] as int,
      totalPages: map['total_pages'] as int,
      users: List.from(map["data"]).map((e) => Data.fromMap(e)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(page: $page, totalPages: $totalPages, users: $users)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.page == page &&
        other.totalPages == totalPages &&
        listEquals(other.users, users);
  }

  @override
  int get hashCode => page.hashCode ^ totalPages.hashCode ^ users.hashCode;
}

class Data {
  final String email;
  final String avatar;
  Data({
    required this.email,
    required this.avatar,
  });

  Data copyWith({
    String? email,
    String? avatar,
  }) {
    return Data(
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'avatar': avatar,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      email: map['email'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(email: $email, avatar: $avatar)';

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.email == email && other.avatar == avatar;
  }

  @override
  int get hashCode => email.hashCode ^ avatar.hashCode;
}
