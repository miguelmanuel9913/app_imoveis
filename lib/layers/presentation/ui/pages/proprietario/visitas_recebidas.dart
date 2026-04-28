import 'package:biolo_app/layers/presentation/components/colors_const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitasRecebidasPage extends StatelessWidget {
  final List<Map<String, dynamic>> visitas;
  final ValueChanged<int> onAccept;
  final ValueChanged<int> onReject;

  const VisitasRecebidasPage({
    super.key,
    required this.visitas,
    required this.onAccept,
    required this.onReject,
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
          'Visitas Recebidas',
          style: TextStyle(
            color: ColorsConst.sunstColor10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: visitas.isEmpty
          ? Center(
              child: Text(
                'Nenhuma visita recebida ainda.',
                style: TextStyle(color: ColorsConst.sunstColor9),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              itemCount: visitas.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final visita = visitas[index];
                final status = visita['status'] as String;
                final pendente = status == 'Pendente';

                return Container(
                  padding: const EdgeInsets.all(18),
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
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                ColorsConst.sunstColor8!.withOpacity(0.18),
                            child: Text(
                              (visita['cliente'] as String).substring(0, 1),
                              style: TextStyle(
                                color: ColorsConst.sunstColor1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  visita['cliente'],
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsConst.sunstColor10,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  visita['casa'],
                                  style:
                                      TextStyle(color: ColorsConst.sunstColor9),
                                ),
                              ],
                            ),
                          ),
                          _StatusChip(status: status),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _MetaItem(
                            icon: Icons.calendar_month_outlined,
                            text: DateFormat('dd/MM/yyyy')
                                .format(visita['data'] as DateTime),
                          ),
                          const SizedBox(width: 12),
                          _MetaItem(
                            icon: Icons.access_time_rounded,
                            text: visita['hora'],
                          ),
                        ],
                      ),
                      if (pendente) ...[
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => onAccept(visita['id'] as int),
                                icon: const Icon(Icons.check_circle_outline),
                                label: const Text('Aceitar'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => onReject(visita['id'] as int),
                                icon: const Icon(Icons.close_rounded),
                                label: const Text('Recusar'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.redAccent,
                                  side:
                                      const BorderSide(color: Colors.redAccent),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: ColorsConst.sunstColor1),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'Aceita':
        color = Colors.green;
        break;
      case 'Recusada':
        color = Colors.redAccent;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
