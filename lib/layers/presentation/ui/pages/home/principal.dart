import 'package:biolo_app/layers/presentation/components/colors_const.dart';
import 'package:biolo_app/layers/presentation/ui/controller/favorites_controller.dart';
import 'package:biolo_app/layers/presentation/ui/pages/details_page/details_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controller/auth/cad_casa_controller.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  // Mock data based on user provided JSON structure
  final List<Map<String, dynamic>> casas = [
    {
      "id": 2,
      "proprietarioId": 1,
      "titulo": "Prédio Moderno",
      "descricao": "Excelente apartamento em zona nobre",
      "localizacao": "Luanda, Talatona",
      "precoMensal": 120000.0,
      "quartos": 2,
      "banheiros": 3,
      "salas": 4,
      "disponivel": true,
      "status": "Aluguel",
      "imagens": "assets/img/homepage/house1.png", // Using existing asset for now
      "proprietario": null
    },
    {
      "id": 3,
      "proprietarioId": 2,
      "titulo": "Vivenda Familiar",
      "descricao": "Espaço amplo para toda família",
      "localizacao": "Luanda, Miramar",
      "precoMensal": 250000.0,
      "quartos": 4,
      "banheiros": 4,
      "salas": 2,
      "disponivel": true,
      "status": "Venda",
      "imagens": "assets/img/homepage/house1.png",
      "proprietario": null
    },
    {
      "id": 4,
      "proprietarioId": 3,
      "titulo": "Apartamento T3",
      "descricao": "Apartamento confortável no centro",
      "localizacao": "Luanda, Maianga",
      "precoMensal": 85000.0,
      "quartos": 3,
      "banheiros": 2,
      "salas": 1,
      "disponivel": false,
      "status": "Alugada",
      "imagens": "assets/img/homepage/house1.png",
      "proprietario": null
    },
    {
      "id": 5,
      "proprietarioId": 4,
      "titulo": "Casa de Praia",
      "descricao": "Vista para o mar",
      "localizacao": "Benguela, Restinga",
      "precoMensal": 450000.0,
      "quartos": 5,
      "banheiros": 6,
      "salas": 3,
      "disponivel": false,
      "status": "Vendida",
      "imagens": "assets/img/homepage/house1.png",
      "proprietario": null
    },
    {
      "id": 6,
      "proprietarioId": 5,
      "titulo": "Kitnet Econômica",
      "descricao": "Ideal para estudantes",
      "localizacao": "Luanda, Kilamba",
      "precoMensal": 45000.0,
      "quartos": 1,
      "banheiros": 1,
      "salas": 1,
      "disponivel": true,
      "status": "Aluguel",
      "imagens": "assets/img/homepage/house1.png",
      "proprietario": null
    }
  ];

  final List<Map<String, dynamic>> desconto = [
    {
      "descricao": "Desconto de 20%",
      "detalhe": "Na primeira compra ou aluguel",
      "imagem": "assets/img/homepage/House.png"
    },
  ];

  List<String> nameCategorie = [
    "Todos",
    "Luanda",
    "Benguela",
    "Kwanza Sul",
    "Namibe",
    "Malanje",
    "Bengo"
  ];

  int _itemSelected = 0;
  var cadCasaController = GetIt.I.get<CadCasaController>();
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

  void _onTypeItemSelect(int index) {
    setState(() {
      _itemSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header Section
              _buildHeader(),
              const SizedBox(height: 20),
              // Search Bar
              _buildSearchBar(),
              const SizedBox(height: 20),
              // Categories
              _buildCategories(),
              const SizedBox(height: 20),
              // Main Content
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildDiscountBanner(),
                    const SizedBox(height: 25),
                    _buildSectionTitle("Em destaque", () {
                      Navigator.of(context).pushNamed('/all_casa_page');
                    }),
                    const SizedBox(height: 15),
                    _buildHouseList(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Localização",
              style: TextStyle(
                color: ColorsConst.sunstColor9,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, color: ColorsConst.sunstColor8, size: 20),
                const SizedBox(width: 4),
                Text(
                  "Angola, Luanda",
                  style: TextStyle(
                    color: ColorsConst.sunstColor10,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: ColorsConst.sunstColor9),
              ],
            ),
          ],
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: ColorsConst.sunstColor8,
          child: Text(
            "M",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: ColorsConst.sunstColor1),
          hintText: "Pesquisar cidade/bairro",
          hintStyle: TextStyle(color: ColorsConst.sunstColor9, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          suffixIcon: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: ColorsConst.sunstColor8,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: nameCategorie.length,
        itemBuilder: (context, index) {
          final isSelected = _itemSelected == index;
          return GestureDetector(
            onTap: () => _onTypeItemSelect(index),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? ColorsConst.sunstColor8 : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey.shade300,
                ),
              ),
              child: Text(
                nameCategorie[index],
                style: TextStyle(
                  color: isSelected ? ColorsConst.sunstColor5 : ColorsConst.sunstColor9,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDiscountBanner() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            ColorsConst.sunstColor8,
            ColorsConst.sunstColor1.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.2,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: ColorsConst.sunstColor8,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Promoção",
                          style: TextStyle(
                            color: ColorsConst.sunstColor10,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Desconto de 20%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Na primeira compra ou aluguel",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "assets/img/homepage/House.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onViewMore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsConst.sunstColor10,
          ),
        ),
        TextButton(
          onPressed: onViewMore,
          child: Text(
            "Ver todos",
            style: TextStyle(
              color: ColorsConst.sunstColor9,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHouseList() {
    if (casas.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Nenhuma casa encontrada"),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: casas.length,
      separatorBuilder: (context, index) => const SizedBox(height: 25),
      itemBuilder: (context, index) {
        final casa = casas[index];
        return _buildHouseCard(casa);
      },
    );
  }

  Widget _buildHouseCard(Map<String, dynamic> casa) {
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
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                child: Image.asset(
                  casa["imagens"],
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Price Tag
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: ColorsConst.sunstColor8,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsConst.sunstColor8.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    "${casa['precoMensal']} Kz/mês",
                    style: TextStyle(
                      color: ColorsConst.sunstColor5,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              // Favorite Button
              Positioned(
                top: 20,
                right: 20,
                child: Container(
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
                      favoritesController.isFavorite(casa) 
                          ? Icons.favorite 
                          : Icons.favorite_border_rounded,
                    ),
                    color: favoritesController.isFavorite(casa) 
                        ? Colors.red 
                        : ColorsConst.sunstColor8,
                    onPressed: () {
                      favoritesController.toggleFavorite(casa);
                    },
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ],
          ),
          
          // Info Section
          Padding(
            padding: const EdgeInsets.all(20.0),
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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: ColorsConst.sunstColor10,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _getStatusColor(casa['status']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        (casa['disponivel'] == true) 
                            ? "Disponível - ${casa['status']}" 
                            : casa['status'] ?? "Indisponível",
                        style: TextStyle(
                          color: _getStatusColor(casa['status']),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, 
                        size: 18, color: ColorsConst.sunstColor9),
                    const SizedBox(width: 6),
                    Text(
                      casa['localizacao'],
                      style: TextStyle(
                        color: ColorsConst.sunstColor9,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildAmenity(Icons.bed_rounded, "${casa['quartos']}", "Quartos"),
                      Container(height: 20, width: 1, color: Colors.grey.shade300),
                      _buildAmenity(Icons.bathtub_rounded, "${casa['banheiros']}", "Banheiros"),
                      Container(height: 20, width: 1, color: Colors.grey.shade300),
                      _buildAmenity(Icons.chair_rounded, "${casa['salas']}", "Salas"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildAmenity(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, size: 20, color: ColorsConst.sunstColor8),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: ColorsConst.sunstColor10,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: ColorsConst.sunstColor9,
                fontSize: 12,
              ),
            ),
          ],
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
