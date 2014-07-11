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
#import "AFHTTPRequestOperationManager.h"

#define DATA_JASON_URL_STRING @"http://crossword.sinaapp.com/api/current_puzzle.json"

@interface PuzzleGame ()

@property (nonatomic, assign) NSUInteger rowsCount;
@property (nonatomic, assign) NSUInteger columnsCount;

@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, strong) NSArray *grid;
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
  }
  return self;
}

#pragma mark - Public Methods

- (SKSpriteNode *)cellAtRow:(NSUInteger)rowIndex column:(NSUInteger)columnIndex {
  return nil;
}

-  (void) getResponsFromWeb {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:DATA_JASON_URL_STRING parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSDictionary *response = responseObject;;
    NSString *puzzleId = [response objectForKey:@"id"];
    [Puzzle createPuzzleWithResponse:response];
    NSLog(@"%@", [Puzzle getMapWithPuzzleid:puzzleId]);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
  }];
}

#pragma mark - Private Methods

- (SKSpriteNode *)createCellAtRow:(NSUInteger)rowIndex column:(NSUInteger)columnIndex blocked:(BOOL)blocked {
  id<ColorTheme> theme = [ColorThemeFactory defaultTheme];
  SKSpriteNode *node = [SKSpriteNode spriteNodeWithColor:(blocked ? [theme blockCellColor] : [theme entryCellColor]) size:self.cellSize];
  [node setName:[NSString stringWithFormat:@"%d,%d", rowIndex, columnIndex]];
//  node.position = CGPointMake( 30 + 20 * j, 390 - 20 * i );
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
