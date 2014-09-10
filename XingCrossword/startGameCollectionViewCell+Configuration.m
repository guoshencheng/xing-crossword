//
//  startGameCollectionViewCell+Configuration.m
//  XingCrossword
//
//  Created by apple on 14-9-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "startGameCollectionViewCell+Configuration.h"

@implementation startGameCollectionViewCell (Configuration)

- (void)configureView {
  self.answerProblmProcessView.layer.cornerRadius = 10;
  self.rightAnswerProcessView.layer.cornerRadius = 10;
  self.containerView.layer.cornerRadius = 30;
}

@end
