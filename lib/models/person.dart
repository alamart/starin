import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Person extends Equatable {
  final int id;
  final String name;
  final String profilePath;
  final String occupation;

  Person({@required this.id, @required this.name, this.profilePath, this.occupation});

  @override
  List<Object> get props => [id, name, profilePath, occupation];

      Person.fromJson(Map<String, dynamic> json) :
            id = json['id'],
            name = json['name'],
            profilePath = json['profile_path'],
            occupation = json['known_for_department'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'known_for_department': occupation,
        'profile_path': profilePath,
      };


}