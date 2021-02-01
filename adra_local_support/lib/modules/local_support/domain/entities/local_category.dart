class LocalCategory extends Object {
  final int id;
  final String description;
  final bool isActive;

  LocalCategory(this.id, this.description, this.isActive);

  @override
  bool operator ==(Object other) =>
      other is LocalCategory ? this.id == other.id : false;

  @override
  int get hashCode => super.hashCode;
}
