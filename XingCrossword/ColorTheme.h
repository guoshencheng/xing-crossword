//
//  ColorTheme.h
//  XingCrossword
//
//  Created by Sherlock on 7/11/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol ColorTheme <NSObject>

@optional
- (UIColor *)entryCellColor;
- (UIColor *)blockCellColor;
- (UIColor *)fillCellColor;

- (SKTexture *)entryCellTexture;
- (SKTexture *)blockCellTexture;
- (SKTexture *)fillCellTexture;

@end

@interface ColorThemeFactory : NSObject

+ (id<ColorTheme>)defaultTheme;

@end
