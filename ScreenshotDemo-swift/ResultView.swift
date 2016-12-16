//
//  ResultView.swift
//  ScreenshotDemo
//
//  Created by shaobin on 16/12/16.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

import UIKit

class ResultView: UIView {
    var distance : Double = 0
    var duration : Double = 0
    var pace : Double = 0
    var calorie : Double = 0
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let size = self.bounds.size
        let topMargin: CGFloat = 15
        let distance = String(format: "%.2f 公里", self.distance / 1000.0)
        self.drawString(string: distance, inRect: CGRect(x: CGFloat(0), y: topMargin, width: CGFloat(size.width), height: CGFloat(size.height / 2.0)), fontSize: 28, color: UIColor.black)
        // line
        var aPoints = [CGPoint](repeating: CGPoint.zero, count: 2)//坐标点
        aPoints[0] = CGPoint(x: CGFloat(10), y: CGFloat(size.height / 2.0))//坐标1
        aPoints[1] = CGPoint(x: CGFloat(size.width - 10), y: CGFloat(size.height / 2.0))//坐标2
        context.setStrokeColor(UIColor.gray.cgColor)
        context.addLines(between: aPoints) //添加线
        context.drawPath(using: CGPathDrawingMode.stroke) //根据坐标绘制路径
        
        
        //
        let subItemY: CGFloat = size.height / 2.0 + 10
        let subItemMargin: CGFloat = 20
        let h = self.duration / 3600
        let m = (Int(self.duration) % 3600) / 60
        let s = (Int(self.duration) % 3600) % 60
        let duration = String(format: "%02d:%02d:%02d", h, m, s)
        self.drawString(string: duration, inRect: CGRect(x: CGFloat(0), y: subItemY, width: CGFloat(size.width / 3.0), height: CGFloat(size.height / 2.0)), fontSize: 18, color: UIColor.black)
        self.drawString(string: "时长", inRect: CGRect(x: CGFloat(0), y: CGFloat(subItemY + subItemMargin), width: CGFloat(size.width / 3.0), height: CGFloat(size.height / 2.0)), fontSize: 18, color: UIColor.gray)
        
        
        let pm = Int(self.pace / 60)
        let ps = (Int(self.pace) % 60)
        let pace = "\(pm)'\(ps)"
        self.drawString(string: pace, inRect: CGRect(x: CGFloat(size.width / 3.0), y: subItemY, width: CGFloat(size.width / 3.0), height: CGFloat(size.height / 2.0)), fontSize: 18, color: UIColor.black)
        self.drawString(string: "平均配速", inRect: CGRect(x: CGFloat(size.width / 3.0), y: CGFloat(subItemY + subItemMargin), width: CGFloat(size.width / 3.0), height: CGFloat(size.height / 2.0)), fontSize: 18, color: UIColor.gray)
        let calorie = String(format: "%.1f", self.calorie)
        
        
        self.drawString(string: calorie, inRect: CGRect(x: CGFloat(size.width / 3.0 * 2), y: CGFloat(subItemY), width: CGFloat(size.width / 3.0), height: CGFloat(size.height / 2.0)), fontSize: 18, color: UIColor.black)
        self.drawString(string: "大卡", inRect: CGRect(x: CGFloat(size.width / 3.0 * 2), y: CGFloat(subItemY + subItemMargin), width: CGFloat(size.width / 3.0), height: CGFloat(size.height / 2.0)), fontSize: 18, color: UIColor.gray)
        
    }
    
    func drawString(string : String, inRect: CGRect, fontSize: CGFloat, color: UIColor) {
        var usedColor = UIColor.black
        if color != nil {
            usedColor = color
        }
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        string.draw(in: inRect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize), NSForegroundColorAttributeName: usedColor, NSParagraphStyleAttributeName: style])
    }

}
