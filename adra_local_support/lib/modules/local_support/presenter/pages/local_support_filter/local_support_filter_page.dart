import 'package:adra_design_system/adra_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iatec_localization/iatec_localization.dart';

import 'local_support_filter_controller.dart';

class LocalSupportFilterPage extends StatefulWidget {
  @override
  _LocalSupportFilterPageState createState() => _LocalSupportFilterPageState();
}

class _LocalSupportFilterPageState
    extends ModularState<LocalSupportFilterPage, LocalSupportFilterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            BackButton(
              color: ADRAColors.primary,
              onPressed: () {
                Modular.to.pop(controller.selectCategories);
              },
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffEBEEEF),
                    borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: controller.filterController,
                  onChanged: controller.setFilter,
                  decoration: InputDecoration(
                    hintText: 'localSupportFilterPage.searchLanguage'.i18n(),
                    border: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ),
        elevation: 0,
        leading: Container(),
        leadingWidth: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Observer(
            builder: (BuildContext context) {
              if (controller.hasError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('localSupportFilterPage.error'.i18n()),
                      CancelButton(
                          title: 'localSupportFilterPage.refresh'.i18n(),
                          onPressed: () async {
                            await controller.refreshCategories();
                          })
                    ],
                  ),
                );
              }

              if (controller.categories == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: [
                  Container(
                      color: Color(0xffF6F9FA),
                      height: 50,
                      alignment: Alignment.center,
                      child: Observer(
                        builder: (context) => ListView.builder(
                          itemCount: controller.selectCategories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 3,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xffEBEEEF),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.selectCategories[index]
                                            .description,
                                        style: TextStyle(
                                            color: ADRAColors.primary),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.setSelectLocalCategory(
                                              controller
                                                  .selectCategories[index]);
                                        },
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      )),
                  Expanded(
                    child: Observer(builder: (_) {
                      return ListView.separated(
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  '${controller.categories[index].description}',
                                  style: TextStyle(
                                    color: ADRAColors.primary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                controller.setSelectLocalCategory(
                                    controller.categories[index]);
                              },
                            );
                          },
                          itemCount: controller.categories.length,
                          separatorBuilder: (context, int index) => Divider());
                    }),
                  ),
                ],
              );
            },
          ))
        ],
      ),
    );
  }
}
