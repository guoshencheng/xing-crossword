//
//  CreateGameScene+ProblemArray.h
//  XingCrossword
//
//  Created by apple on 14-11-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CreateGameScene.h"

@interface CreateGameScene (ProblemArray)

- (int)findProblemInVerProblemWithCGPoint:(CGPoint)point;
- (int)findProblemInHorProblemWithCGPoint:(CGPoint)point;

- (void)initVerProblem;
- (void)initHorProblem;
- (void)initHorProblemNumber;
- (void)initVerProblemNumber;


@end
