import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:flutter/material.dart';

class ListSupportBottom extends StatelessWidget {
  final double height;

  final List<LocalSupport> localSupports;

  final List<NationalSupport> nationalSupport;

  final Future<void> Function(LocalSupport localSupport) navigateToLocalSupport;

  const ListSupportBottom({
    Key key,
    @required this.height,
    @required this.localSupports,
    @required this.nationalSupport,
    @required this.navigateToLocalSupport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(1.0, 6.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      height: height,
      child: DefaultTabController(
        length: 2,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leadingWidth: 0,
              titleSpacing: 0,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Color(0xff010A09),
                unselectedLabelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: 'Suporte Local',
                  ),
                  Tab(
                    text: 'Suporte Nacional',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListView.builder(
                  itemCount: localSupports?.length ?? 0,
                  itemBuilder: (context, index) => ListLocalSuportItem(
                    localSupports[index],
                    navigateToLocalSupport,
                  ),
                ),
                ListView.builder(
                  itemCount: nationalSupport?.length ?? 0,
                  itemBuilder: (context, index) =>
                      ListNationalSuportItem(nationalSupport[index]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListLocalSuportItem extends StatelessWidget {
  final LocalSupport localSupport;
  final Function(LocalSupport localSupport) navigateToLocalSupport;

  const ListLocalSuportItem(this.localSupport, this.navigateToLocalSupport,
      {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await navigateToLocalSupport.call(localSupport);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                    ),
                    Text(
                      localSupport.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            localSupport.distance.toStringAsFixed(1),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            'KM',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${localSupport.address}, Bairro: ${localSupport.neighborhood} ${localSupport.complement ?? ''}',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(
                                '${localSupport.category.description}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 10,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListNationalSuportItem extends StatelessWidget {
  final NationalSupport nationalSupport;

  const ListNationalSuportItem(this.nationalSupport, {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '${nationalSupport.description}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('${nationalSupport.phoneNumber}',
                style: TextStyle(fontSize: 16))
          ]),
        ),
      ],
    );
  }
}
