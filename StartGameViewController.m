//
//  StartGameViewController.m
//  XingCrossword
//
//  Created by apple on 14-8-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "StartGameViewController.h"
#import "StartGameViewScene.h"
#import "ViewController.h"

@implementation StartGameViewController

+ (id)create {
  return  [[StartGameViewController alloc]initWithNibName:@"StartGameViewController" bundle:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  SKView * skView = (SKView *)self.view;
  skView.showsFPS = YES;
  skView.showsNodeCount = YES;
  StartGameViewScene * scene = [StartGameViewScene sceneWithSize:skView.bounds.size];
  scene.scaleMode = SKSceneScaleModeAspectFill;
  scene.delegate = self;
  [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return UIInterfaceOrientationMaskAllButUpsideDown;
  } else {
    return UIInterfaceOrientationMaskAll;
  }
}

- (void)startGameViewSceneShouldPushMainGameController:(StartGameViewScene *)startGmaeViewScene withPuzzletitle:(NSString *)title andPuzzleId:(NSString *)puzzleId{
  ViewController *viewController = [ViewController create];
  viewController.title = title;
  viewController.puzzleId = puzzleId;
  [self.navigationController pushViewController:viewController animated:YES];
}

@end
