//
//  startGameCollectionViewCell.m
//  XingCrossword
//
//  Created by apple on 14-9-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Item+DataManager.h"
#import "startGameCollectionViewCell.h"
#import "startGameCollectionViewCell+Configuration.h"

@implementation startGameCollectionViewCell

- (void)awakeFromNib {
  [self configureView];
}

- (IBAction)cellDidClickedAction:(id)sender {
  if ([self.delegate respondsToSelector:@selector(startGameCollectionViewCellShouldPushMainGameView:WithPuzzle:)]) {
    [self.delegate startGameCollectionViewCellShouldPushMainGameView:self WithPuzzle:self.puzzle];
  }
}

- (void)updateWithPuzzle:(Puzzle *)puzzle {
  self.puzzle = puzzle;
  self.puzzleNameLabel.text = self.puzzle.title;
  self.itemArray = [Item findAllItemInPuzzleWithPuzzleId:self.puzzle.puzzleId];
  [self updateCount];
  [self setAnswerView];
  [self setRightAnswerView];
  [self layoutIfNeeded];
}

- (void)updateCount {
  self.answerCount = 0;
  self.rightAnswerCount = 0;
  for (Item *item in self.itemArray) {
    if (item.input) {
      self.answerCount ++;
      if ([item.input isEqual:item.word]) {
        self.rightAnswerCount ++;
      }
    }
  }
}

- (void)setAnswerView {
  self.anwserProblemProcessLabel.text = [NSString stringWithFormat:@"%@ %d",@"Answerd:",self.answerCount * 100 / self.itemArray.count];
  self.answerProblmProcessViewConstraint.constant = (200.0 * (int)self.answerCount) / self.itemArray.count;
}

- (void)setRightAnswerView {
  self.rightAnswerProcessLabel.text = [NSString stringWithFormat:@"%@ %d",@"Correct:",self.rightAnswerCount * 100 / self.itemArray.count];
  self.rightAnswerProcessViewConstraint.constant = (200.0 * (int)self.rightAnswerCount ) / self.itemArray.count;
}

@end
