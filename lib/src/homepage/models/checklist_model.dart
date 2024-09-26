import 'package:equatable/equatable.dart';

class ChecklistModel extends Equatable {
  const ChecklistModel({
    required this.id,
    required this.name,
    required this.items,
    required this.checklistCompletionStatus,
  });

  final int id;
  final String name;
  final dynamic items;
  final bool checklistCompletionStatus;

  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    return ChecklistModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      items: json["items"],
      checklistCompletionStatus: json["checklistCompletionStatus"] ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        items,
        checklistCompletionStatus,
      ];
}

/*
{
	"id": 5,
	"name": "satu",
	"items": null,
	"checklistCompletionStatus": false
}*/