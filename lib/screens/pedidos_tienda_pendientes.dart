import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/apis/user_get_orders.dart';
import 'package:simo_v_7_0_1/providers/shared_preferences_provider.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/pagar_ahora_enLinea.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'package:simo_v_7_0_1/widgets_utilities/statefulWidget_textFormField.dart';

import 'cart_screen.dart';
import 'order_details_screen.dart';

class PedidosPendientesTienda extends StatefulWidget {
  static const String id = '/PedidosPendientesTienda';
  const PedidosPendientesTienda({Key? key}) : super(key: key);

  @override
  _PedidosPendientesTiendaState createState() => _PedidosPendientesTiendaState();
}

class _PedidosPendientesTiendaState extends State<PedidosPendientesTienda> {
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
                            'Pedidos pendientes: entrega a la tienda',
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
