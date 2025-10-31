class FieldConfig {
  final String type;
  final String label;
  final String? placeholder;
  final int renderOrder;

  FieldConfig({
    required this.type,
    required this.label,
    this.placeholder,
    required this.renderOrder,
  });
}
