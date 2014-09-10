
#import "MyScene.h"
#import "PuzzleGame.h"
#import "Item+DataManager.h"
#import "MyScene+fill.h"
#import "MyScene+ProblemArray.h"
#import "MyScene+PostionHandler.h"

@implementation MyScene

- (void)didMoveToView:(SKView *)view {
  self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.size.width / 4, self.size.height * 1 / 8 + 20, 160, 40)];
  self.textField.borderStyle = UITextBorderStyleRoundedRect;
  self.textField.textColor = [UIColor blackColor];
  self.textField.font = [UIFont systemFontOfSize:17.0];
  self.textField.placeholder = @"Enter your answer here";
  self.textField.backgroundColor = [UIColor whiteColor];
  self.textField.autocorrectionType = UITextAutocorrectionTypeYes;
  self.textField.keyboardType = UIKeyboardTypeDefault;
  self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.textField.delegate = self;
  [self.view addSubview:self.textField];
}

- (void)createWordArray {
  PuzzleGame *puzzleGame = [[PuzzleGame alloc]initWithPuzzleTitle:self.title size:self.size];
  self.nodeArray = puzzleGame.grids;
  self.wordArray = puzzleGame.mapGrid;
  NSArray *firstArray = [self.wordArray objectAtIndex:0];
  self.wordArrayXMaxNumber = self.wordArray.count;
  self.wordArrayYMaxNumber = firstArray.count;
}

- (void)createAcross {
  [self createWordArray];
  [self initHorProblem];
  [self initVerProblem];
  [self initNodeArray];
  [self createAnswerLabel];
  [self fillWithInput];
}

- (void)createAnswerLabel {
  self.labelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
  self.labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
  self.labelNode.position = CGPointMake(160, self.size.height * 11 / 16);
  self.labelNode.fontSize = 20;
  self.labelNode.fontColor = [UIColor whiteColor];
  [self.labelNode setName:@"answerLabel"];
  [self.labelNode setUserInteractionEnabled:NO];
  [self addChild:self.labelNode];
}

- (void)initNodeArray {
  for (int i = 0; i < self.nodeArray.count; i ++) {
    NSArray *nodeArray = [self.nodeArray objectAtIndex:i];
    for (int j = 0; j < nodeArray.count; j ++) {
      SKSpriteNode *currentSprite = [nodeArray objectAtIndex:j];
      [self addChild:currentSprite];
    }
  }
}

-(id)initWithSize:(CGSize)size {
  self.currentProblemNumber = 0;
  self.hor = YES;
  self.touchPoint = CGPointMake(-1, -1);
  self.horProblemArray = [[NSMutableArray alloc] init];
  self.verProblemArray = [[NSMutableArray alloc] init];
  if (self = [super initWithSize:size]) {
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
  }
  return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    NSLog(@"%@",node.name);
    if ([node.name isEqual:self.labelNode.name]) {
      continue;
    }
    if ([node.name isEqual:@"text"]) {
      node = [node parent];
    }
    CGPoint mytouch = [self getCellPostionWithNodeName:node.name];
    if ([self isInGridWithPostion:mytouch]) {
      if ([self isTextFieldCellWithPostion:mytouch] ) {
        [self changeDirectionByTouch:mytouch];
        if (self.hor) {
          [self resetColor];
          [self fillingLeft:mytouch];
          [self fillingRight:mytouch];
          self.currentProblemNumber = [self findProblemInHorProblemWithCGPoint:mytouch];
        }else {
          [self resetColor];
          [self fillDown:mytouch];
          [self fillUp:mytouch];
          self.currentProblemNumber = [self findProblemInVerProblemWithCGPoint:mytouch];
        }
        [self resetLabelColor];
        [self.labelNode setText:[self getProblemText]];
      }
    }
    if (self.currentProblemNumber > 0) {
      [self.textField setText:[self getStringFromCrossWordWithStringBefore:@""]];
    }
  }
}

-(void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}

- (void)resetLabelColor {
  self.labelNode.fontColor = ([[self getInputText] isEqual: [self getCorrectAnswerText]]) ? [UIColor greenColor] : [UIColor whiteColor];
}

- (NSString *)getInputText {
  return [Item findInputByDirection:(self.hor?@(0):@(1)) andOrder:@(self.currentProblemNumber - 1) andPuzzleId:self.puzzleId];
}

- (NSString *)getCorrectAnswerText {
  return [Item findWordByDirection:(self.hor?@(0):@(1)) andOrder:@(self.currentProblemNumber - 1) andPuzzleId:self.puzzleId];
}

- (NSString *)getProblemText {
  return [Item findHintByDirection:(self.hor?@(0):@(1)) andOrder:@(self.currentProblemNumber - 1) andPuzzleId:self.puzzleId];
}

- (CGPoint) getCellPostionWithNodeName:(NSString*)nodeName {
  NSArray *strings = [nodeName componentsSeparatedByString:@","];
  float xValue = [[strings objectAtIndex:0]floatValue];
  float yValue = [[strings objectAtIndex:1]floatValue];
  return CGPointMake(xValue, yValue);
}

//reset all Node's Color
- (void)resetColor {
  for (int i = 0; i < self.wordArray.count; i++) {
    NSArray *currentArray = [self.wordArray objectAtIndex:i];
    for (int j = 0; j < currentArray.count; j++) {
      NSString *currentValue = [currentArray objectAtIndex:j];
      if ([currentValue isEqualToString:@"1"]) {
        [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]] setColor:[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0]];
      } else {
        [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]] setColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0]];
      }
    }
  }
}

- (CGFloat)screenWidth {
  return [[UIScreen mainScreen] bounds].size.width;
}

- (CGFloat)screenHeight {
  return [[UIScreen mainScreen] bounds].size.height;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  return  YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (self.currentProblemNumber > 0) {
    [self.textField setText:[self getStringFromCrossWordWithStringBefore:@""]];
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (self.currentProblemNumber > 0) {
    [self setAnswerStringToCrossWithString:self.textField.text];
    [Item saveInputbyDirection:(self.hor?@(0):@(1)) andOrder:@(self.currentProblemNumber - 1) andPuzzleId:self.puzzleId andInputString:self.textField.text completion:^(BOOL success, NSError *error) {
      [self resetLabelColor];
    }];
  }
  [self.textField resignFirstResponder];
  return  YES;
}

@end
