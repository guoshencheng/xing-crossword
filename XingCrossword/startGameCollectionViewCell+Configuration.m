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
    self.addNewGameMask.hidden = YES;
  self.answerProblmProcessView.layer.cornerRadius = 5;
  self.rightAnswerProcessView.layer.cornerRadius = 5;
  self.containerView.layer.cornerRadius = 10;
}

@end
