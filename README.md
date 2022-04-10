# CryptoApp-SwiftBootcamp

2022/2/16 —— 2022/4/10

CryptoApp: A Swift Learning Demo 

This app was make by following a @SwiftfulThinking course on YouTube. It use MVVM Architecture, Combine, and CoreData! The cryptocurrency data that is used this app comes from a free API from CoinGecko. 

This app was developed by Nick Sarno. It uses SwiftUI and is written 100% in Swift The project benefits from multi-threading, publishers/subscibers, and data psersistance.

Tutorial url: https://www.youtube.com/watch?v=TTYKL6CfbSs&list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu



## 主要的View

### HomeView

<img src="/Users/wenzhuo/Library/Application Support/typora-user-images/image-20220410190644260.png" alt="image-20220410190644260" style="zoom: 25%;" />

<img src="/Users/wenzhuo/Library/Application Support/typora-user-images/image-20220410190924295.png" alt="image-20220410190924295" style="zoom:25%;" />

<img src="/Users/wenzhuo/Library/Application Support/typora-user-images/image-20220410191019890.png" alt="image-20220410191019890" style="zoom:25%;" />

- allCoinList数据的获取

- 按照价格、id对coin进行排序

- 数据刷新

- 搜索框及其逻辑处理

  ```swift
   func filterCoins(text:String, coins:[CoinModel])->[CoinModel]{
          guard !text.isEmpty else {
              return coins
          }
          
          let lowercasedText = text.lowercased()
          
          return coins.filter { coin in
              return coin.symbol.lowercased().contains(lowercasedText)  ||
              coin.id.lowercased().contains(lowercasedText) ||
              coin.name.lowercased().contains(lowercasedText)
          }
      }
  ```

- portfolioCoin的增删改查

- allCoinList到portfolioCoin的切换

### DetailView

<img src="/Users/wenzhuo/Library/Application Support/typora-user-images/image-20220410191452355.png" alt="image-20220410191452355" style="zoom:25%;" />

- 折线图表

### LaunchView

<img src="/Users/wenzhuo/Library/Application Support/typora-user-images/image-20220410191539877.png" alt="image-20220410191539877" style="zoom:25%;" />



## 其他技术

### Network Manager

使用Combine构建一个通用的网络请求函数

```swift
   static func download(url:URL)->AnyPublisher<Data, Error>{
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap({ try handleResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
```

### LocalFileManager

使用FileManager实现对图片资源持久化存储，以及增删改查

### HapticManager

`UINotificationFeedbackGenerator()` 震动反馈



## 最佳实践

### extension Color

统一全局的颜色，方便修改和扩展。

```swift
extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    let secondaryText = Color("SecondaryTextColor")
    let red = Color("RedColor")
    let accent = Color("AccentColor")
    let green = Color("GreenColor")
    let background = Color("BackgroundColor")
}

```

### extension PreviewProvider

方便为canvas的预览提供数据

### SwiftUI及动画

### 排序

```swift
enum SortOption{
        case coin,coinReverse,price,priceReverse,holding,holdingReverse
}
```





## 一些疑问

### 为什么最外层要用NavigationView

### UI样式顺序问题

### 一些函数、属性、方法的使用问题

- overlay
- .animation 和 with animation的使用区别
- .transition
