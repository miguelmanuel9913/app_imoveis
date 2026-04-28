import 'package:biolo_app/layers/presentation/components/colors_const.dart';
import 'package:biolo_app/layers/presentation/ui/pages/proprietario/proprietario_home.dart';
import 'package:flutter/material.dart';

class MinhasCasasPage extends StatelessWidget {
  final List<Map<String, dynamic>> casas;
  final ValueChanged<Map<String, dynamic>> onEdit;
  final ValueChanged<Map<String, dynamic>> onDelete;
  final VoidCallback onCreate;

  const MinhasCasasPage({
    super.key,
    required this.casas,
    required this.onEdit,
    required this.onDelete,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Minhas Casas',
          style: TextStyle(
            color: ColorsConst.sunstColor10,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: onCreate,
            icon: Icon(Icons.add_home_rounded, color: ColorsConst.sunstColor1),
          ),
        ],
      ),
      body: casas.isEmpty
          ? _EmptyState(onCreate: onCreate)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              itemCount: casas.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final casa = casas[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        child: Image.asset(
                          casa['imagens'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              casa['titulo'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorsConst.sunstColor10,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              casa['localizacao'],
                              style: TextStyle(
                                color: ColorsConst.sunstColor9,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                _InfoChip(
                                  icon: Icons.bed_rounded,
                                  text: '${casa['quartos']} quartos',
                                ),
                                const SizedBox(width: 8),
                                _InfoChip(
                                  icon: Icons.bathtub_rounded,
                                  text: '${casa['banheiros']} banheiros',
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(
                              formatarPreco((casa['preco'] as num).toDouble()),
                              style: TextStyle(
                                color: ColorsConst.sunstColor1,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () => onEdit(casa),
                                    icon: const Icon(Icons.edit_rounded),
                                    label: const Text('Editar'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: ColorsConst.sunstColor1,
                                      side: BorderSide(
                                          color: ColorsConst.sunstColor1),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextButton.icon(
                                    onPressed: () => onDelete(casa),
                                    icon: const Icon(
                                        Icons.delete_outline_rounded),
                                    label: const Text('Apagar'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.redAccent,
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.08),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onCreate,
        backgroundColor: ColorsConst.sunstColor8,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add_home_work_rounded),
        label: const Text('Cadastrar casa'),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: ColorsConst.sunstColor1),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onCreate;

  const _EmptyState({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: ColorsConst.sunstColor8!.withOpacity(0.18),
              child: Icon(
                Icons.home_work_outlined,
                size: 34,
                color: ColorsConst.sunstColor1,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhuma casa cadastrada',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsConst.sunstColor10,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cadastre o primeiro imovel para comecar a gerir as visitas.',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorsConst.sunstColor9),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: onCreate,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsConst.sunstColor1,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              child: const Text('Cadastrar agora'),
            ),
          ],
        ),
      ),
    );
  }
}
