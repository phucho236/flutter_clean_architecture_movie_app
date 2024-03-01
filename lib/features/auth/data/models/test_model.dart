part of mapper;

@JsonSerializable(explicitToJson: true)
class TestModel {
  TestModel({
    this.id,
    this.address,
    this.createdDay,
  });

  final String? id;
  final String? address;
  final DateTime? createdDay;
  factory TestModel.fromJson(Map<String, dynamic> json) => _$TestModelFromJson(json);
  Map<String, dynamic> toJson() => _$TestModelToJson(this);
}
