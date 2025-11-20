import 'package:mobile_banking_apps/features/transfer/domain/entities/method_entity.dart';

class MethodModel {
  final String typeCode;
  final String typeName;
  final String description;

  MethodModel({
    required this.typeCode,
    required this.typeName,
    required this.description,
  });

  factory MethodModel.fromJson(Map<String, dynamic> json) {
    return MethodModel(
      typeCode: json['type_code'],
      typeName: json['type_name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_code': typeCode,
      'type_name': typeName,
      'description': description,
    };
  }

  factory MethodModel.fromEntity(MethodEntity entity) {
    return MethodModel(
      typeCode: entity.typeCode,
      typeName: entity.typeName,
      description: entity.description,
    );
  }

  MethodEntity toEntity() {
    return MethodEntity(
      typeCode: typeCode,
      typeName: typeName,
      description: description,
    );
  }
}
