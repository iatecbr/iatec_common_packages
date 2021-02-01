import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedLocalWidget extends StatelessWidget {
  final LocalSupport localSupport;
  final VoidCallback close;

  const SelectedLocalWidget({Key key, @required this.localSupport, this.close})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      child: Icon(
                        Icons.pin_drop,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      localSupport.name,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            '${localSupport.distance.toStringAsFixed(1)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'KM',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
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
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
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
                                      horizontal: 10, vertical: 2),
                                  child: Text(
                                    '${localSupport.category.description}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        if (close != null)
          Positioned(
            right: 5,
            top: 5,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black54,
              ),
              onPressed: close,
            ),
          ),
        Positioned(
          bottom: 5,
          right: 5,
          child: IconButton(
              icon: Icon(
                Icons.drive_eta,
                color: Colors.black54,
              ),
              onPressed: () async {
                var mapSchema =
                    'geo:${localSupport.latitude},${localSupport.longitude}';
                if (await canLaunch(mapSchema)) {
                  await launch(mapSchema);
                } else {
                  throw 'Could not launch $mapSchema';
                }
              }),
        )
      ],
    );
  }
}
