//
//  ResultView.m
//  ScreenshotDemo
//
//  Created by xiaoming han on 16/11/2.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGSize size = self.bounds.size;
    CGFloat topMargin = 15;
   
    NSString *distance = [NSString stringWithFormat:@"%.2f 公里", self.distance / 1000.0];
    [self drawString:distance inRect:CGRectMake(0, topMargin, size.width, size.height / 2.0) fontSize:28 color:[UIColor blackColor]];
    
    // line
    CGPoint aPoints[2];//坐标点
    aPoints[0] = CGPointMake(10, size.height / 2.0);//坐标1
    aPoints[1] = CGPointMake(size.width - 10, size.height / 2.0);//坐标2
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    //
    CGFloat subItemY = size.height / 2.0 + 10;
    CGFloat subItemMargin = 20;
    
    int h = self.duration / 3600;
    int m = ((int)self.duration % 3600) / 60;
    int s = ((int)self.duration % 3600) % 60;
    NSString *duration = [NSString stringWithFormat:@"%02d:%02d:%02d", h,m,s];
    
    [self drawString:duration inRect:CGRectMake(0, subItemY, size.width / 3.0, size.height / 2.0) fontSize:18 color:[UIColor blackColor]];
    [self drawString:@"时长" inRect:CGRectMake(0, subItemY+subItemMargin, size.width / 3.0, size.height / 2.0)fontSize:18 color:[UIColor grayColor]];
    
    int pm = self.pace / 60;
    int ps = ((int)self.pace % 60);
    NSString *pace = [NSString stringWithFormat:@"%d'%d", pm,ps];
    [self drawString:pace inRect:CGRectMake(size.width / 3.0, subItemY, size.width / 3.0, size.height / 2.0) fontSize:18 color:[UIColor blackColor]];
    
    [self drawString:@"平均配速" inRect:CGRectMake(size.width / 3.0, subItemY+subItemMargin, size.width / 3.0, size.height / 2.0)fontSize:18 color:[UIColor grayColor]];
    
    
    NSString *calorie = [NSString stringWithFormat:@"%.1f", self.calorie];
    [self drawString:calorie inRect:CGRectMake(size.width / 3.0 * 2, subItemY, size.width / 3.0, size.height / 2.0) fontSize:18 color:[UIColor blackColor]];
    [self drawString:@"大卡" inRect:CGRectMake(size.width / 3.0 * 2, subItemY+subItemMargin, size.width / 3.0, size.height / 2.0)fontSize:18 color:[UIColor grayColor]];
    
}

- (void)drawString:(NSString *)string inRect:(CGRect)rect fontSize:(CGFloat)fontSize color:(UIColor *)color
{
    if (color == nil)
    {
        color = [UIColor blackColor];
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    
    [string drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName:style}];
}

@end
