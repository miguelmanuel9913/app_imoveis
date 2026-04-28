import 'package:biolo_app/layers/presentation/components/colors_const.dart';
import 'package:flutter/material.dart';

class CriarCasaPage extends StatefulWidget {
  final Map<String, dynamic>? casaEmEdicao;
  final ValueChanged<Map<String, dynamic>> onSave;

  const CriarCasaPage({
    super.key,
    required this.casaEmEdicao,
    required this.onSave,
  });

  @override
  State<CriarCasaPage> createState() => _CriarCasaPageState();
}

class _CriarCasaPageState extends State<CriarCasaPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _localizacaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _quartosController = TextEditingController();
  final _banheirosController = TextEditingController();
  final _salasController = TextEditingController();
  final _imagensController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _preencherCampos();
  }

  @override
  void didUpdateWidget(covariant CriarCasaPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.casaEmEdicao?['id'] != widget.casaEmEdicao?['id']) {
      _preencherCampos();
    }
  }

  void _preencherCampos() {
    final casa = widget.casaEmEdicao;

    _tituloController.text = casa?['titulo'] ?? '';
    _descricaoController.text = casa?['descricao'] ?? '';
    _localizacaoController.text = casa?['localizacao'] ?? '';
    _precoController.text = casa?['preco']?.toString() ?? '';
    _quartosController.text = casa?['quartos']?.toString() ?? '';
    _banheirosController.text = casa?['banheiros']?.toString() ?? '';
    _salasController.text = casa?['salas']?.toString() ?? '';
    _imagensController.text =
        casa?['imagens'] ?? 'assets/img/homepage/house1.png';
    if (casa == null) {
      _imagensController.text = 'assets/img/homepage/house1.png';
    }
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final casa = <String, dynamic>{
      'id': widget.casaEmEdicao?['id'] ?? DateTime.now().millisecondsSinceEpoch,
      'titulo': _tituloController.text.trim(),
      'descricao': _descricaoController.text.trim(),
      'localizacao': _localizacaoController.text.trim(),
      'preco': double.tryParse(_precoController.text.trim()) ?? 0,
      'quartos': int.tryParse(_quartosController.text.trim()) ?? 0,
      'banheiros': int.tryParse(_banheirosController.text.trim()) ?? 0,
      'salas': int.tryParse(_salasController.text.trim()) ?? 0,
      'imagens': _imagensController.text.trim(),
    };

    widget.onSave(casa);
    if (widget.casaEmEdicao == null) {
      _formKey.currentState!.reset();
      _preencherCampos();
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _localizacaoController.dispose();
    _precoController.dispose();
    _quartosController.dispose();
    _banheirosController.dispose();
    _salasController.dispose();
    _imagensController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.casaEmEdicao != null;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          editando ? 'Editar Casa' : 'Cadastrar Casa',
          style: TextStyle(
            color: ColorsConst.sunstColor10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionCard(
                child: Column(
                  children: [
                    _buildField(
                      controller: _tituloController,
                      label: 'Titulo',
                      icon: Icons.home_work_outlined,
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      controller: _descricaoController,
                      label: 'Descricao',
                      icon: Icons.notes_rounded,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      controller: _localizacaoController,
                      label: 'Localizacao',
                      icon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      controller: _imagensController,
                      label: 'Imagem',
                      icon: Icons.image_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                child: Column(
                  children: [
                    _buildField(
                      controller: _precoController,
                      label: 'Preco',
                      icon: Icons.payments_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: _quartosController,
                            label: 'Quartos',
                            icon: Icons.bed_outlined,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            controller: _banheirosController,
                            label: 'Banheiros',
                            icon: Icons.bathtub_outlined,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      controller: _salasController,
                      label: 'Salas',
                      icon: Icons.weekend_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _salvar,
                  icon: Icon(
                      editando ? Icons.save_outlined : Icons.add_home_rounded),
                  label:
                      Text(editando ? 'Salvar alteracoes' : 'Cadastrar casa'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsConst.sunstColor1,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Preencha $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: ColorsConst.sunstColor1),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsConst.sunstColor1, width: 2),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      child: child,
    );
  }
}
