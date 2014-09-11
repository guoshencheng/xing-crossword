
#import <SpriteKit/SpriteKit.h>

@protocol MySceneDelegate;

@interface MyScene : SKScene <UITextFieldDelegate>

@property NSString *title;
@property NSString *puzzleId;
@property Boolean hor;
@property CGPoint touchPoint;
@property NSArray *nodeArray;
@property NSArray *wordArray;
@property NSInteger wordArrayXMaxNumber;
@property NSInteger wordArrayYMaxNumber;
@property NSMutableArray *horProblemArray;
@property NSMutableArray *verProblemArray;
@property UITextField *textField;
@property UILabel *label;
@property UIButton *backButton;
@property SKLabelNode *labelNode;
@property int currentProblemNumber;

@property (weak, nonatomic) id<MySceneDelegate> delegate;

- (void)createAcross;

@end

@protocol MySceneDelegate <NSObject>

- (void)mySceneWillPop:(MyScene *)myscene;

@end
