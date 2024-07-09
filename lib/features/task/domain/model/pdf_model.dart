class PDFModel{
  final String title;
  final String url;
  bool? isLocal;
  String? date;

  PDFModel({required this.title, required this.url, this.isLocal = false, this.date});
}