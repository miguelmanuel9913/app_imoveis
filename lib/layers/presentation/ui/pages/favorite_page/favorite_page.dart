import 'package:biolo_app/layers/presentation/components/colors_const.dart';
import 'package:biolo_app/layers/presentation/ui/controller/favorites_controller.dart';
import 'package:biolo_app/layers/presentation/ui/pages/details_page/details_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoritesController favoritesController = GetIt.I.get<FavoritesController>();

  @override
  void initState() {
    super.initState();
    favoritesController.addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    favoritesController.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final favorites = favoritesController.favorites;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Meus Favoritos",
          style: TextStyle(
            color: ColorsConst.sunstColor10,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: ColorsConst.sunstColor9),
                  const SizedBox(height: 16),
                  Text(
                    "Nenhum favorito ainda",
                    style: TextStyle(
                      color: ColorsConst.sunstColor9,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: favorites.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final casa = favorites[index];
                return _buildFavoriteCard(casa);
              },
            ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> casa) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsHomePage(casa: casa),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
              child: Image.asset(
                casa['imagens'],
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            casa['titulo'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorsConst.sunstColor10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            favoritesController.toggleFavorite(casa);
                          },
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                          iconSize: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      casa['localizacao'],
                      style: TextStyle(
                        color: ColorsConst.sunstColor9,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${casa['precoMensal']} Kz/mês",
                      style: TextStyle(
                        color: ColorsConst.sunstColor1,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
