
#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene <UITextFieldDelegate>

@property NSString *title;
@property Boolean hor;
@property CGPoint touchPoint;
@property NSArray *nodeArray;
@property NSArray *wordArray;
@property NSMutableArray *horProblemArray;
@property NSMutableArray *verProblemArray;
@property UITextField *textField;
@property SKLabelNode *labelNode;
@property int currentProblemNumber;

- (void)createAcross;

@end
