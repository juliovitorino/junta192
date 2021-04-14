import 'package:flutter/material.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

import 'package:junta192/br/com/jcv/linker/classes/ajuda/ajudaComoCriarCampanha.dart';
import 'package:junta192/br/com/jcv/linker/classes/ajuda/ajudaComoLiberarCarimbos.dart';
import 'package:junta192/br/com/jcv/linker/classes/ajuda/ajudaPossoUsarJ10Delivery.dart';
import 'package:junta192/br/com/jcv/linker/classes/ajuda/ajudaReceberRecompensa.dart';
import 'package:junta192/br/com/jcv/linker/classes/ajuda/ajudaEntregarRecompensa.dart';
import 'package:junta192/br/com/jcv/linker/classes/comofunciona/como-funciona.dart';


// Ponteiro para função acionar o menu de ajuda 
final Function fcnAcionarAjudaPrincipalCampanha =  (BuildContext context){
  showAdaptiveActionSheet(
            title: const Text('Precisa de Ajuda? Clique nas opções abaixo.'),
            context: context,
            actions: <BottomSheetAction>[
              BottomSheetAction(
                title: const Text('Como criar Campanha'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new AjudaComoCriarCampanha() ),
                  );
                },
              ),
              BottomSheetAction(
                title: const Text('Como liberar os carimbos'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new AjudaComoLiberarCarimbos() ),
                  );
                },
              ),
              BottomSheetAction(
                title: const Text('Como Entregar a Recompensa'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new AjudaComoEntregarRecompensa() ),
                  );
                },
              ),
            ],
            cancelAction: CancelAction(title: const Text('Cancelar')),
  );
};

// Ponteiro para função acionar o menu de ajuda 
// Este Widget fica localizado no Drawer (Sidebar)
final Function fcnAcionarAjudaComoFunciona =  (BuildContext context){
  showAdaptiveActionSheet(
            title: const Text('Precisa de Ajuda? Clique nas opções abaixo.'),
            context: context,
            actions: <BottomSheetAction>[
              BottomSheetAction(
                title: const Text('Como usar o Junta10 no dia a dia'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new ComoFuncionaPage() ),
                  );
                },
              ),
              BottomSheetAction(
                title: const Text('Como criar Campanha Fidelidade'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new AjudaComoCriarCampanha() ),
                  );
                },
              ),
              BottomSheetAction(
                title: const Text('Posso usar Junta10 no meu Delivery?'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new AjudaPossoUsarDelivery() ),
                  );
                },
              ),
              BottomSheetAction(
                title: const Text('Como Receber a Recompensa'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new AjudaComoReceberRecompensa() ),
                  );
                },
              ),
              BottomSheetAction(
                title: const Text('Como Entregar a Recompensa'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new AjudaComoEntregarRecompensa() ),
                  );
                },
              ),
            ],
            cancelAction: CancelAction(title: const Text('Cancelar')),
  );
};