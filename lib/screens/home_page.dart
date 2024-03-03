import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_page_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomePageController());
  final TextEditingController textFieldUrl =
      TextEditingController(text: 'https://flutter.webspark.dev/flutter/api');

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Obx(
        () => controller.isDataDownloading.value
            ? Scaffold(
                appBar: AppBar(
                  title: const Text('Process page'),
                ),
                body: Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: _buildDataProcessingBody(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Home page'),
                ),
                body: Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: _buildBody(),
                ),
              ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Set valid API base URL in order to continue'),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Icon(Icons.compare_arrows),
            ),
            Expanded(
              flex: 7,
              child: TextField(
                controller: textFieldUrl,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          controller.getError.value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            controller.baseUrl = textFieldUrl.text;
            controller.getDataApi();
          },
          child: const Text('Start counting process'),
        ),
      ],
    );
  }

  Widget _buildDataProcessingBody() {
    return Center(
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              controller.isSendingResults.value
                  ? 'Sending results to server'
                  : controller.isProcessFinished.value
                      ? 'All calculations has finished, you can send your results to server'
                      : (controller.isDataProcessing.value
                          ? 'Calculations in progress'
                          : 'Get data by server'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            controller.isSendingResults.value
                ? const SizedBox.shrink()
                : Text(
                    '${controller.dataCalculationProgress.value.toString()}%',
                    style: const TextStyle(fontSize: 16),
                  ),
            const SizedBox(height: 16),
            const SizedBox(
              height: 200.0,
              width: 200.0,
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 8.0,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              controller.postError.value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: controller.isProcessFinished.value &&
                      !controller.isSendingResults.value
                  ? () {
                      controller.sendDataApi();
                    }
                  : null,
              child: const Text('Send results to server'),
            ),
          ],
        ),
      ),
    );
  }
}
