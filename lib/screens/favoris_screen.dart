import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/favoris_provider.dart';
import '../providers/serie_provider.dart';

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère la liste des favoris depuis le Provider
    // context.watch => reconstruit automatiquement l’écran si la liste change
    final favoris = context.watch<SerieProvider>().favoris;

    return Scaffold(
      // Barre du haut
      appBar: AppBar(
        title: const Text('Mes favoris'),
      ),

      // Corps de l’écran
      body: favoris.isEmpty
          // Cas 1 : aucun favori
          ? const Center(
              child: Text('Aucun favori pour l\'instant.'),
            )

          // Cas 2 : il y a des favoris → affichage liste
          : ListView.builder(
              itemCount: favoris.length,
              itemBuilder: (context, index) {
                // On récupère une série à chaque ligne
                final serie = favoris[index];

                return ListTile(
                  // Image de la série (si disponible)
                  leading: serie.imageUrl != null
                      ? Image.network(serie.imageUrl!, width: 50)
                      : const Icon(Icons.tv),

                  // Nom de la série
                  title: Text(serie.nom),

                  // Genre de la série
                  subtitle: Text(serie.genre),

                  // Bouton pour retirer des favoris
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),

                    // Action : toggle favori (ajoute/enlève)
                    onPressed: () {
                      context.read<SerieProvider>().toggleFavori(serie.id);
                    },
                  ),

                  // Clic sur la carte → navigation vers détail
                  onTap: () => context.go('/serie/${serie.id}'),
                );
              },
            ),
    );
  }
}
