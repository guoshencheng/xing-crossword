
#import "MyScene.h"
#import "PuzzleGame.h"
#import "Item+DataManager.h"
#import "MyScene+fill.h"
#import "MyScene+ProblemArray.h"
#import "MyScene+PostionHandler.h"

@implementation MyScene

- (void)didMoveToView:(SKView *)view {
  [self configureTextField];
  [self configureButton];
  [self configureLabel];
}

- (void)configureButton {
  self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 60, 20)];
  [self.backButton setTitle:@"back" forState:UIControlStateNormal];
  self.backButton.titleLabel.font = [UIFont systemFontOfSize:10.0];
  [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.backButton addTarget:self action:@selector(sendPopBack) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:self.backButton];
}

- (void)createButtonTexture {
  SKSpriteNode *buttonnode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button.png"] size:CGSizeMake(60, 20)];
  buttonnode.position = CGPointMake(40, [self screenHeight] - 30);
  [self addChild:buttonnode];
}

- (void)sendPopBack {
  if ([self.delegate respondsToSelector:@selector(mySceneWillPop:)]) {
    [self.delegate mySceneWillPop:self];
  }
}

- (void)configureLabel {
  self.label = [[UILabel alloc] initWithFrame:CGRectMake(([self screenWidth] - 300) / 2, 105, 300, 40)];
  self.label.textColor = [UIColor blackColor];
  self.label.numberOfLines = 2;
  self.label.font = [UIFont systemFontOfSize:12];
  self.label.backgroundColor = [UIColor clearColor];
  [self.view addSubview:self.label];
  
}

- (void)createlabelTexture {
  SKSpriteNode *labelnode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"textfield.png"] size:CGSizeMake(200, 40)];
  labelnode.position = CGPointMake([self screenWidth]  / 2, [self screenHeight] - 82);
  [self addChild:labelnode];
}

- (void)configureTextField {
  self.textField = [[UITextField alloc] initWithFrame:CGRectMake(([self screenWidth] - 180) / 2, 70, 180, 25)];
  self.textField.borderStyle = UITextBorderStyleRoundedRect;
  self.textField.textColor = [UIColor blackColor];
  self.textField.font = [UIFont systemFontOfSize:15.0];
  self.textField.placeholder = @"Enter your answer here";
  self.textField.backgroundColor = [UIColor clearColor];
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
  self.labelNode.fontSize = 15;
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
    SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    backGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    backGround.name = @"BACKGROUND";
    [self addChild:backGround];
    [self createlabelTexture];
    [self createButtonTexture];
  }
  return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    [self.textField resignFirstResponder];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    NSLog(@"%@",node.name);
    if ([node.name isEqual:self.labelNode.name] || [node.name isEqual:@"BACKGROUND"]) {
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
        [self.label setText:[self getProblemText]];
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
  self.label.textColor = ([[self getInputText] isEqual: [self getCorrectAnswerText]]) ? [UIColor greenColor] : [UIColor blackColor];
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
        SKSpriteNode * currentnode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]];
        currentnode.texture = [SKTexture textureWithImageNamed:@"empty.png"];
      } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]];
        currentnode.texture = [SKTexture textureWithImageNamed:@"block.png"];
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
    [self saveInput];
  }
  [self.textField resignFirstResponder];
  return  YES;
}

- (void)saveInput {
  [Item saveInputbyDirection:(self.hor?@(0):@(1)) andOrder:@(self.currentProblemNumber - 1) andPuzzleId:self.puzzleId andInputString:self.textField.text completion:^(BOOL success, NSError *error) {
    [self resetLabelColor];
  }];
  CGPoint point = self.hor ? ([[self.horProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue]) : ([[self.verProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue]);
  self.hor ? [self saveHorInputFrom:point] : [self saveVerInputFrom:point];
  
}

- (void)saveHorInputFrom:(CGPoint)point {
  if ([self isTextFieldCellWithPostion:point]) {
    NSInteger currentProblem = [self findProblemInVerProblemWithCGPoint:point];
    if (currentProblem > 0) {
      NSString *input = [self getStringFromVerCrossWordWithPoint:[[self.verProblemArray objectAtIndex:(currentProblem - 1)] CGPointValue]andStringBefore:@""];
      [Item saveInputbyDirection:@(1) andOrder:@(currentProblem - 1) andPuzzleId:self.puzzleId andInputString:input completion:nil];
    }
    [self saveHorInputFrom:CGPointMake(point.x + 1, point.y)];
  }
}

- (void)saveVerInputFrom:(CGPoint)point {
  if ([self isTextFieldCellWithPostion:point]) {
    NSInteger currentProblem = [self findProblemInHorProblemWithCGPoint:point];
    if (currentProblem > 0) {
      NSString *input = [self getStringFromHorCrossWordWithPoint:[[self.horProblemArray objectAtIndex:(currentProblem - 1)] CGPointValue] andStringBefore:@""];
      [Item saveInputbyDirection:@(0) andOrder:@(currentProblem - 1) andPuzzleId:self.puzzleId andInputString:input completion:nil];
    }
    [self saveVerInputFrom:CGPointMake(point.x, point.y + 1)];
  }
  
}


@end
