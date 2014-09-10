//
//  MyScene+ProblemArray.h
//  XingCrossword
//
//  Created by apple on 14-9-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyScene.h"

@interface MyScene (ProblemArray)

- (NSString*)getStringFromCrossWordWithStringBefore:(NSString*)string;

- (int)findProblemInVerProblemWithCGPoint:(CGPoint)point;
- (int)findProblemInHorProblemWithCGPoint:(CGPoint)point;

- (void)initVerProblem;
- (void)initHorProblem;

@end
