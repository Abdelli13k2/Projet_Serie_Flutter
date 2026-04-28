import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/serie_provider.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère automatiquement la watchlist depuis le Provider
    // context.watch => reconstruit l’écran si la liste change
    final watchlist = context.watch<SerieProvider>().watchlist;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),

      // Si la watchlist est vide
      body: watchlist.isEmpty
          ? const Center(
              child: Text('Watchlist vide.'),
            )

          // Sinon on affiche la liste
          : ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (context, index) {
                final serie = watchlist[index];

                return ListTile(
                  // Image de la série (si disponible)
                  leading: serie.imageUrl != null
                      ? Image.network(serie.imageUrl!, width: 50)
                      : const Icon(Icons.tv),

                  // Nom de la série
                  title: Text(serie.nom),

                  // Genre
                  subtitle: Text(serie.genre),

                  // Bouton pour retirer de la watchlist
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.bookmark,
                      color: Colors.blue,
                    ),

                    // Toggle watchlist (ajoute/enlève)
                    onPressed: () {
                      context.read<SerieProvider>().toggleWatchlist(serie.id);
                    },
                  ),

                  // Navigation vers la page détail
                  onTap: () => context.go('/serie/${serie.id}'),
                );
              },
            ),
    );
  }
}
