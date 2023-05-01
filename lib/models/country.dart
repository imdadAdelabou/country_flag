class Country {
  final String name;
  final String code;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.flag,
  });

  static Country fromMap({required Map<String, dynamic> data}) {
    return Country(
      name: data["name"],
      code: data["code"] ?? "",
      flag: data["flag"] ?? "",
    );
  }
}
