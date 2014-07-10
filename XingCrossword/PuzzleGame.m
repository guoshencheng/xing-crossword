//
//  PuzzleGame.m
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "PuzzleGame.h"
#import "Puzzle+Utility.h"
#import "Puzzle+DataManager.h"
#import "AFHTTPRequestOperationManager.h"

#define DATA_JASON_URL_STRING @"http://crossword.sinaapp.com/api/current_puzzle.json"

@interface PuzzleGame ()

@property (nonatomic, assign) CGSize cellSize;
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
    self.cellSize = CGSizeMake(0.f, 0.f);
  }
  return self;
}

#pragma mark - Public Methods

- (NSUInteger)rowsCount {
  return 0;
}

- (NSUInteger)columnsCount {
  return 0;
}

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

@end
