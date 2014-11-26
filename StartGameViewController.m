//
//  StartGameViewController.m
//  XingCrossword
//
//  Created by apple on 14-8-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "StartGameViewController+Configuration.h"
#import "startGameCollectionViewCell.h"
#import "CreateGameViewController.h"
#import "StartGameViewController.h"
#import "Puzzle+DataManager.h"
#import "StartGameViewScene.h"
#import "ViewController.h"

@implementation StartGameViewController

+ (id)create {
  return  [[StartGameViewController alloc]initWithNibName:@"StartGameViewController" bundle:nil];
}

- (void)viewDidLoad {
//  WebService *webservice = [[WebService alloc] init];
//  webservice.delegate = self;
//  [webservice getAllPuzzleResponse];
  [self configureView];
  self.puzzleArray = [Puzzle findAllPuzzle];
  [self.collectionView reloadData];
}

- (void)startGameCollectionViewCellShouldPushMainGameView:(startGameCollectionViewCell *)startGameCell WithPuzzle:(Puzzle *)puzzle {
  ViewController *viewController = [ViewController create];
  viewController.title = puzzle.title;
  viewController.puzzleId = puzzle.puzzleId;
  [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.puzzleArray.count + 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item == self.puzzleArray.count) {
    startGameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:START_GAME_COLLECTIONVIEW_CELL forIndexPath:indexPath];
    return cell;
  } else {
    startGameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:START_GAME_COLLECTIONVIEW_CELL forIndexPath:indexPath];
    cell.delegate = self;
    [cell updateWithPuzzle:[self.puzzleArray objectAtIndex:indexPath.item]];
    return  cell;
  }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item == self.puzzleArray.count) {
    CreateGameViewController *createGameViewController = [CreateGameViewController craete];
    [self.navigationController pushViewController:createGameViewController animated:YES];
  }
}

- (void)webServiceDidGetAllPuzzleResponse:(WebService *)webService {
  [webService savaAllPuzzleResponseWithCompletion:^(BOOL success, NSError *error) {
    self.puzzleArray = [Puzzle findAllPuzzle];
    [self.collectionView reloadData];
  }];
}

@end
