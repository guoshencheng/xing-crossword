//
//  PuzzleGame.m
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "PuzzleGame.h"
#import "Puzzle+Utility.h"
#import "ColorTheme.h"
#import "Puzzle+DataManager.h"
#import "Item+DataManager.h"
#import "AFHTTPRequestOperationManager.h"

#define DATA_JASON_URL_STRING @"http://crossword.sinaapp.com/api/puzzles.json"

@interface PuzzleGame ()

@property (nonatomic, assign) NSUInteger rowsCount;
@property (nonatomic, assign) NSUInteger columnsCount;

@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, strong) NSArray *grids;
@property (nonatomic, strong) NSArray *downItems;
@property (nonatomic, strong) NSArray *acrossItems;

@end


@implementation PuzzleGame

- (instancetype)initWithPuzzle:(Puzzle *)puzzle size:(CGSize)size {
  self = [super init];
  if (self) {
    [self getResponsFromWeb];
    
    self.downItems = [puzzle orderedDownItems];
    self.acrossItems = [puzzle orderedAcrossItems];

    NSArray *mapGrid = [puzzle mapGrid];
    self.rowsCount = [mapGrid count];
    self.columnsCount = [mapGrid[0] count];
    CGFloat cellWidth = size.width / self.rowsCount;
    CGFloat cellHeight = size.height / self.columnsCount;
    self.cellSize = cellWidth < cellHeight ? CGSizeMake(cellWidth, cellWidth) : CGSizeMake(cellHeight, cellHeight);
    
    NSMutableArray *grids = [NSMutableArray array];
    for (NSUInteger rowIndex = 0; rowIndex < self.rowsCount; rowIndex++) {
      NSMutableArray *row = [NSMutableArray array];
      [grids addObject:row];
      for (NSUInteger columnIndex = 0; columnIndex < self.columnsCount; columnIndex++) {
        BOOL isEntry = [@"1" isEqualToString:mapGrid[rowIndex][columnIndex]];
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

-  (void)getResponsFromWeb {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:DATA_JASON_URL_STRING parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSDictionary *response = responseObject;
    NSDictionary *hints = [response objectForKey:@"hints"];
    NSArray *acrossHints = [hints objectForKey:@"across"];
    [Puzzle createPuzzleWithResponse:response completion:^(BOOL success, NSError *error) {
      for (int i= 0; i < acrossHints.count ; i++) {
        Item *acrossItem;
        acrossItem = [Item createAcrossItemWithOrder:response andOrder:@(i + 1) completion:^(BOOL success, NSError *error) {
          [items addObject:acrossItem];
        }];
        Item *downItem;
        downItem = [Item createDownItemWithOrder:response andOrder:@(i + 1) completion:^(BOOL success, NSError *error) {
          [items addObject:downItem];
        }];
      }
    }];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
  }];
}

#pragma mark - Private Methods

- (SKSpriteNode *)createCellAtRow:(NSUInteger)rowIndex column:(NSUInteger)columnIndex isEntry:(BOOL)isEntry {
  id<ColorTheme> theme = [ColorThemeFactory defaultTheme];
  SKSpriteNode *node = [SKSpriteNode spriteNodeWithColor:(isEntry ? [theme entryCellColor] : [theme blockCellColor]) size:self.cellSize];
  [node setName:[NSString stringWithFormat:@"%d,%d", rowIndex, columnIndex]];
  node.position = CGPointMake(self.cellSize.width * columnIndex, self.cellSize.height * (self.rowsCount - rowIndex));
  SKLabelNode *currentLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
  currentLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
  currentLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
  currentLabelNode.fontSize = 12;
  currentLabelNode.fontColor = [UIColor blackColor];
  [currentLabelNode setName:@"text"];
  [currentLabelNode setUserInteractionEnabled:NO];
  [node addChild:currentLabelNode];
  
  return node;
}

@end
