import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Movie extends Equatable {
  int _id;
  String _title;
  String _posterPath;
  String _overview;
  DateTime _releaseDate;

  Movie(this._id, this._title, this._posterPath, this._overview, this._releaseDate);

  @override
  List<Object> get props => [_id, _title, _posterPath, _overview, _releaseDate];

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get posterPath => _posterPath;

  set posterPath(String value) {
    _posterPath = value;
  }

  String get overview => _overview;

  set overview(String value) {
    _overview = value;
  }

  DateTime get releaseDate => _releaseDate;

  set releaseDate(DateTime value) {
    _releaseDate = value;
  }

  Movie.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _posterPath = json['poster_path'];
    _overview = json['overview'];
    _releaseDate = DateTime.parse(json['release_date']);
  }
}
