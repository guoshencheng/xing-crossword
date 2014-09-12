//
//  ColorTheme.m
//  XingCrossword
//
//  Created by Sherlock on 7/11/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "ColorTheme.h"

@interface NormalColorTheme : NSObject<ColorTheme>

@end

@implementation NormalColorTheme

- (SKColor *)entryCellColor {
  return [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

- (SKColor *)blockCellColor {
  return [SKColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
}

@end

@implementation ColorThemeFactory

+ (id<ColorTheme>)defaultTheme {
  return [NormalColorTheme new];
}

@end