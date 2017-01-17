//
//  ViewController.m
//  ScreenshotDemo
//
//  Created by xiaoming han on 16/11/2.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

#import "ViewController.h"
#import "ScreenshotDetailViewController.h"
#import "ResultView.h"
#import <MAMapKit/MAMapKit.h>

@interface ViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) ResultView *resultView;
@property (nonatomic, strong) UIView *shotView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initMapView];
    [self initResultView];
    
    [self initButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mapView showOverlays:self.mapView.overlays edgePadding:UIEdgeInsetsMake(80, 30, 220, 30) animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"截图" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor darkGrayColor]];
    button.showsTouchWhenHighlighted = YES;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(10, 80, 60, 40);
    [button addTarget:self action:@selector(captureAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.showsIndoorMap = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    
    [self.view addSubview:self.mapView];
    
    
    // polyline
    int count = 30;
    CLLocationCoordinate2D polylineCoords[count];
    polylineCoords[0] = CLLocationCoordinate2DMake(40.005848,116.38781);
    polylineCoords[1] = CLLocationCoordinate2DMake(40.00617,116.388367);
    polylineCoords[2] = CLLocationCoordinate2DMake(40.006767,116.388336);
    polylineCoords[3] = CLLocationCoordinate2DMake(40.006802,116.389656);
    polylineCoords[4] = CLLocationCoordinate2DMake(40.006847,116.391006);
    polylineCoords[5] = CLLocationCoordinate2DMake(40.006924,116.393074);
    polylineCoords[6] = CLLocationCoordinate2DMake(40.006981,116.3955);
    polylineCoords[7] = CLLocationCoordinate2DMake(40.00816,116.396492);
    polylineCoords[8] = CLLocationCoordinate2DMake(40.008698,116.396904);
    polylineCoords[9] = CLLocationCoordinate2DMake(40.009171,116.397118);
    polylineCoords[10] = CLLocationCoordinate2DMake(40.009731,116.397125);
    polylineCoords[11] = CLLocationCoordinate2DMake(40.009853,116.396835);
    polylineCoords[12] = CLLocationCoordinate2DMake(40.009914,116.396774);
    polylineCoords[13] = CLLocationCoordinate2DMake(40.010414,116.396736);
    polylineCoords[14] = CLLocationCoordinate2DMake(40.010429,116.39698);
    polylineCoords[15] = CLLocationCoordinate2DMake(40.010845,116.398224);
    polylineCoords[16] = CLLocationCoordinate2DMake(40.010872,116.398384);
    polylineCoords[17] = CLLocationCoordinate2DMake(40.010918,116.398766);
    polylineCoords[18] = CLLocationCoordinate2DMake(40.01128,116.399094);
    polylineCoords[19] = CLLocationCoordinate2DMake(40.013054,116.399742);
    polylineCoords[20] = CLLocationCoordinate2DMake(40.014202,116.399757);
    polylineCoords[21] = CLLocationCoordinate2DMake(40.015938,116.399849);
    polylineCoords[22] = CLLocationCoordinate2DMake(40.016285,116.399597);
    polylineCoords[23] = CLLocationCoordinate2DMake(40.016842,116.398964);
    polylineCoords[24] = CLLocationCoordinate2DMake(40.018448,116.398666);
    polylineCoords[25] = CLLocationCoordinate2DMake(40.018837,116.398743);
    polylineCoords[26] = CLLocationCoordinate2DMake(40.019417,116.398003);
    polylineCoords[27] = CLLocationCoordinate2DMake(40.019913,116.396286);
    polylineCoords[28] = CLLocationCoordinate2DMake(40.020142,116.394913);
    polylineCoords[29] = CLLocationCoordinate2DMake(40.021896,116.392189);
    
    MAMultiPolyline *multiPolyline = [MAMultiPolyline polylineWithCoordinates:polylineCoords count:count drawStyleIndexes:@[@10, @18, @24, @29]];
    [self.mapView addOverlay:multiPolyline];
    
}

- (void)initResultView
{
    self.resultView = [[ResultView alloc] initWithFrame:CGRectMake(0, 0, 300, 120)];
    self.resultView.backgroundColor = [UIColor whiteColor];
    self.resultView.layer.cornerRadius = 3;
    self.resultView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.resultView.layer.borderWidth = 1;
    
    self.resultView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) - 100);
    
    [self.mapView addSubview:self.resultView];
    
    self.resultView.distance = 3110;
    self.resultView.duration = 5*3600 + 32*60 + 8;
    self.resultView.pace = 9*60+17;
    self.resultView.calorie = 218.2;
    
    [self.resultView setNeedsDisplay];
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer *renderer = [[MAMultiColoredPolylineRenderer alloc] initWithOverlay:overlay];
        
        renderer.lineWidth   = 6;
        renderer.strokeColors = @[[UIColor greenColor], [UIColor yellowColor], [UIColor redColor], [UIColor greenColor]];
        
        return renderer;
    }
    
    return nil;
    
}

#pragma mark - Handle Action

- (void)captureAction
{
    // map image
    UIImage *mapImage = [self.mapView takeSnapshotInRect:self.mapView.bounds];
    
    // result image
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

    [self transitionToDetailWithImage:image];
}

- (void)transitionToDetailWithImage:(UIImage *)image
{
    ScreenshotDetailViewController *detailViewController = [[ScreenshotDetailViewController alloc] init];
    detailViewController.screenshotImage = image;
    detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    [self presentViewController:navi animated:YES completion:nil];
}

@end
