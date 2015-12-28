//
//  PuzzleGame.h
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Puzzle.h"
#import "ColorTheme.h"

@interface PuzzleGame : NSObject

@property (nonatomic, assign) NSUInteger rowsCount;
@property (nonatomic, assign) NSUInteger columnsCount;

@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, strong) SKSpriteNode *puzzleNode;
@property (nonatomic, strong) NSArray *grids;
@property (nonatomic, strong) NSArray *mapGrid;
@property (nonatomic, strong) NSArray *downItems;
@property (nonatomic, strong) NSArray *acrossItems;
@property (nonatomic, strong) id<ColorTheme> theme;

- (instancetype)initWithPuzzleTitle:(NSString *)title size:(CGSize)size andTheme:(id<ColorTheme>)theme;
- (instancetype)initBlankPuzzleWithsize:(CGSize)size andTheme:(id<ColorTheme>)theme;

- (NSUInteger)rowsCount;
- (NSUInteger)columnsCount;

- (SKSpriteNode *)cellAtRow:(NSUInteger)rowIndex column:(NSUInteger)columnIndex;

@end
