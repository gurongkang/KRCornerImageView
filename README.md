# KRCornerImageView

## To Do
* 支持 CocoaPods
* swift  版本
* 底层依赖图片库可配置

## 使用

本项目依赖于SDWebImage

导入项目中的 CornerImageView 文件夹


## 圆角问题

在实际的开发中经常需要切圆角的展示，在只有一个或者少数几个的时候我们可以采用

```objc
imageView.layer.corner = 10
iamgeView.layer.masksToBounds = true;
```

这种方式来处理圆角没有任何问题。


但当一屏是一个UITableView 的时候，每个cell都有一个圆角图片，如图所示。

<img src="https://github.com/gurongkang/KRCornerImageView/raw/master/images/cell_corner.jpg" width="320">

在滑动的时候就会非常卡顿，因为切圆角的时候layer.masksToBounds 会导致**离屏渲染**.（相关优化方法可见https://blog.ibireme.com/2015/11/12/smooth_user_interfaces_for_ios/ ）

因此网上有些方案通过不执行masksToBounds方法来解决这个问题，最终是指标不治本，使用起来及其不方便。而且在TableView滑动的时候会重复执行方法，优化不彻底。


## 解决方法

大部分的方法无非通过以下三点：

**1.空间换时间**
**2.异步线程**
**3.缓存**


切圆角的情景一般是针对网络图片，本地的需要的圆角的时候可以直接让UI 设计师进行处理。因此可以通过学习SDWebImage 的思路。

1. 首先请求网络图片
2. 请求到图片以后开个异步线程把图片切圆角，进行相关的处理比如描边等操作，然后赋给ImageView
3. 切完圆角以后把图片缓存起来，缓存的key通过图片的url、圆角的角度、描边的颜色和宽度确定。
4. 下次再获取图片的时候可以直接去缓存中获取。

通过这样的方法切圆角只是消耗一次性能，下次获取的时候直接从缓存中取。








