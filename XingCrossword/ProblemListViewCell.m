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
  self.problemText.text = problemString;
  self.textField.hidden = YES;
  self.problemText.hidden = NO;
}

- (void)updateWithProblemWordsCount:(NSInteger)count {
  self.textField.placeholder = [NSString stringWithFormat:@"%@ %d %@",@"please enter",count,@"words"];
  self.textField.hidden = NO;
  self.problemText.hidden = YES;
}

@end
