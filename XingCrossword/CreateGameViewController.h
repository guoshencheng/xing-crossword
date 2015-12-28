//
//  CreateGameViewController.h
//  XingCrossword
//
//  Created by apple on 14-9-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//
#import "CreateGameScene.h"
#import "ProblemListViewPanel.h"
#import "QuAndAnsPanel.h"
#import "ModifyViewController.h"

@interface CreateGameViewController : UIViewController <UIScrollViewDelegate,CreateGameSceneDelegate, QuAndAnsPanelDelegate, ModifyViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet SKView *skview;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;

@property (assign, nonatomic) BOOL firstPush;
@property (strong, nonatomic) CreateGameScene *createGameScene;
@property (strong, nonatomic) ProblemListViewPanel *problemListViewPanel;
@property (strong, nonatomic) QuAndAnsPanel *quAndAnsPanel;

+ (id)create;

@end
