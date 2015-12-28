//
//  QuAndAnsPanelCell.m
//  XingCrossword
//
//  Created by guoshencheng on 5/10/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import "QuAndAnsPanelCell.h"

@implementation QuAndAnsPanelCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateWithQuestion:(NSString *)question answer:(NSString *)answer andAnswerCount:(NSInteger)count {
    self.wordCount = count;
    self.questionLabel.text = (![question isEqual:@""] ? question : @"请输入问题");
    self.answerLabel.text = (![answer isEqual:@""] ? answer : [NSString stringWithFormat:@"输入答案，字数%ld",(long)count]);
    [self layoutIfNeeded];
    CGRect frame = self.frame;
    frame.size.height = [self caculateCellHeight];
    self.frame = frame;
}

- (CGFloat)caculateCellHeight {
    return 10 + self.questionLabel.frame.size.height + self.answerLabel.frame.size.height;
}

@end
