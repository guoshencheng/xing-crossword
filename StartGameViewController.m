//
//  StartGameViewController.m
//  XingCrossword
//
//  Created by apple on 14-8-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "StartGameViewController.h"
#import "MyScene.h"

@interface StartGameViewController ()

@end

@implementation StartGameViewController

+ (id)create {
  return  [[StartGameViewController alloc]initWithNibName:@"StarGameViewController" bundle:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  // Configure the view.
  SKView * skView = (SKView *)self.view;
  skView.showsFPS = YES;
  skView.showsNodeCount = YES;
  
  // Create and configure the scene.
  SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
  scene.scaleMode = SKSceneScaleModeAspectFill;
  
  // Present the scene.
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



@end
