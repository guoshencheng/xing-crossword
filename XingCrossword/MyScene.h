
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
@property SKLabelNode *labelNode;
@property SKSpriteNode *puzzle;
@property int currentProblemNumber;

@property (weak, nonatomic) id<MySceneDelegate> delegate;

- (void)createAcross;
- (void)textfieldReturened:(NSString *)text;
- (NSString *)textFieldWillBeginEditWithText;

@end

@protocol MySceneDelegate <NSObject>

- (void)MySceneSetLabelText:(NSString *)label;
- (void)MySceneUpdateLabelColor:(UIColor *)color;
- (void)MySceneTextfiledBecomeFirstResponse;
- (void)MySceneTextfiledResignFirstResponder;
- (void)MySceneUpdateTextFieldText:(NSString *)text;

@end
