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

- (UIColor *)entryCellColor {
    return [UIColor greenColor];
}

- (UIColor *)blockCellColor {
    return [UIColor yellowColor];
}

- (UIColor *)fillCellColor {
    return [UIColor whiteColor];
}

@end


@interface NormalTextureTheme : NSObject<ColorTheme>

@end

@implementation NormalTextureTheme

- (SKTexture *)entryCellTexture {
    return [SKTexture textureWithImageNamed:@"empty.png"];
}

- (SKTexture *)blockCellTexture {
    return [SKTexture textureWithImageNamed:@"block.png"];
}

- (SKTexture *)fillCellTexture {
    return [SKTexture textureWithImageNamed:@"fill.png"];
}

@end

@implementation ColorThemeFactory

+ (id<ColorTheme>)defaultTheme {
    return [NormalColorTheme new];
}

@end