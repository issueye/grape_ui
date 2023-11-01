class Datum {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? mark;

  Datum({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.mark,
  });

  @override
  String toString() {
    return 'Datum(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, mark: $mark)';
  }

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        name: json['name'] as String?,
        mark: json['mark'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'name': name,
        'mark': mark,
      };
}
