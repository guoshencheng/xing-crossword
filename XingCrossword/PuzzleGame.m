//
//  PuzzleGame.m
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "PuzzleGame.h"

@implementation PuzzleGame

- (instancetype)initWithPuzzle:(Puzzle *)puzzle size:(CGSize)size {
  self = [super init];
  if (self) {
    //TODO: init process
  }
  return self;
}

#pragma mark - Public Methods

- (SKSpriteNode *)cellAtRow:(NSUInteger)rowIndex column:(NSUInteger)columnIndex {
  return nil;
}

@end
