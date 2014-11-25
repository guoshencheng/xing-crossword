//
//  CreateGameViewController.h
//  XingCrossword
//
//  Created by apple on 14-9-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//
#import "CreateGameScene.h"

@interface CreateGameViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet SKView *skview;


@property (strong, nonatomic) CreateGameScene *createGameScene;

@end
