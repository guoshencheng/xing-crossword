//
//  ViewController.h
//  xing-crossword
//

//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScene.h"

@interface ViewController : UIViewController <MySceneDelegate>

@property NSString *title;
@property NSString *puzzleId;

+ (id)create;

@end
