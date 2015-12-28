//
//  CreateGameViewController.m
//  XingCrossword
//
//  Created by apple on 14-9-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CreateGameViewController.h"
#import "CreateGameScene.h"
#import "WebService.h"

@interface CreateGameViewController ()

@end

@implementation CreateGameViewController

#pragma mark - PublicMethod

+ (id)create {
  return [[CreateGameViewController alloc] initWithNibName:@"CreateGameViewController" bundle:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.firstPush) {
        SKView * skView = (SKView *)self.skview;
        //  skView.showsFPS = YES;
        //  skView.showsNodeCount = YES;
        self.createGameScene = [CreateGameScene sceneWithSize:skView.bounds.size];
        self.createGameScene.scaleMode = SKSceneScaleModeAspectFill;
        self.createGameScene.delegate = self;
        [skView presentScene:self.createGameScene];
        [self configureScrollView];
        self.firstPush = NO;
    }
}

- (void)configureScrollView {
  self.scrollView.frame = CGRectMake(0, 0, [self screenWidth], [self screenHeight] - 45);
  self.scrollView.delegate = self;
  [self.scrollView setMaximumZoomScale:2.5];
  [self.scrollView setMinimumZoomScale:1.0];
  [self.scrollView setZoomScale:1.5];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firstPush = YES;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backButtonClickAction:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkButtonClickAction:(id)sender {
    if ([self.checkLabel.text isEqual:@"检查"]) {
        if ([self.createGameScene isACorrectMap]) {
            self.createGameScene.isCreateMap = NO;
            [self.createGameScene handleIfMapIsCorrect];
            self.checkLabel.text = @"保存";
        }
    } else {
        [self upLoadPuzzle];
    }
}

- (void)upLoadPuzzle {
    NSString *map = [self changeGridArrayToString:self.createGameScene.wordArray];
    NSString *puzzleId = @"puzzle1";
    NSString *title = @"puzzle1";
    NSMutableDictionary *upLoadDic = [[NSMutableDictionary alloc] init];
    [upLoadDic setObject:puzzleId forKey:@"puzzleId"];
    [upLoadDic setObject:title forKey:@"title"];
    [upLoadDic setObject:map forKey:@"map"];
    [upLoadDic setObject:[self.quAndAnsPanel acrossArrayForUpLoad] forKey:@"acrossArray"];
    [upLoadDic setObject:[self.quAndAnsPanel downArrayForUpLoad] forKey:@"downArray"];
    [WebService saveNewPuzzleWithParameters:upLoadDic];
}

- (NSString *)changeGridArrayToString:(NSArray *)array {
    NSString *string = @"";
    for (int i = 0; i < array.count; i ++) {
        NSArray *currentArray = [array objectAtIndex:i];
        NSString *substring = @"";
        for (int j  = 0; j < currentArray.count; j ++) {
            substring = [NSString stringWithFormat:@"%@%@", substring, [currentArray objectAtIndex:j]];
        }
        if (i == 0) {
            string = [NSString stringWithFormat:@"%@%@", string, substring];
        } else {
            string = [NSString stringWithFormat:@"%@,%@", string, substring];
        }
    }
    return string;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.skview;
}

#pragma mark - UIScreen Tool

- (CGFloat)screenWidth {
  return [[UIScreen mainScreen] bounds].size.width;
}

- (CGFloat)screenHeight {
  return [[UIScreen mainScreen] bounds].size.height;
}

- (void)createGameSceneGridHasFinishCreateWithNumberArrayOfHorAnswerWords:(NSArray *)horAnswer andVerAnswerWords:(NSArray *)verAnswer {
  self.quAndAnsPanel  = [QuAndAnsPanel create];
    self.quAndAnsPanel.delegate = self;
  [self.view addSubview:self.quAndAnsPanel];
    [self.quAndAnsPanel setLeftSpace:[UIScreen mainScreen].bounds.size.width];
    [self.quAndAnsPanel setRightSpace:[UIScreen mainScreen].bounds.size.width];
    [self.quAndAnsPanel setTopSpace:45];
    [self.quAndAnsPanel setBottomSpace:0];
    [self.view layoutIfNeeded];
  self.quAndAnsPanel.isHor = YES;
  self.quAndAnsPanel.horQuestionList = horAnswer;
  self.quAndAnsPanel.verQuestionList = verAnswer;
  [self.quAndAnsPanel.tableView reloadData];
  [self.quAndAnsPanel animateToShow];
}

- (void)quAndAnsPanel:(QuAndAnsPanel *)quAndAnsPanel didClickCellWithQuestion:(NSString *)question answer:(NSString *)answer andWordCount:(NSInteger)wordCount {
    ModifyViewController *viewController = [ModifyViewController create];
    viewController.delegate = self;
    viewController.questionText = question;
    viewController.answerText = answer;
    viewController.wordCount  = wordCount;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)ModifyViewController:(ModifyViewController *)modifyViewController shoudSaveQuestion:(NSString *)question andAnswer:(NSString *)answer {
    [self.quAndAnsPanel updateWithQuestion:question andAnswer:answer];
    [modifyViewController.navigationController popViewControllerAnimated:YES];
}

@end
