import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';

import 'order_details_screen.dart';
import 'package:flutter/material.dart';

class PedidosListoTienda extends StatefulWidget {
  static const String id = '/PedidosListoTienda';
  const PedidosListoTienda({Key? key}) : super(key: key);

  @override
  _PedidosListoTiendaState createState() => _PedidosListoTiendaState();
}

class _PedidosListoTiendaState extends State<PedidosListoTienda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              PopUpMenuWidgetAdmins(
                putArrow: true,
                callbackArrow: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.grey,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                            'Pedidos: entrega el al tienda Listos',
                            style: TextStyle(fontSize: 18),
                          )),
                    )),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile();
                    }),
              )
            ],
          ),
        ));
  }
}
