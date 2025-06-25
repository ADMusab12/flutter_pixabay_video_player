class Video {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final String videoUrl;
  final String author;
  final int duration;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.videoUrl,
    required this.author,
    required this.duration,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['videos']?['medium']?['thumbnail'] ?? '';
    print('Thumbnail URL: $thumbnail'); 

  return Video(
    id: json['id'] ?? 0,
    title: json['tags'] ?? 'Untitled',
    description: json['tags'] ?? 'No description',
    thumbnail: thumbnail,
    videoUrl: json['videos']?['medium']?['url'] ?? '',
    author: json['user'] ?? 'Unknown',
    duration: json['duration'] ?? 0,
  );
  }
}