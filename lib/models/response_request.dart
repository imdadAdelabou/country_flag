class ResponseRequest {
  final int statusCode;
  final dynamic data;

  const ResponseRequest({
    this.data,
    required this.statusCode,
  });
}
