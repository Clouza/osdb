class Music {
  final String id;
  final String title;
  final String artist;
  final String album;
  final int year;
  bool isFavorite;

  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    this.isFavorite = false,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'year': year,
    };
  }
}