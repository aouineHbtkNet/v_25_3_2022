import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/apis/modify_status.dart';
import 'package:simo_v_7_0_1/apis/user_get_orders.dart';
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
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

class PedidosEnPreparcionTienda extends StatefulWidget {
  static const String id = '/PedidosEnPreparcionTienda';
  const PedidosEnPreparcionTienda({Key? key}) : super(key: key);

  @override
  _PedidosEnPreparcionTiendaState createState() => _PedidosEnPreparcionTiendaState();
}

class _PedidosEnPreparcionTiendaState extends State<PedidosEnPreparcionTienda> {



  bool iSloading =false;
  List statusList = [ 'Listo', 'Entregado'];
  String? selectedStatus;
  @override
  void initState() {
    context.read<GetPedidosProvider>().getOrderWithDetailLisNoFilter() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List allOrdersList= context.watch<GetPedidosProvider>().allOrders;

    return Scaffold(
        body: SafeArea(
          child:Column(

            children: [
              PopUpMenuWidgetAdmins(putArrow: true, callbackArrow: () {Navigator.of(context).pop();},),
              SizedBox(height: 10,),
              Padding(padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child:  Text('Entrega en la Tienda/Listos ',
                            style: TextStyle(fontSize: 24,color: Colors.blue),),)),)),
              Padding(padding: const EdgeInsets.all(8.0),
                  child: Container(width: double.infinity,
                    child: Padding(padding: const EdgeInsets.all(8.0),
                        child: Center(child:  Text( 'Start date: ${DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}').year}-'
                            '${DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}').month}-'
                            '${DateTime.parse( '${context.watch<GetPedidosProvider>().fromDate}').day}',
                          style:TextStyle(fontSize: 20),)
                        )),)),
              Expanded(
                child: ListView.builder(
                    itemCount:context.watch<GetPedidosProvider>().atStoreBeingPrepared.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          // color: Color(0xffE3E3E3),
                          elevation: 20,
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Text('  ${index+1}/${ context.watch<GetPedidosProvider>().atStoreBeingPrepared.length}',
                                style: TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),),
                              Divider(thickness: 2,color: Colors.blueGrey,),


                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal, child: Row( children: [
                                Text(' Numero del pedido : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                Text('${context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['id']}',style: TextStyle(fontSize: 24),),],),
                              ),
                              Divider(thickness: 2,color: Colors.blueGrey,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal, child: Row(children: [
                                Text(' Cliente : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                Text(' ${context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['get_order_id_for_order_model']['name']}',style: TextStyle(fontSize: 24),),],),
                              ),
                              Divider(thickness: 2,color: Colors.blueGrey,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal, child: Row(children: [
                                Text('Direccion : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                Text(' ${context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['get_order_id_for_order_model']['address']}',style: TextStyle(fontSize: 24),),
                              ],),
                              ),
                              Divider(thickness: 2,color: Colors.blueGrey,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal, child: Row(children: [
                                Text('Cel : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                Text(' ${context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['get_order_id_for_order_model']['mobile_phone']}',style: TextStyle(fontSize: 24),),
                              ],),
                              ),
                              Divider(thickness: 2,color: Colors.blueGrey,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal, child: Row(children: [
                                Text(' Fecha : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                Text('${DateTime.parse(context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['created_at']).year }-'
                                    '${DateTime.parse(context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['created_at']).month }-'
                                    '${DateTime.parse(context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['created_at']).day }-'
                                    '${DateTime.parse(context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['created_at']).hour }h-'
                                    '${DateTime.parse(context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['created_at']).minute }min'
                                  ,style: TextStyle(fontSize: 24),),],),
                              ),
                              Divider(thickness: 2,color: Colors.blueGrey,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal, child: Row(children: [
                                Text('Total a pagar  : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                Text(' ${context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['grand_delivery_fees_in']}\$',style: TextStyle(fontSize: 24),),
                              ],),
                              ),
                              Divider(thickness: 2,color: Colors.blueGrey,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal, child: Row(children: [
                                Text('Manera de pago  : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                Text(' ${context.watch<GetPedidosProvider>().atStoreBeingPrepared[index]['manera_pago']}',style: TextStyle(fontSize: 24),),
                              ],),
                              ),
                              Divider(thickness: 2,color: Colors.blueGrey,),






                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [ElevatedButton(style: ElevatedButton.styleFrom(primary: Color(0xff009B77),
                                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                                    onPressed: ()async {

                                      int orderId = context.read<GetPedidosProvider>().atStoreBeingPrepared[index]['id'];
                                      List selectedOrder = allOrdersList.where((order) => order['order_id']==orderId).toList();
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          constraints:BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.7),
                                          context: context,
                                          builder: (context) {
                                            return ListView.builder(
                                              itemCount:selectedOrder.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Column(
                                                  children: [
                                                    SizedBox(height: 10,),
                                                    Divider(thickness: 2,color: Colors.blueGrey,),
                                                    Text('  ${index+1}/${ selectedOrder.length}',
                                                      style: TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),),
                                                    Divider(thickness: 2,color: Colors.blueGrey,),


                                                    SizedBox(height: 10,),
                                                    Padding(padding: const EdgeInsets.all(14.0),
                                                      child: Container(
                                                        height:200,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: NetworkImage( 'https://hbtknet.com/storage/notes/${selectedOrder[index]['product']['foto_producto']}'),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal, child: Row( children: [
                                                      Text(' ID : ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                                      Text('${selectedOrder[index]['product']['id']}',style: TextStyle(fontSize: 24),),],),
                                                    ),
                                                    SizedBox(height: 10,),

                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal, child: Row( children: [
                                                      Text('Nombre: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                                      Text('${selectedOrder[index]['product']['nombre_producto']}',style: TextStyle(fontSize: 24),),],),
                                                    ),
                                                    SizedBox(height: 10,),

                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal, child: Row( children: [
                                                      Text('Marca: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                                      Text('${selectedOrder[index]['product']['marca']}',style: TextStyle(fontSize: 24),),],),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal, child: Row( children: [
                                                      Text('Contenido: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                                      Text('${selectedOrder[index]['product']['contenido']}',style: TextStyle(fontSize: 24),),],),
                                                    ),
                                                    SizedBox(height: 10,),

                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal, child: Row( children: [
                                                      Text('Precio: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                                      Text('${selectedOrder[index]['product']['precio_ahora']}\$',style: TextStyle(fontSize: 24),),],),
                                                    ),
                                                    SizedBox(height: 10,),

                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal, child: Row( children: [
                                                      Text('Cantidad: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                                      Text('${selectedOrder[index]['qty']}',style: TextStyle(fontSize: 24),),],),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Text('Descripcion: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                                    SizedBox(height: 10,),
                                                    Text('${selectedOrder[index]['product']['descripcion']}',style: TextStyle(fontSize: 24),),
                                                    SizedBox(height: 10,),


                                                  ],); },
                                            );});},
                                    child:Text('Ver el carito'),),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff009B77),
                                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      onPressed: () async{
                                        setState(() {iSloading=true;});
                                        int orderId = context.read<GetPedidosProvider>().atStoreBeingPrepared[index]['id'];
                                        await ModifyStatus().modifySatatus(orderId,'Listo');
                                        await context.read<GetPedidosProvider>().getAllOrderList();
                                        setState(() {iSloading=false;});

                                      },
                                      child:iSloading==false? Text('Listo'):Text('Loading.......'),
                                    )],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }











}
