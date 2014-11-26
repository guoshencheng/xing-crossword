//
//  CreateGameViewController.m
//  XingCrossword
//
//  Created by apple on 14-9-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CreateGameViewController.h"
#import "CreateGameScene.h"

@interface CreateGameViewController ()

@end

@implementation CreateGameViewController

#pragma mark - PublicMethod

+ (id)craete {
  return [[CreateGameViewController alloc] initWithNibName:@"CreateGameViewController" bundle:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  SKView * skView = (SKView *)self.skview;
  //  skView.showsFPS = YES;
  //  skView.showsNodeCount = YES;
  self.createGameScene = [CreateGameScene sceneWithSize:skView.bounds.size];
  self.createGameScene.scaleMode = SKSceneScaleModeAspectFill;
  [skView presentScene:self.createGameScene];
  [self configureScrollView];
}

- (void)configureScrollView {
  self.scrollView.frame = CGRectMake(0, 0, [self screenWidth], [self screenHeight] - 180);
  self.scrollView.delegate = self;
  [self.scrollView setMaximumZoomScale:2.5];
  [self.scrollView setMinimumZoomScale:1.0];
  [self.scrollView setZoomScale:1.5];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backButtonClickAction:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkButtonClickAction:(id)sender {
  if ([self.createGameScene isACorrectMap]) {
    self.createGameScene.isCreateMap = NO;
  }
}



#pragma mark - UIScreen Tool

- (CGFloat)screenWidth {
  return [[UIScreen mainScreen] bounds].size.width;
}

- (CGFloat)screenHeight {
  return [[UIScreen mainScreen] bounds].size.height;
}


@end
