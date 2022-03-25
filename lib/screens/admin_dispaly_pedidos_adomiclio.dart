import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/apis/user_get_orders.dart';
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
import 'package:simo_v_7_0_1/providers/shared_preferences_provider.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/pagar_ahora_enLinea.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_en_camino.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_en_preparacion.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_entregados.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_pendientes.dart';
import 'package:simo_v_7_0_1/screens/pedidos_domicilio_receivedos.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'package:simo_v_7_0_1/widgets_utilities/statefulWidget_textFormField.dart';

import 'cart_screen.dart';
import 'order_details_screen.dart';

class PedidosADomiclioDisplay extends StatefulWidget {
  static const String id = '/adminordersDisplay';
  const PedidosADomiclioDisplay({Key? key}) : super(key: key);

  @override
  _PedidosADomiclioDisplayState createState() => _PedidosADomiclioDisplayState();
}

class _PedidosADomiclioDisplayState extends State<PedidosADomiclioDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              PopUpMenuWidgetAdmins(putArrow: true,callbackArrow: (){Navigator.of(context).pop();},),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.grey,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text('Pedidos de entrega a domicilio',style: TextStyle(fontSize: 20),)),
                    )),
              ),
              Expanded(
                child: ListView(

                    children: <Widget>[
                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                        voidCallback: () async {Navigator.of(context).pushNamed(PedidosRecividosDomicilio.id);
                        await  context.read<GetPedidosProvider>().getOrderWithDetailLisNoFilter() ;
                        },title: ' Recebidos',),

                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                        voidCallback: (){Navigator.of(context).pushNamed(PedidosEnPreparcionDomicilio.id);},title: 'En preparacion ',),

                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                        voidCallback: (){Navigator.of(context).pushNamed(PedidosEncaminoDomicilio.id);},title: 'En camino',),

                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                        voidCallback: (){Navigator.of(context).pushNamed(PedidosEntregadosDomicilio.id);},title: 'Entregados',),

                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                        voidCallback: (){Navigator.of(context).pushNamed(PedidosPendientesDomicilio.id);},title: 'Pendientes',),



                    ]),
              ),
            ],
          ),
        )
    );
  }
}
