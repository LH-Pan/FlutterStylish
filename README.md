# STYLiSH x Flutter

## Week3 - State Management

State Management 指的是管理 Widget 狀態的一種方式，當使用者在 UI 上進行操作時，可能會需要改變 UI 元件的狀態，
例如改變按鈕選擇狀態、點選按鈕後需要改變其他文字等。這些狀態都需要使用 State 來管理。

在萬物皆 Widget 的 Flutter 中，平常呈現畫面時使用的是 StatelessWidget，但當畫面需要變動時則必須要用到含有
State 元件的 StatefulWidget，如此才能實現當某項值發生變化時，只有該狀態對象被重建，而非直接更新畫面上的所有 Widget。

首先需要先了解一下 StatefulWidget 的運作流程及可使用的 method:

1. createState(): 創建 StatefulWidget 時會看到的 method，意即這個 Widget 開始建立狀態。

```
    class DetailPage extends StatefulWidget {
        const DetailPage({super.key, required this.product});

        final ProductEntity product;

        @override
        State<DetailPage> createState() => _DetailPageState();
    }
    
    class _DetailPageState extends State<DetailPage> {

    }
```
2. initState(): 
    此 method 只會在初始化時被調用，可以用來初始化一些參數。

```
    @override
    void initState() {
        super.initState();
        // TODO
    }
```

3. didChangeDependencies(): 
    在 Widget 需要使用到其他 Widget 的資料時調用的，可以用來獲取這些資料並進行相應的處理。但執行順序不一定會等 initState() 
    結束才執行，有時會在 initState() 執行途中執行這個 method。
```
    @override
    void didChangeDependencies() {
        // TODO: implement didChangeDependencies
        super.didChangeDependencies();
    }
```
4. build(): 
    一個必須被實現的方法，用於構建和繪製 UI 元素。當 Widget 需要被渲染時，build() 方法會被調用，並且它必須回一個有效的 Widget。
    執行時，Flutter framework 會將 Widget 的狀態保存起來，以便後續比較和更新。當 Widget 的狀態發生改變時，Flutter framework 
    會再次調用 build() 方法，並將新的 Widget tree 與之前的 Widget tree 進行比較，從而計算出哪些部分需要重新繪製。

```
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: const StAppBar(),
            body: SingleChildScrollView(child: ),
        );
    }
```

5. setState(): 
    用於通知 Framework 數據已更改，此時 build() 裡面的 context 會重新建構元件，必須確保只更新必要的狀態，避免重新建構時造成不
    必要的效能虧損。

```
    int _counter = 0;

    void _incrementCounter() {
        setState(() {
            _counter++;
        });
    }
    
    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                ElevatedButton(
                   onPressed: _incrementCounter,
                   child: const Text('Increment'),
                ),
            ],
        );
    }
```

6. didUpdateWidget(Widget oldWidget): 
    只要在父元件中调用 setState()，子元件的的 didUpdateWidget() 就一定會被觸發，不管父元件傳遞給子元件的建構子參數有沒有變化。
    故可以比較新舊 Widget 的屬性，以確定是否需要更新 Widget。如果沒有變化，就不需要重新構建 Widget，因為它的內容已經是最新的了。

```
    @override
    void didUpdateWidget(ExampleWidget oldWidget) {
        super.didUpdateWidget(oldWidget);
        if (widget.text != oldWidget.text) {
            setState(() {
            _text = widget.text;
            });
        }
    } 
```
7. deactivate():
    當頁面切換(即從 active 狀態變成 inactive 狀態)時會觸發，此時 State 在視圖樹中的位置發生了變化，需要先暫時移除後添加。 當 
    Widget 被暫時移除時，Flutter Framework 會自動調用 deactivate()。在這個 method 中，可以進行一些清理操作，例如取消訂閱、關閉資源等。
    
```
@   override
    void deactivate() {
      super.deactivate();
        _subscription.cancel(); // 取消訂閱以節省資源
    }
```

8. dispose():
    當 Widget 被永久銷毀時，就會調用 dispose() 方法。這個方法通常用於清理 Widget 佔用的資源，例如取消訂閱、關閉資源等。

以上為 State 中可調用的 method，可以視使用情境在符合的時機調用並以此管理整個 Widget 的狀態。
