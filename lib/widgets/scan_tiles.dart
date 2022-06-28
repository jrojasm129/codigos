import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.productos;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: ( _, i ) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarProductoPorId(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(Icons.inventory, 
            color: Theme.of(context).primaryColor 
          ),
          title: Text( scans[i].name?? 'Undefined' ),
          subtitle: Text( scans[i].code ?? 'undefined'),
          trailing: const Icon( Icons.keyboard_arrow_right, color: Colors.grey ),
          onTap: () => {},
        ),
      )
    );


  }
}