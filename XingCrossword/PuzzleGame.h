//
//  PuzzleGame.h
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Puzzle.h"

@interface PuzzleGame : NSObject

- (instancetype)initWithPuzzle:(Puzzle *)puzzle size:(CGSize)size;

- (NSUInteger)rowsCount;
- (NSUInteger)columnsCount;

- (SKSpriteNode *)cellAtRow:(NSUInteger)rowIndex column:(NSUInteger)columnIndex;

@end
