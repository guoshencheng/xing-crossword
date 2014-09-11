//
//  startGameCollectionViewCell.h
//  XingCrossword
//
//  Created by apple on 14-9-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Puzzle.h"

@protocol startGameCollectionViewCellDelegate;

@interface startGameCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *puzzleNameLabel;
@property (weak, nonatomic) IBOutlet UIView *answerProblmProcessView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerProblmProcessViewConstraint;
@property (weak, nonatomic) IBOutlet UIView *rightAnswerProcessView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightAnswerProcessViewConstraint;
@property (weak, nonatomic) IBOutlet UILabel *anwserProblemProcessLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightAnswerProcessLabel;

@property (weak, nonatomic) id<startGameCollectionViewCellDelegate> delegate;

@property (strong, nonatomic) Puzzle *puzzle;
@property (strong, nonatomic) NSArray *itemArray;
@property (assign, nonatomic) int answerCount;
@property (assign, nonatomic) int rightAnswerCount;

- (void)updateWithPuzzle:(Puzzle *)puzzle;

@end

@protocol startGameCollectionViewCellDelegate <NSObject>

- (void)startGameCollectionViewCellShouldPushMainGameView:(startGameCollectionViewCell *)startGameCell WithPuzzle:(Puzzle *)puzzle;

@end