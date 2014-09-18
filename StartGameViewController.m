//
//  StartGameViewController.m
//  XingCrossword
//
//  Created by apple on 14-8-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "StartGameViewController+Configuration.h"
#import "startGameCollectionViewCell.h"
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
  return self.puzzleArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  startGameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:START_GAME_COLLECTIONVIEW_CELL forIndexPath:indexPath];
  cell.delegate = self;
  [cell updateWithPuzzle:[self.puzzleArray objectAtIndex:indexPath.item]];
  return  cell;
}

- (void)webServiceDidGetAllPuzzleResponse:(WebService *)webService {
  [webService savaAllPuzzleResponseWithCompletion:^(BOOL success, NSError *error) {
    self.puzzleArray = [Puzzle findAllPuzzle];
    [self.collectionView reloadData];
  }];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//  [super viewDidAppear:animated];
//  SKView * skView = (SKView *)self.view;
//  skView.showsFPS = YES;
//  skView.showsNodeCount = YES;
//  StartGameViewScene * scene = [StartGameViewScene sceneWithSize:skView.bounds.size];
//  scene.scaleMode = SKSceneScaleModeAspectFill;
//  scene.delegate = self;
//  [skView presentScene:scene];
//}
//
//- (BOOL)shouldAutorotate
//{
//  return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//  } else {
//    return UIInterfaceOrientationMaskAll;
//  }
//}
//
//- (void)startGameViewSceneShouldPushMainGameController:(StartGameViewScene *)startGmaeViewScene withPuzzletitle:(NSString *)title andPuzzleId:(NSString *)puzzleId{
//  ViewController *viewController = [ViewController create];
//  viewController.title = title;
//  viewController.puzzleId = puzzleId;
//  [self.navigationController pushViewController:viewController animated:YES];
//}

@end
