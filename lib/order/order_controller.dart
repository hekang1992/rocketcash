import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';

class OrderController extends GetxController {
  // 当前选中的 index
  final RxInt selectedIndex = 0.obs;

  // 每个tab对应一个 GlobalKey，用于测量位置
  final List<GlobalKey> tabKeys = List.generate(4, (_) => GlobalKey());

  // 用于存储测量后的每个tab的中心点X坐标
  final RxList<double> tabCenters = <double>[].obs;

  final model = BaseModel().obs;

  final refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final type = Get.arguments['type'] ?? '0';
    selectedIndex.value = int.parse(type);
    var otype = '';
    if (type == '1') {
      otype = '7';
    } else if (type == '2') {
      otype = '6';
    } else if (type == '3') {
      otype = '5';
    } else {
      otype = '4';
    }
    getOrderList(otype);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

extension OrderVc on OrderController {
  // 计算中心点，调用一次刷新tabCenters
  void calculateTabCenters() {
    List<double> centers = [];
    for (var key in tabKeys) {
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        centers.add(position.dx + renderBox.size.width / 2);
      } else {
        centers.add(0);
      }
    }
    tabCenters.value = centers;
  }

  //4 7 6 5
  Future getOrderList(String type) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    final dict = {'chuckled': type, 'cissco': '1'};
    try {
      final response = await HttpService().postForm('/computed/woman', dict);
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      if (code == '0' || code == '00') {
        this.model.value = model;
      }
      refreshController.refreshCompleted();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      refreshController.refreshCompleted();
    }
  }
}
