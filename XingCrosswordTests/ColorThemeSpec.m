//
//  ColorThemeSpec.m
//  XingCrossword
//
//  Created by Sherlock on 7/11/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ColorTheme.h"

@interface ColorThemeSpec : XCTestCase

@end

@implementation ColorThemeSpec

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testGetDefaultTheme {
  id<ColorTheme> theme = [ColorThemeFactory defaultTheme];
  XCTAssertNotNil(theme, @"Should has a default color theme");
}

- (void)testGetDefaultThemeColorValues {
  id<ColorTheme> theme = [ColorThemeFactory defaultTheme];
  XCTAssertNotNil([theme entryCellColor], @"Should has a color value");
  XCTAssertNotNil([theme blockCellColor], @"Should has a color value");
}

@end
