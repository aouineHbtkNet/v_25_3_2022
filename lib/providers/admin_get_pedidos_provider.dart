import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/apis/admin_get_all_orders.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:http/http.dart' as http;

class GetPedidosProvider extends ChangeNotifier {

  int id=0;
  getId( int num ) async {
    id =num;
  }

  //========================date section=================== Start ===============================
  DateTime  fromDate = DateTime.now().subtract(Duration(days:1));
  DateTime  toDate = DateTime.now();

  pickStartDate(BuildContext context) async {
    await pickDateStart(context);
    notifyListeners();
  }
  pickEndtDate(BuildContext context) async {
    await pickDateEnd(context);
    notifyListeners();
  }

  Future  pickDateStart( BuildContext context ) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: fromDate ,
        firstDate:DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5) );
    if(newDate==null)return;
    fromDate= newDate;
    notifyListeners();
  }

  Future  pickDateEnd( BuildContext context ) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: toDate ,
        firstDate:DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5) );
    if(newDate==null)return;
    toDate= newDate;
    notifyListeners();
  }
  int durationInDays =0 ;
  getDifference(){durationInDays = fromDate.difference(toDate).inDays;}
  //========================date section=================== End  ===============================

  //========================get  _allOrdersList =================== satrt   ===============================

  List<dynamic>_allOrdersList  =[];
  List<dynamic> get allOrdersList =>_allOrdersList;
  getAllOrderList () async {
    _allOrdersList=  await GetAllOrdersAdmin().getAllOrderAdmin();
    notifyListeners();
  }
  //========================get  _allOrdersList =================== End  ===============================


// =========================================================================en la tienda->received

  List<dynamic>_atStoreReceived  =[];
  List<dynamic> get atStoreReceived =>_atStoreReceived;
  getAtStoreReceived ()  async {
    _atStoreReceived =  await allOrdersList.where((order) => order['manera_entrega']=='A la tienda'). where((order) => order['status']=='Recibido').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
        notifyListeners();
  }

// =========================================================================en la tienda->Being prepared
  List<dynamic>_atStoreBeingPrepared  =[];
  List<dynamic> get atStoreBeingPrepared =>_atStoreBeingPrepared;

  getAtStoreBeingPrepared ()  async {
    _atStoreBeingPrepared  =  await allOrdersList.where((order) => order['manera_entrega']=='A la tienda'). where((order) => order['status']=='En preparacion').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }


// =========================================================================en la tienda->En camino
  List<dynamic>_atStoreReady  =[];
  List<dynamic> get atStoreReady  =>_atStoreReady;

  getAtStoreReady ()  async {
    _atStoreReady =  await allOrdersList.where((order) => order['manera_entrega']=='A la tienda'). where((order) => order['status']=='Listo').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }


// =========================================================================en la tienda->Entregado
  List<dynamic>_atStoreDelivered =[];
  List<dynamic> get atStoreDelivered =>_atStoreDelivered;

  getAtStoreDelivered ()  async {
    _atStoreDelivered= await  allOrdersList.where((order) => order['manera_entrega']=='A la tienda'). where((order) => order['status']=='Entregado').
    where((order) =>  DateTime.parse( order['created_at'])
        .isAfter(fromDate)
        && DateTime.parse( order['created_at']).isBefore(toDate)).toList();
    notifyListeners();
  }










//=====================================================Filtering with api start ============
  List<dynamic>_orderswithDetailsListFiltered  =[];
  List<dynamic> get orderswithDetailsListFiltered =>_orderswithDetailsListFiltered;

  getOrderWithDetailList (int id) async {
    _orderswithDetailsListFiltered =  await GetAllOrdersAdmin().getOrderWithDetailsAdmin(id);
    notifyListeners();
  }

//======================================== Filtering with api end============================================










  List<dynamic>_allOrders  =[];
  List<dynamic> get allOrders =>_allOrders;

  getOrderWithDetailLisNoFilter()  async {
    _allOrders =  await GetAllOrdersAdmin().getOrderWithDetailsAdminNoFilter();
    notifyListeners();
  }




  List<dynamic>_selectedOrderById =[];
  List<dynamic> get selectedOrderById =>_selectedOrderById;


  getselectedOrderById()  async {
    _selectedOrderById= await allOrders.where((order) => order['order_id']==id).toList();
    notifyListeners();
  }




init() async{
   _allOrders=[];
   _allOrdersList=  await GetAllOrdersAdmin().getAllOrderAdmin();
   notifyListeners();
}





























}