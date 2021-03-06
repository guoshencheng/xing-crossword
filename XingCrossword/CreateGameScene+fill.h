//
//  CreateGameScene+fill.h
//  XingCrossword
//
//  Created by apple on 14-11-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CreateGameScene.h"

@interface CreateGameScene (fill)

- (void)fillDown:(CGPoint)point;
- (void)unFillDown:(CGPoint)point;
- (void)fillUp:(CGPoint)point;
- (void)unFillUp:(CGPoint)point;

- (void)fillingLeft:(CGPoint)point;
- (void)unFillingLeft:(CGPoint)point;
- (void)fillingRight:(CGPoint)point;
- (void)unFillingRight:(CGPoint)point;

- (void)fillingRightWithEmpty:(CGPoint)point;
- (void)fillingDownWithEmpty:(CGPoint)point;

- (void)setAnswerStringToCrossWithString:(NSString*)answerString;
- (void)fillWithInput;

@end
