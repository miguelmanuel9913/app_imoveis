import 'package:biolo_app/layers/presentation/components/colors_const.dart';
import 'package:flutter/material.dart';

class AcessNewRegisterPage extends StatefulWidget {
  const AcessNewRegisterPage({super.key});

  @override
  State<AcessNewRegisterPage> createState() => _AcessNewRegisterPageState();
}

class _AcessNewRegisterPageState extends State<AcessNewRegisterPage> {
  final TextEditingController _nameCliente = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              //  image here
                    SizedBox(height: 5),
                Image(
                 image: AssetImage(
                   "assets/img/logo.png",
              
                   
                 ), 
                
                 height: 100,
                           
                 alignment: Alignment.centerLeft,
                 fit: BoxFit.fitHeight,
                 
                                  ),
          Text( "Cadastro",style: TextStyle(
              
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 18),
              Padding(
          padding: const EdgeInsets.only(right: 20, left: 30),
                child: TextFormField(
                  controller: _nameCliente,
                  decoration: const InputDecoration(
                    hintText: "Nome Completo",
                    enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 30),
                child: TextFormField(
                  controller: _nameCliente,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "email",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 30),
                child: TextFormField(
                  controller: _nameCliente,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "telefone",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 30),
                child: TextFormField(
                  controller: _nameCliente,
                  decoration: const InputDecoration(
                           
                      enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      prefixIconColor: Colors.amber,
                      hintText: "Senha"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 30),
                child: TextFormField(
                  controller: _nameCliente,
                  decoration: const InputDecoration(
                    
                      enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: "Confirmar a senha"),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Anexar Documento"),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(

                onTap: () {
         
                  Navigator.of(context).pushNamed("/login_page");
                },
                child: Container(
                  height: 55,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: const Border(
                        bottom: BorderSide(color: Colors.white),
                      ),
                      color: ColorsConst.sunstColor10),
                  child: Center(
                      child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      color: ColorsConst.sunstColor8,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
