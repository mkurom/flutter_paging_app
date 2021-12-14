import 'package:flutter/material.dart';

class PagingPage extends StatefulWidget {
  @override
  _PagingPageState createState() => _PagingPageState();
}

class _PagingPageState extends State<PagingPage> {
  /// state
  // 選択しているページ番号
  int _selectedIndex = 0;
  // 最大アイテム数 / 10 (1ページの表示数)
  int _maxPage = 0;
  // 全アイテム数
  int _itemCount = 0;
  // ボタンサイズ
  double _buttonSize = 26;

  Color _selectedColor = Colors.green;
  Color _notSelectColor = Colors.amber;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paging Sample'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text('コンテンツ'),
                ),
              ),
            ),
            _pagenationBottombar(),
          ],
        ),
      ),
    );
  }

  Widget _pagenationButton(Color color, Function function, Widget widget) {
    return Container(
      height: _buttonSize,
      width: _buttonSize,
      color: color,
      margin: const EdgeInsets.all(2),
      child: InkWell(
        onTap: () {
          setState(
            () {
              function();
            },
          );
        },
        child: Center(child: widget),
      ),
    );
  }

  Widget _pagenationBottombar() {
    // サンプル数
    _itemCount = 100;
    // ページの最大数
    _maxPage = ((_itemCount / 10) == 0 ? 1 : (_itemCount / 10)).ceil();

    // 現在のページから前後1ページを表示する
    // ただし、先頭、末尾の時は前後1個多く表示する
    final beforecurrentPageCount = (_selectedIndex == _maxPage - 1) ? 2 : 1;
    final startPageToEndPageCount = beforecurrentPageCount * 2 + 1;

    final startpage =
        1 < _selectedIndex ? _selectedIndex - beforecurrentPageCount : 0;
    final endpage = startpage + startPageToEndPageCount < _maxPage
        ? startpage + startPageToEndPageCount
        : _maxPage;

    List<Widget> _widget = [];

    // 先頭の矢印
    if (_selectedIndex != 0 && _maxPage > 1) {
      _widget.add(
        _pagenationButton(
          Colors.blue,
          () {
            _selectedIndex--;
          },
          Icon(Icons.arrow_back_ios_new_outlined),
        ),
      );
    }

    // 1と「・・・」
    if (_selectedIndex > 0) {
      if (startpage > 0) {
        _widget.add(
          _pagenationButton(
            _notSelectColor,
            () {
              _selectedIndex = 0;
            },
            Text(
              '1',
            ),
          ),
        );
      }
      if (_selectedIndex > 2) {
        _widget.add(
          Container(
            height: _buttonSize,
            width: _buttonSize,
            color: Colors.transparent,
            margin: const EdgeInsets.all(2),
            child: const Center(
              child: Icon(
                Icons.keyboard_control_outlined,
                color: Colors.black,
              ),
            ),
          ),
        );
      }
    }

    for (var i = startpage; i < endpage; i++) {
      _widget.add(
        _pagenationButton(
          (i == _selectedIndex) ? _selectedColor : _notSelectColor,
          () {
            _selectedIndex = i;
          },
          Text(
            (i + 1).toString(),
          ),
        ),
      );
    }

    // _maxPageと「・・・」
    if (_maxPage - 1 > _selectedIndex) {
      if (_maxPage - 3 > _selectedIndex) {
        _widget.add(
          Container(
            height: _buttonSize,
            width: _buttonSize,
            color: Colors.transparent,
            margin: const EdgeInsets.all(2),
            child: const Center(
              child: Icon(
                Icons.keyboard_control_outlined,
                color: Colors.black,
              ),
            ),
          ),
        );
      }

      if (_maxPage > endpage) {
        _widget.add(
          _pagenationButton(
            _notSelectColor,
            () {
              _selectedIndex = _maxPage - 1;
            },
            Text(
              _maxPage.toString(),
            ),
          ),
        );
      }
    }

    // 末尾の矢印
    if (_selectedIndex != _maxPage - 1 && _maxPage > 1) {
      _widget.add(
        _pagenationButton(
          Colors.blue,
          () {
            _selectedIndex++;
          },
          Icon(Icons.arrow_forward_ios_outlined),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _widget,
    );
  }
}
