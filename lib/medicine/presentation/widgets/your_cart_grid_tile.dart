import 'package:flutter/material.dart';

class YourCartGridTile extends StatefulWidget {
  @override
  State<YourCartGridTile> createState() => _YourCartGridTileState();
}

class _YourCartGridTileState extends State<YourCartGridTile> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 120,
                padding: EdgeInsetsDirectional.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  color: Colors.white,
                ),
                child: Image.asset(
                  'assets/images/plant_medicine-removebg-preview.png',
                  fit: BoxFit.cover,
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                color: Color(0xffE2D2B8),
              ),
              padding: EdgeInsetsDirectional.only(start: 8, bottom: 8, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'medicine name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                        fontFamily: 'CrimsonText-Regular'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '70 EGP',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'CrimsonText-Regular'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          child: Icon(
                            Icons.remove,
                            size: 24,
                          ),
                          radius: 16,
                          backgroundColor: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            if (count <= 0) {
                              count = 0;
                            } else {
                              count--;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        count <= 0 ? ' ' : '$count',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add,
                            size: 24,
                          ),
                          radius: 16,
                        ),
                        onTap: () {
                          setState(() {
                            count++;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}