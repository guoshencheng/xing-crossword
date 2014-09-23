//
//  ViewController.h
//  xing-crossword
//

//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScene.h"
#import "ProblemListViewPanel.h"

@interface ViewController : UIViewController <MySceneDelegate, UITextFieldDelegate, UIScrollViewDelegate, ProblemListViewPanelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet SKView *skView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backButtonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *textFieldImageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *problemLabel;

@property (strong, nonatomic) MyScene *scene;
@property (strong, nonatomic) ProblemListViewPanel *problemListViewPanel;
@property NSString *title;
@property NSString *puzzleId;

+ (id)create;

@end
