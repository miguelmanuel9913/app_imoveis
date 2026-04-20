import 'package:biolo_app/layers/data/dto/casa_dto.dart';
import 'package:biolo_app/layers/domain/entities/casa_entity.dart';
import 'package:flutter/material.dart';

class CadCasaPage extends StatefulWidget {
  const CadCasaPage({super.key});

  @override
  State<CadCasaPage> createState() => _CadCasaPageState();
}

class _CadCasaPageState extends State<CadCasaPage> {
   List< CasaDto> casa =[];
  
   final _keyCad = GlobalKey<FormState>();


   final textEnderecoHouse = TextEditingController();
   final  textDescricaoCasa= TextEditingController();
   final textPrecoCasa = TextEditingController();
   final textTipoCasa = TextEditingController();
   final textTopologiaCasa= TextEditingController();
   bool estadoCasa = false;
   final propetatrioId= TextEditingController();
   




void  diaLogoShow( String titulo, String mensagem ,{VoidCallback ? onclose } ){

  showDialog(
    context: context, 
    builder: (_)=>  AlertDialog(
      title: Text(titulo),
      content: Text(mensagem),
      actions: [
        TextButton(onPressed: onclose, child: const Text('Fechar'))
      ],
    ),

    

    );



}



Future<void>  _salvar( )async{
  if (!_keyCad.currentState!.validate()){
    diaLogoShow('Erro', 'Preencha os campos corretamente');
    return;


  }
  final novaCasa = CasaDto(
    descricaoCAsaDto: textDescricaoCasa.text,
     precoCasaDto: double.tryParse(textPrecoCasa.text) ?? 0.0,
      tipoCasaDto: textTipoCasa.text,
       topologiaCasaDto: textTopologiaCasa.text,
        estadoCasaDto: estadoCasa,
         proprietarioIdDto: int.tryParse(propetatrioId.text) ?? 0,
          enderecoCasaDto: textEnderecoHouse.text

  );


}
   
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}