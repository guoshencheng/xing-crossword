//
//  PuzzleGame.m
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "PuzzleGame.h"
#import "WebService.h"
#import "Puzzle+Utility.h"
#import "ColorTheme.h"
#import "Puzzle+DataManager.h"
#import "Item+DataManager.h"
#import "AFHTTPRequestOperationManager.h"

@implementation PuzzleGame

- (instancetype)initWithPuzzleTitle:(NSString *)title size:(CGSize)size {
  self = [super init];
  if (self) {
    Puzzle *puzzle = [Puzzle findByPuzzletitle:title];
    self.downItems = [puzzle orderedDownItems];
    self.acrossItems = [puzzle orderedAcrossItems];

    self.mapGrid = [puzzle mapGrid];
    self.rowsCount = [self.mapGrid count];
    self.columnsCount = [self.mapGrid[0] count];
    CGFloat cellWidth = size.width / self.rowsCount;
    CGFloat cellHeight = size.height / self.columnsCount;
    self.cellSize = cellWidth < cellHeight ? CGSizeMake(cellWidth, cellWidth) : CGSizeMake(cellHeight, cellHeight);
    
    NSMutableArray *grids = [NSMutableArray array];
    for (NSUInteger rowIndex = 0; rowIndex < self.rowsCount; rowIndex++) {
      NSMutableArray *row = [NSMutableArray array];
      [grids addObject:row];
      for (NSUInteger columnIndex = 0; columnIndex < self.columnsCount; columnIndex++) {
        BOOL isEntry = [@"1" isEqualToString:self.mapGrid[rowIndex][columnIndex]];
        [row addObject:[self createCellAtRow:rowIndex column:columnIndex isEntry:isEntry]];
      }
    }
    self.grids = grids;
  }
  return self;
}

#pragma mark - Public Methods

- (SKSpriteNode *)cellAtRow:(NSUInteger)rowIndex column:(NSUInteger)columnIndex {
  NSAssert(rowIndex < self.rowsCount, @"row index should be less than row count");
  NSAssert(columnIndex < self.columnsCount, @"column index should be less than column count");
  return self.grids[rowIndex][columnIndex];
}

#pragma mark - Private Methods

- (SKSpriteNode *)createCellAtRow:(NSUInteger)rowIndex column:(NSUInteger)columnIndex isEntry:(BOOL)isEntry {
  id<ColorTheme> theme = [ColorThemeFactory defaultTheme];
  SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:(isEntry? @"empty.png" : @"block.png")];
  node.size = self.cellSize;
//                        
//  spriteNodeWithColor:(isEntry ? [theme entryCellColor] : [theme blockCellColor]) size:self.cellSize];
  [node setName:[NSString stringWithFormat:@"%d,%d", columnIndex, rowIndex]];
  node.position = CGPointMake(self.cellSize.width * (columnIndex + 0.5), [self screenHeight] - 160 - self.cellSize.height * (rowIndex + 0.5));
  SKLabelNode *currentLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
  currentLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
  currentLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
  currentLabelNode.fontSize = 12;
  currentLabelNode.fontColor = [UIColor blackColor];
  currentLabelNode.text = @" ";
  [currentLabelNode setName:@"text"];
  [currentLabelNode setUserInteractionEnabled:NO];
  [node addChild:currentLabelNode];
  
  return node;
}

- (CGFloat)screenWidth {
  return [[UIScreen mainScreen] bounds].size.width;
}

- (CGFloat)screenHeight {
  return [[UIScreen mainScreen] bounds].size.height;
}


@end
