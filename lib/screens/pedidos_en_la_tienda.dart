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
import 'package:simo_v_7_0_1/screens/pedidos_tienda_en_preparacion%20.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_entregados.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_listo.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_pendientes.dart';
import 'package:simo_v_7_0_1/screens/pedidos_tienda_recibidos.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'package:simo_v_7_0_1/widgets_utilities/statefulWidget_textFormField.dart';

import 'cart_screen.dart';
import 'order_details_screen.dart';

class PedidosEnLaTienda extends StatefulWidget {
  static const String id = '/PedidosAlatiendaDisplay';
  const PedidosEnLaTienda({Key? key}) : super(key: key);

  @override
  _PedidosEnLaTiendaState createState() => _PedidosEnLaTiendaState();
}

class _PedidosEnLaTiendaState extends State<PedidosEnLaTienda> {



  @override
  void initState() {
    context.read<GetPedidosProvider>().getAllOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {




    context.read<GetPedidosProvider>().getAtStoreReceived();
     context.read<GetPedidosProvider>().getAtStoreBeingPrepared();
    context.read<GetPedidosProvider>().getAtStoreReady();
    context.read<GetPedidosProvider>().getAtStoreDelivered();
    context.read<GetPedidosProvider>().getDifference();

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              PopUpMenuWidgetAdmins(putArrow: true,callbackArrow: (){Navigator.of(context).pop();},),
              SizedBox(height: 10,),
              Padding(padding: const EdgeInsets.all(8.0),
                child: Container(color: Colors.grey, width: double.infinity,
                    child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text('Pedidos  de entrega en la tienda',style: TextStyle(fontSize: 20),)),
                    )),),




              Expanded(
                child: ListView(
                    children: <Widget>[
                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                          voidCallback: (){  Navigator.of(context).pushNamed(PedidosRecividosTienda.id) ;  },
                          title:' Recibidos  ' , trailing:'${ context.watch<GetPedidosProvider>().atStoreReceived.length}' ),
                           SizedBox(height: 20,),
                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                          voidCallback: (){ Navigator.of(context).pushNamed(PedidosEnPreparcionTienda.id) ;    },
                          title:'En Preparación' , trailing:'${ context.watch<GetPedidosProvider>().atStoreBeingPrepared.length}' ),
                       SizedBox(height: 20,),
                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                          voidCallback: (){ Navigator.of(context).pushNamed(PedidosListoTienda.id) ;    },
                          title:'Listos  ' , trailing:'${ context.watch<GetPedidosProvider>().atStoreReady.length}' ),
                      SizedBox(height: 20,),
                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                          voidCallback: (){  Navigator.of(context).pushNamed(PedidosEntregadosTienda.id) ;    },
                          title:'Entregados' , trailing:'${ context.watch<GetPedidosProvider>().atStoreDelivered.length}' ),

                      SizedBox(height: 20,),
                      UsedWidgets().buildListTile(leadingIcon:Icons.backpack_sharp,
                          voidCallback: (){  Navigator.of(context).pushNamed(PedidosPendientesTienda.id) ;    },
                          title:'Pendientes' , trailing:'${ context.watch<GetPedidosProvider>().atStoreDelivered.length}' ),




                      SizedBox(height: 60,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.grey, textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                              onPressed: ()=>context.read<GetPedidosProvider>(). pickStartDate(context), child:
                              Text( 'Start date: ${DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}').year}-'
                                  '${DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}').month}-'
                                  '${DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}').day}',
                                   style:TextStyle(fontSize: 20),)

                              ,)),
                            SizedBox(width: 10,),
                            Expanded(child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey, textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                              onPressed: ()=>context.read<GetPedidosProvider>(). pickEndtDate(context),
                              child: Text( 'End date: ${DateTime.parse( '${context.watch<GetPedidosProvider>().toDate}').year}-'
                                  '${DateTime.parse( '${context.watch<GetPedidosProvider>().toDate}').month}-'
                                  '${DateTime.parse( '${context.watch<GetPedidosProvider>().toDate}').day}',
                                   style:TextStyle(fontSize: 20),),)),
                          ],),) ,
                    ]),
              ),
            ],
          ),
        )
    );
  }
}



