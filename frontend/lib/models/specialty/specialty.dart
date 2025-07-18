class Specialty {
  final int? id;
  final String nombre;
  final String descripcion;

  Specialty({
    this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) {
    int parseId(dynamic value) {
      if (value is int) return value;
      if (value is String && value.trim().isNotEmpty) {
        return int.tryParse(value) ?? 0;
      }
      return 0;
    }

    return Specialty(
      id: parseId(json['id']),
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Specialty && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => nombre;
}
