import 'package:biolo_app/layers/presentation/components/colors_const.dart';
import 'package:biolo_app/layers/presentation/ui/controller/favorites_controller.dart';
import 'package:biolo_app/layers/presentation/ui/pages/horiariovisita/horario_visita.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DetailsHomePage extends StatefulWidget {
  final Map<String, dynamic> casa;
  const DetailsHomePage({super.key, required this.casa});

  @override
  State<DetailsHomePage> createState() => _DetailsHomePageState();
}

class _DetailsHomePageState extends State<DetailsHomePage> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: Colors.white,
            elevation: 0,
            stretch: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.casa['imagens'],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    favoritesController.isFavorite(widget.casa) 
                        ? Icons.favorite 
                        : Icons.favorite_border_rounded,
                  ),
                  color: favoritesController.isFavorite(widget.casa) 
                      ? Colors.red 
                      : ColorsConst.sunstColor8,
                  onPressed: () {
                    favoritesController.toggleFavorite(widget.casa);
                  },
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.casa['titulo'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: ColorsConst.sunstColor10,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded, 
                                    size: 18, color: ColorsConst.sunstColor9),
                                const SizedBox(width: 6),
                                Text(
                                  widget.casa['localizacao'],
                                  style: TextStyle(
                                    color: ColorsConst.sunstColor9,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: _getStatusColor(widget.casa['status']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          (widget.casa['disponivel'] == true) 
                              ? "Disponível" 
                              : "Indisponível",
                          style: TextStyle(
                            color: _getStatusColor(widget.casa['status']),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAmenityItem(Icons.bed_rounded, "${widget.casa['quartos']} Quartos"),
                        _buildAmenityItem(Icons.bathtub_rounded, "${widget.casa['banheiros']} Banheiros"),
                        _buildAmenityItem(Icons.chair_rounded, "${widget.casa['salas']} Salas"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Descrição",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorsConst.sunstColor10,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.casa['descricao'],
                    style: TextStyle(
                      color: ColorsConst.sunstColor9,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Proprietário",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorsConst.sunstColor10,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorsConst.sunstColor1.withOpacity(0.1),
                          child: Icon(Icons.person, color: ColorsConst.sunstColor1),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "João Manuel",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: ColorsConst.sunstColor10,
                              ),
                            ),
                            Text(
                              "Proprietário",
                              style: TextStyle(
                                color: ColorsConst.sunstColor9,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorsConst.sunstColor8.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.phone, color: ColorsConst.sunstColor1),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorsConst.sunstColor8.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.message, color: ColorsConst.sunstColor1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Preço Total",
                  style: TextStyle(
                    color: ColorsConst.sunstColor9,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${widget.casa['precoMensal']} Kz",
                  style: TextStyle(
                    color: ColorsConst.sunstColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HorarioVisita(casa: widget.casa),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsConst.sunstColor1,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  widget.casa['status'] == 'Venda' ? "Comprar Agora" : "Alugar Agora",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenityItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: ColorsConst.sunstColor8, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: ColorsConst.sunstColor9,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Aluguel':
        return Colors.green;
      case 'Venda':
        return ColorsConst.sunstColor1;
      case 'Alugada':
        return Colors.orange;
      case 'Vendida':
        return Colors.red;
      default:
        return Colors.green;
    }
  }
}
