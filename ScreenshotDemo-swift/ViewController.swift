//
//  ViewController.swift
//  ScreenshotDemo-swift
//
//  Created by shaobin on 16/12/16.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MAMapViewDelegate {

    var mapView : MAMapView! = nil
    var resultView : ResultView! = nil
    var shotView : UIView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initMapView()
        self.initResultView()
        self.initButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mapView.showOverlays(self.mapView.overlays, edgePadding: UIEdgeInsetsMake(80, 30, 220, 30), animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initButton() {
        let button = UIButton(type: .custom)
        button.setTitle("截图", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.red, for: .normal)
        button.frame = CGRect(x: CGFloat(10), y: CGFloat(80), width: CGFloat(60), height: CGFloat(40))
        button.addTarget(self, action: #selector(self.captureAction), for: .touchUpInside)
        self.view.addSubview(button)
    }

    func initMapView() {
        self.mapView = MAMapView(frame: self.view.bounds)
        self.mapView.delegate = self
        self.mapView.isShowsIndoorMap = false
        self.mapView.showsCompass = false
        self.mapView.showsScale = false
        self.view.addSubview(self.mapView)
        // polyline
        let count = 30
        var polylineCoords : [CLLocationCoordinate2D] = [CLLocationCoordinate2D](repeating: CLLocationCoordinate2D(), count: count)
        polylineCoords[0] = CLLocationCoordinate2DMake(40.005848, 116.38781)
        polylineCoords[1] = CLLocationCoordinate2DMake(40.00617, 116.388367)
        polylineCoords[2] = CLLocationCoordinate2DMake(40.006767, 116.388336)
        polylineCoords[3] = CLLocationCoordinate2DMake(40.006802, 116.389656)
        polylineCoords[4] = CLLocationCoordinate2DMake(40.006847, 116.391006)
        polylineCoords[5] = CLLocationCoordinate2DMake(40.006924, 116.393074)
        polylineCoords[6] = CLLocationCoordinate2DMake(40.006981, 116.3955)
        polylineCoords[7] = CLLocationCoordinate2DMake(40.00816, 116.396492)
        polylineCoords[8] = CLLocationCoordinate2DMake(40.008698, 116.396904)
        polylineCoords[9] = CLLocationCoordinate2DMake(40.009171, 116.397118)
        polylineCoords[10] = CLLocationCoordinate2DMake(40.009731, 116.397125)
        polylineCoords[11] = CLLocationCoordinate2DMake(40.009853, 116.396835)
        polylineCoords[12] = CLLocationCoordinate2DMake(40.009914, 116.396774)
        polylineCoords[13] = CLLocationCoordinate2DMake(40.010414, 116.396736)
        polylineCoords[14] = CLLocationCoordinate2DMake(40.010429, 116.39698)
        polylineCoords[15] = CLLocationCoordinate2DMake(40.010845, 116.398224)
        polylineCoords[16] = CLLocationCoordinate2DMake(40.010872, 116.398384)
        polylineCoords[17] = CLLocationCoordinate2DMake(40.010918, 116.398766)
        polylineCoords[18] = CLLocationCoordinate2DMake(40.01128, 116.399094)
        polylineCoords[19] = CLLocationCoordinate2DMake(40.013054, 116.399742)
        polylineCoords[20] = CLLocationCoordinate2DMake(40.014202, 116.399757)
        polylineCoords[21] = CLLocationCoordinate2DMake(40.015938, 116.399849)
        polylineCoords[22] = CLLocationCoordinate2DMake(40.016285, 116.399597)
        polylineCoords[23] = CLLocationCoordinate2DMake(40.016842, 116.398964)
        polylineCoords[24] = CLLocationCoordinate2DMake(40.018448, 116.398666)
        polylineCoords[25] = CLLocationCoordinate2DMake(40.018837, 116.398743)
        polylineCoords[26] = CLLocationCoordinate2DMake(40.019417, 116.398003)
        polylineCoords[27] = CLLocationCoordinate2DMake(40.019913, 116.396286)
        polylineCoords[28] = CLLocationCoordinate2DMake(40.020142, 116.394913)
        polylineCoords[29] = CLLocationCoordinate2DMake(40.021896, 116.392189)
        
        let line = MAMultiPolyline.init(coordinates: &polylineCoords, count: UInt(count), drawStyleIndexes:  [10, 18, 24, 29])
        self.mapView.add(line!)
    }
    
    func initResultView() {
        self.resultView = ResultView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(300), height: CGFloat(120)))
        self.resultView.backgroundColor = UIColor.white
        self.resultView.layer.cornerRadius = 3
        self.resultView.layer.borderColor = UIColor.lightGray.cgColor
        self.resultView.layer.borderWidth = 1
        self.resultView.center = CGPoint(x: CGFloat(self.view.bounds.midX), y: CGFloat(self.view.bounds.maxY - 100))
        self.mapView.addSubview(self.resultView)
        self.resultView.distance = 3110
        self.resultView.duration = Double(5 * 3600 + 32 * 60 + 8)
        self.resultView.pace = Double(9 * 60 + 17)
        self.resultView.calorie = 218.2
        self.resultView.setNeedsDisplay()
    }
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if (overlay is MAMultiPolyline) {
            let renderer : MAMultiColoredPolylineRenderer! = MAMultiColoredPolylineRenderer.init(overlay: overlay)
            renderer.lineWidth = 6
            renderer.strokeColors = [UIColor.green, UIColor.yellow, UIColor.red, UIColor.green]
            return renderer
        }
        return nil
    }
    
    // MARK: - Handle Action
    @objc func captureAction() {
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
    
    func transitionToDetail(with image: UIImage) {
        var detailViewController = ScreenshotDetailViewController()
        detailViewController.screenshotImage = image
        detailViewController.modalTransitionStyle = .flipHorizontal
        var navi = UINavigationController(rootViewController: detailViewController)
        self.present(navi, animated: true, completion: nil)
    }
}

