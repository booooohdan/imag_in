class Photo {
  const Photo({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.downloadUrl,
    this.localPath,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json['id'] as String,
    author: json['author'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
    downloadUrl: json['download_url'] as String,
  );

  factory Photo.local(String path) => Photo(
    id: path,
    author: 'Local Photo',
    width: 0,
    height: 0,
    downloadUrl: '',
    localPath: path,
  );

  final String id;
  final String author;
  final int width;
  final int height;
  final String downloadUrl;
  final String? localPath;

  bool get isLocal => localPath != null;

  String get thumbnailUrl => 'https://picsum.photos/id/$id/400/400';
}
