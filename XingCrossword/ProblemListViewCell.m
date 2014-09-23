//
//  ProblemListViewCell.m
//  XingCrossword
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ProblemListViewCell.h"

@implementation ProblemListViewCell

- (void)updateWithProblemString:(NSString *)problemString {
  self.prblemText.text = problemString;
}

@end
