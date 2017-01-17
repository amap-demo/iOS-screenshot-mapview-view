//
//  ScreenshotDemoUITests.m
//  ScreenshotDemoUITests
//
//  Created by eidan on 17/1/17.
//  Copyright © 2017年 AutoNavi. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ScreenshotDemoUITests : XCTestCase

@end

@implementation ScreenshotDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    sleep(1);
    
    [[[[[app.otherElements containingType:XCUIElementTypeButton identifier:@"\u622a\u56fe"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] pinchWithScale:3 velocity:5];
    
    sleep(3);
    
    [app.buttons[@"截图"] tap];
    
    sleep(2);
    
    [app.navigationBars[@"ScreenshotDetailView"].buttons[@"Done"] tap];
    
    sleep(2);
    
}

@end
