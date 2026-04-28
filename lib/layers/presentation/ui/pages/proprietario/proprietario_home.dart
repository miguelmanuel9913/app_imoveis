import 'package:biolo_app/layers/data/dto/casa_dto.dart';
import 'package:biolo_app/layers/presentation/components/colors_const.dart';
import 'package:biolo_app/layers/presentation/ui/pages/profile/profile.dart';
import 'package:biolo_app/layers/presentation/ui/pages/proprietario/criar_casa.dart';
import 'package:biolo_app/layers/presentation/ui/pages/proprietario/minhas_casas.dart';
import 'package:biolo_app/layers/presentation/ui/pages/proprietario/visitas_recebidas.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class ProprietarioHomePage extends StatefulWidget {
  const ProprietarioHomePage({super.key});

  @override
  State<ProprietarioHomePage> createState() => _ProprietarioHomePageState();
}

class _ProprietarioHomePageState extends State<ProprietarioHomePage> {
  int _selectedIndex = 0;
  Map<String, dynamic>? _casaEmEdicao;

  final List<Map<String, dynamic>> _casas = [
    {
      'id': 101,
      'titulo': 'Vivenda Sol Nascente',
      'descricao':
          'Casa moderna com quintal, varanda e boa iluminacao natural.',
      'localizacao': 'Luanda, Talatona',
      'preco': 320000.0,
      'quartos': 4,
      'banheiros': 3,
      'salas': 2,
      'imagens': 'assets/img/homepage/casa03.jpeg',
    },
    {
      'id': 102,
      'titulo': 'Apartamento Central T3',
      'descricao': 'Apartamento bem localizado, ideal para familia pequena.',
      'localizacao': 'Luanda, Maianga',
      'preco': 180000.0,
      'quartos': 3,
      'banheiros': 2,
      'salas': 1,
      'imagens': 'assets/img/homepage/casaHomeList1.jpg',
    },
  ];

  final List<Map<String, dynamic>> _visitas = [
    {
      'id': 1,
      'cliente': 'Mariana Silva',
      'casa': 'Vivenda Sol Nascente',
      'data': DateTime(2026, 4, 29),
      'hora': '10:00',
      'status': 'Pendente',
    },
    {
      'id': 2,
      'cliente': 'Carlos Neto',
      'casa': 'Apartamento Central T3',
      'data': DateTime(2026, 4, 30),
      'hora': '15:30',
      'status': 'Pendente',
    },
    {
      'id': 3,
      'cliente': 'Ana Paula',
      'casa': 'Vivenda Sol Nascente',
      'data': DateTime(2026, 5, 2),
      'hora': '09:00',
      'status': 'Aceita',
    },
  ];


 void publicarCasa() async {
final dio = Dio();
final url = 'http://localhost:8080/api/casas';

try{

    CasaDto casaPub  = new CasaDto();
      casaPub.idCasaDto = 0;
      casaPub.descricaoCAsaDto= '';
      casaPub.enderecoCasaDto= '';
      casaPub.precoCasaDto=0.0;
      casaPub.estadoCasaDto= true;
      casaPub.proprietarioIdDto= 0;
      casaPub.tipoCasaDto= '';
      casaPub.topologiaCasaDto= '';
      casaPub.imagensCasaDto= [];




final JsonData =  casaPub.toJson();

final response  = await dio.put(
  
  url,
  
   data: JsonData,
   options: Options(
    headers: {
      'Content-Type': 'application/json', }));


     if (response.statusCode ==200 || response.statusCode == 201) {
      print('Casa publicada com sucesso!');
      final responseData = response.data;
      print('Resposta do servidor: $responseData');
    } else {
      print('Falha ao publicar casa. Status code: ${response.statusCode}');


    
   
   


 

 }
}catch(e){

DioException dioError = e as DioException;
dioError.response?.data != null
    ? print('Erro na resposta: ${dioError.response?.data}')
    : print('Erro na requisição: ${dioError.message}');
}


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Casa publicada com sucesso!')),
    );
  }
  void _abrirCadastro([Map<String, dynamic>? casa]) {
    setState(() {
      _casaEmEdicao = casa == null ? null : Map<String, dynamic>.from(casa);
      _selectedIndex = 1;
    });
  }

  void _salvarCasa(Map<String, dynamic> casa) {
    final existed = _casas.any((item) => item['id'] == casa['id']);

    setState(() {
      final index = _casas.indexWhere((item) => item['id'] == casa['id']);
      if (index >= 0) {
        _casas[index] = casa;
      } else {
        _casas.insert(0, casa);
      }
      _casaEmEdicao = null;
      _selectedIndex = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existed
              ? 'Casa atualizada com sucesso.'
              : 'Casa cadastrada com sucesso.',
        ),
      ),
    );
  }

  void _apagarCasa(Map<String, dynamic> casa) {
    setState(() {
      _casas.removeWhere((item) => item['id'] == casa['id']);
      if (_casaEmEdicao?['id'] == casa['id']) {
        _casaEmEdicao = null;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Casa removida da sua lista.')),
    );
  }

  void _responderVisita(int id, String status) {
    setState(() {
      final index = _visitas.indexWhere((item) => item['id'] == id);
      if (index >= 0) {
        _visitas[index] = {
          ..._visitas[index],
          'status': status,
        };
      }
    });
  }

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
      if (index != 1) {
        _casaEmEdicao = null;
      }
    });
  }

  List<Widget> _buildPages() {
    return [
      MinhasCasasPage(
        casas: _casas,
        onEdit: _abrirCadastro,
        onDelete: _apagarCasa,
        onCreate: () => _abrirCadastro(),
      ),
      CriarCasaPage(
        casaEmEdicao: _casaEmEdicao,
        onSave: _salvarCasa,
      ),
      VisitasRecebidasPage(
        visitas: _visitas,
        onAccept: (id) => _responderVisita(id, 'Aceita'),
        onReject: (id) => _responderVisita(id, 'Recusada'),
      ),
      const ProfileUser(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: ColorsConst.sunstColor10,
            boxShadow: [
              BoxShadow(
                blurRadius: 28,
                color: Colors.black.withOpacity(0.12),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: GNav(
                backgroundColor: ColorsConst.sunstColor10,
                color: ColorsConst.sunstColor8,
                activeColor: Colors.black,
                tabBackgroundColor: ColorsConst.sunstColor8,
                rippleColor: ColorsConst.sunstColor10,
                hoverColor: ColorsConst.sunstColor8!.withOpacity(0.15),
                gap: 8,
                iconSize: 22,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                duration: const Duration(milliseconds: 250),
                selectedIndex: _selectedIndex,
                onTabChange: _onTabChange,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Casas',
                  ),
                  GButton(
                    icon: LineIcons.plusCircle,
                    text: 'Cadastrar',
                  ),
                  GButton(
                    icon: LineIcons.calendar,
                    text: 'Visitas',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Perfil',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String formatarPreco(double valor) {
  return NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'Kz ',
    decimalDigits: 0,
  ).format(valor);
}
