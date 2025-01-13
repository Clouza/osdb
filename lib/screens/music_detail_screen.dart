import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/music.dart';
import '../providers/favorite_provider.dart';

class MusicDetailScreen extends StatelessWidget {
  final Music music;

  const MusicDetailScreen({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(music.title),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, child) {
              final isFavorite = favoriteProvider.isFavorite(music.id);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () => favoriteProvider.toggleFavorite(music),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Artist',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(music.artist),
            const SizedBox(height: 16),
            Text(
              'Album',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(music.album),
            const SizedBox(height: 16),
            Text(
              'Year',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(music.year.toString()),
          ],
        ),
      ),
    );
  }
}