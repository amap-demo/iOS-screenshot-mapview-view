本工程为基于高德地图iOS SDK进行封装，实现了对MapView以及其上的子view进行截图的功能。
## 前述 ##
- [高德官网申请Key](http://lbs.amap.com/dev/#/).
- 阅读[开发指南](http://lbs.amap.com/api/ios-sdk/summary/).
- 工程基于iOS 3D地图SDK实现

## 功能描述 ##
对MapView以及其上的子view进行截图。

## 核心类/接口 ##
| 类    | 接口  | 说明   | 版本  |
| -----|:-----:|:-----:|:-----:|
| AMapSearchAPI	| - (UIImage *)takeSnapshotInRect:(CGRect)rect; | 在指定区域内截图(默认会包含该区域内的annotationView) | v4.0.0 |

## 核心难点 ##
- objective-c
```
/*截图*/
- (void)captureAction
{
    // 获取mapView截图
    UIImage *mapImage = [self.mapView takeSnapshotInRect:self.mapView.bounds];
    
    // 对resultView进行截图
    CGSize s = self.resultView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [self.resultView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // union image
    CGSize imageSize = self.mapView.bounds.size;

    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    [mapImage drawInRect:self.mapView.bounds];
    [resultImage drawInRect:self.resultView.frame];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // show the image
    [self transitionToDetailWithImage:image];
}
```
-swift
```
    func captureAction() {
        // map image
        let mapImage = self.mapView.takeSnapshot(in: self.mapView.bounds)
        // result image
        let s = self.resultView.bounds.size
        UIGraphicsBeginImageContextWithOptions(s, false, UIScreen.main.scale)
        self.resultView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // union image
        let imageSize = self.mapView.bounds.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        mapImage?.draw(in: self.mapView.bounds)
        resultImage.draw(in: self.resultView.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.transitionToDetail(with: image)
    }
```
