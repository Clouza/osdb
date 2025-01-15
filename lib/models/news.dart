class News {
  final String title;
  final String source;
  final String sourceIcon;
  final String imageUrl;
  final String link;
  bool isFavorite;

  News({
    required this.title,
    required this.source,
    required this.sourceIcon,
    required this.imageUrl,
    required this.link,
    this.isFavorite = false,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      source: json['source'] ?? '',
      sourceIcon: json['source_icon'] ?? '',
      imageUrl: json['og'] ?? '',
      link: json['link'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'source': source,
      'sourceIcon': sourceIcon,
      'imageUrl': imageUrl,
      'link': link,
    };
  }

  // Untuk membaca dari SQLite
  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      title: map['title'] ?? '',
      source: map['source'] ?? '',
      sourceIcon: map['sourceIcon'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      link: map['link'] ?? '',
      isFavorite: true,
    );
  }
}