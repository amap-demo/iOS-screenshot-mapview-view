//
//  ResultView.h
//  ScreenshotDemo
//
//  Created by xiaoming han on 16/11/2.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultView : UIView

@property (nonatomic, assign) double distance; // 米
@property (nonatomic, assign) double duration; // 秒
@property (nonatomic, assign) double pace; // 每公里用时, 秒
@property (nonatomic, assign) double calorie; // 卡路里

@end
