import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pathfinding/api/table_client.dart';
import 'package:pathfinding/models/result.dart';

import '../algorithms/astar.dart';
import '../models/tables.dart';
import '../screens/result_list_page.dart';

class HomePageController extends GetxController {
  final dio = Dio();
  late Tables tables = Tables.empty();
  List<List<Point<int>>> paths = [];

  String baseUrl = '';

  RxInt dataCalculationProgress = 0.obs;

  RxBool isDataDownloading = false.obs;
  RxBool isDataProcessing = false.obs;
  RxBool isProcessFinished = false.obs;
  RxBool isSendingResults = false.obs;

  RxString getError = ''.obs;
  RxString postError = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> getDataApi() async {
    if (TablesClient.isUrlValid(baseUrl)) {
      final client = TablesClient(dio, baseUrl: baseUrl);

      try {
        isDataDownloading(true);

        await client.getTables().then((data) async {
          if (data.data.isNotEmpty) {
            tables = data;
            await _processData();
          } else {
            isDataDownloading(false);
            getError('No data available');
          }
        });
      } catch (e) {
        getError('URL is invalid');
        isDataDownloading(false);
      }
    } else {
      getError('URL is invalid');
    }
  }

  Future<void> sendDataApi() async {
    List<Result> results = [];

    final client = TablesClient(dio, baseUrl: baseUrl);

    try {
      isSendingResults(true);
      for (DataItem table in tables.data) {
        int index = tables.data.indexOf(table);
        String coordinatePath = '';

        List<Step> steps = [];

        for (var step in paths[index]) {
          coordinatePath += '(${step.x},${step.y})';
          if (paths[index].last != step) {
            coordinatePath += '->';
          }
        }

        for (var point in paths[index]) {
          steps.add(Step(x: point.x.toString(), y: point.y.toString()));
        }

        ResultData resultData = ResultData(steps: steps, path: coordinatePath);

        Result result = Result(id: table.id, result: resultData);
        results.add(result);
      }
      await client.sendResults(results);

      Get.to(ResultListPage(
        grids: tables.data,
        pathes: paths,
      ));
      isSendingResults(false);
      isProcessFinished(false);
      isDataProcessing(false);
      isDataDownloading(false);
      dataCalculationProgress(0);
    } catch (e) {
      postError(e.toString());
      isSendingResults(false);
    }
  }

  Future<void> _processData() async {
    paths.clear();
    isDataProcessing(true);

    for (DataItem item in tables.data) {
      dataCalculationProgress(
          (100 / (tables.data.length + 1)).round() * (paths.length + 1));
      AStar grid = AStar(
        dimensionLength: item.field.length,
        start: item.start.getPoint(),
        end: item.end.getPoint(),
        barriers: item.getBarriers(),
      );

      final List<Point<int>> path = List.from(await grid.findThePath());
      paths.add(path);
    }
    dataCalculationProgress(100);

    isProcessFinished(true);
  }
}
