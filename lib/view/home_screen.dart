import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobigic_interview/controllers/home_controller.dart';
import 'package:mobigic_interview/utils/constant.dart';
import 'package:mobigic_interview/view/components/common_button.dart';
import 'package:mobigic_interview/view/components/common_text.dart';
import 'package:mobigic_interview/view/components/common_textField.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeCon = Get.put<HomeController>(HomeController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: "Mobigic",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AppColor.primaryBgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      con: homeCon.numRowsController,
                      keyBoardType: TextInputType.number,
                      hintText: "Enter row number",
                      validator: (v) {
                        if (v?.isEmpty ?? false) {
                          return "Please enter rows";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CommonTextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      con: homeCon.numColsController,
                      keyBoardType: TextInputType.number,
                      hintText: "Enter colum number",
                      validator: (v) {
                        if (v?.isEmpty ?? false) {
                          return "Please enter columns";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CommonButton(
                  label: "Create Grid",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      homeCon.searchController.clear();
                      homeCon.createGrid();
                    }
                  }),
              const SizedBox(height: 10),
              CommonTextField(
                  con: homeCon.searchController,
                  hintText: "Search",
                  onChanged: (v) {
                    homeCon.search.value = v ?? "";
                    // homeCon.searchAndHighlight();
                    // homeCon.update();
                  }),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: homeCon.grid.isNotEmpty ? homeCon.grid[0].length : 1,
                    ),
                    itemCount: homeCon.grid.length * (homeCon.grid.isNotEmpty ? homeCon.grid[0].length : 1),
                    itemBuilder: (context, index) {
                      int row = index ~/ (homeCon.grid.isNotEmpty ? homeCon.grid[0].length : 1);
                      int col = index % (homeCon.grid.isNotEmpty ? homeCon.grid[0].length : 1);

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(
                          () => Center(
                            child: Text.rich(
                              TextSpan(
                                children: homeCon.highlightOccurrences(homeCon.grid[row][col], homeCon.search.value),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
