import 'package:collection/collection.dart';

class ToDo {
  String? title;
  bool? isDone;
  String? description;

  ToDo({this.title, this.isDone, this.description});

  @override
  String toString() {
    return 'ToDo(title: $title, isDone: $isDone, description: $description)';
  }

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        title: json['title'] as String?,
        isDone: json['isDone'] as bool?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'isDone': isDone,
        'description': description,
      };

  ToDo copyWith({
    String? title,
    bool? isDone,
    String? description,
  }) {
    return ToDo(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ToDo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => title.hashCode ^ isDone.hashCode ^ description.hashCode;
}
