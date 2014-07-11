//
//  ColorTheme.h
//  XingCrossword
//
//  Created by Sherlock on 7/11/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol ColorTheme <NSObject>

@required
- (SKColor *)entryCellColor;
- (SKColor *)blockCellColor;

@end

@interface ColorThemeFactory : NSObject

+ (id<ColorTheme>)defaultTheme;

@end
