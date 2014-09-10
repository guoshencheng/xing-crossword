//
//  MyScene+fill.h
//  XingCrossword
//
//  Created by apple on 14-9-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyScene.h"

@interface MyScene (fill)

- (void)fillDown:(CGPoint)point;
- (void)fillUp:(CGPoint)point;

- (void)fillingLeft:(CGPoint)point;
- (void)fillingRight:(CGPoint)point;

- (void)fillingRightWithEmpty:(CGPoint)point;
- (void)fillingDownWithEmpty:(CGPoint)point;

- (void)setAnswerStringToCrossWithString:(NSString*)answerString;
- (void)fillWithInput;

@end
