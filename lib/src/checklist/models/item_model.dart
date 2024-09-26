import 'package:equatable/equatable.dart';

class ItemModel extends Equatable {
  const ItemModel({
    required this.id,
    required this.name,
    required this.itemCompletionStatus,
  });

  final int id;
  final String name;
  final bool itemCompletionStatus;

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      itemCompletionStatus: json["itemCompletionStatus"] ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        itemCompletionStatus,
      ];
}

/*
{
	"id": 4,
	"name": "item kesatu",
	"itemCompletionStatus": false
}*/