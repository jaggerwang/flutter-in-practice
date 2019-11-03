import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../pages/pages.dart';

class JWFDDrawer extends StatefulWidget {
  @override
  JWFDDrawerState createState() => JWFDDrawerState();
}

class JWFDDrawerState extends State<JWFDDrawer> {
  static PackageInfo _packageInfo;
  static var _isHome = true;
  static final _panels = [
    {
      'title': 'Widget',
      'isExpanded': false,
      'items': [
        {
          'title': 'Basic',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => WidgetBasicPage(),
        },
        {
          'title': 'Material',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => WidgetMaterialPage(),
        },
      ],
    },
    {
      'title': 'Layout',
      'isExpanded': false,
      'items': [
        {
          'title': 'Horizontal and Vertical Align',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => HoriVertAlignPage(),
        },
        {
          'title': 'Horizontal and Vertical Sizing',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => HoriVertSizingPage(),
        },
        {
          'title': 'Horizontal and Vertical Packing',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => HoriVertPackingPage(),
        },
        {
          'title': 'Container',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => ContainerPage(),
        },
        {
          'title': 'Grid View Extent',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => GridViewExtentPage(),
        },
        {
          'title': 'Grid View Count',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => GridViewCountPage(),
        },
        {
          'title': 'List View',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => ListViewPage(),
        },
        {
          'title': 'Stack',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => StackPage(),
        },
        {
          'title': 'Card',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => CardPage(),
        },
        {
          'title': 'Pavlova',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => PavlovaPage(),
        },
        {
          'title': 'Lake',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => LakePage(),
        },
      ],
    },
    {
      'title': 'Ineraction',
      'isExpanded': false,
      'items': [
        {
          'title': 'Favorite Lake',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => FavoriteLakePage(),
        },
        {
          'title': 'Refresh Indicator',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => RefreshIndicatorPage(),
        },
        {
          'title': 'Silver App Bar',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => SilverAppBarScrollPage(),
        },
      ],
    },
    {
      'title': 'Asset',
      'isExpanded': false,
      'items': [],
    },
    {
      'title': 'Navigation',
      'isExpanded': false,
      'items': [
        {
          'title': 'Basic',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => BasicNavigationPage(),
        },
        {
          'title': 'Named Route',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => NamedRoutePage(),
        },
        {
          'title': 'Send Data',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => SendDataPage(),
        },
        {
          'title': 'Return Data',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => ReturnDataPage(),
        },
        {
          'title': 'Hero',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => HeroPage(),
        },
        {
          'title': 'Nested',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => NestedNavigationPage(),
        },
        {
          'title': 'TabBar',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => TabBarNavigationPage(),
        },
      ],
    },
    {
      'title': 'State',
      'isExpanded': false,
      'items': [
        {
          'title': 'Tabbox',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => TapboxPage(),
        },
        {
          'title': 'Counter',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => StateCounterPage(),
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        _packageInfo = packageInfo;
      });
    });
  }

  void _resetPanels() {
    _panels.forEach((panel) {
      panel['isExpanded'] = false;
      (panel['items'] as List).forEach((item) {
        item['isSelected'] = false;
      });
    });
  }

  void _goHome() {
    _isHome = true;

    _resetPanels();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false);
  }

  void _onExpand(index, isExpanded) {
    _resetPanels();

    _panels[index]['isExpanded'] = !isExpanded;

    setState(() {});
  }

  void _onSelected(Map<String, Object> panel, Map<String, Object> item) {
    _isHome = false;

    _resetPanels();

    panel['isExpanded'] = true;
    item['isSelected'] = true;

    Navigator.of(context).push(MaterialPageRoute(builder: item['pageBuilder']));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Center(
              child: Text(
                'Flutter Demo',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            onTap: _goHome,
            title: Text(
              'Home',
              style: TextStyle(fontSize: 16),
            ),
            selected: _isHome,
            dense: true,
          ),
          ExpansionPanelList(
            expansionCallback: _onExpand,
            children: _panels
                .asMap()
                .map(
                  (index, panel) => MapEntry(
                    index,
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) => ListTile(
                        onTap: () => _onExpand(index, panel['isExpanded']),
                        title: Text(
                          panel['title'],
                          style: TextStyle(fontSize: 16),
                        ),
                        selected: isExpanded,
                        dense: true,
                      ),
                      body: Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          children: (panel['items'] as List)
                              .map((item) => ListTile(
                                    onTap: () => _onSelected(panel, item),
                                    title: Text(item['title']),
                                    selected: item['isSelected'],
                                    dense: true,
                                    enabled: item['pageBuilder'] != null,
                                  ))
                              .toList(),
                        ),
                      ),
                      isExpanded: panel['isExpanded'],
                    ),
                  ),
                )
                .values
                .toList(),
          ),
          if (_packageInfo != null)
            AboutListTile(
              applicationName: _packageInfo.appName,
              applicationLegalese: 'Copyright © Jagger Wang',
              applicationVersion: _packageInfo.version,
            ),
        ],
      ),
    );
  }
}
