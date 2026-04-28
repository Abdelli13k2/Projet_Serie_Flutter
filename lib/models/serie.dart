class Serie {
  final int id;
  final String nom;
  final String synopsis;
  final String genre;
  final String? imageUrl;
  final double? note;
  final String statut;

  bool isFavori;
  bool isInWatchlist;

  Serie({
    required this.id,
    required this.nom,
    required this.synopsis,
    required this.genre,
    this.imageUrl,
    this.note,
    required this.statut,
    this.isFavori = false,
    this.isInWatchlist = false,
  });

  static String _stripHtml(String? html) {
    if (html == null) return '';
    return html.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  factory Serie.fromJson(Map<String, dynamic> json) {
    final genres = json['genres'] as List<dynamic>?;

    return Serie(
      id: json['id'],
      nom: json['name'] ?? json['nom'] ?? 'Sans titre',
      synopsis: json['summary'] != null
          ? _stripHtml(json['summary'])
          : json['synopsis'] ?? '',
      genre: genres != null && genres.isNotEmpty
          ? genres[0]
          : json['genre'] ?? 'Inconnu',
      imageUrl: json['image']?['medium'] ?? json['imageUrl'],
      note: (json['rating']?['average'] as num?)?.toDouble() ??
          (json['note'] as num?)?.toDouble(),
      statut: json['status'] ?? json['statut'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'synopsis': synopsis,
        'genre': genre,
        'imageUrl': imageUrl,
        'note': note,
        'statut': statut,
      };

  @override
  bool operator ==(Object other) => other is Serie && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
