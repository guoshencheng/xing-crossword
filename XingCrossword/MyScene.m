
#import "MyScene.h"
#import "PuzzleGame.h"
#import "Item+DataManager.h"
#import "MyScene+fill.h"
#import "MyScene+ProblemArray.h"
#import "MyScene+PostionHandler.h"

@implementation MyScene

#pragma mark - self method

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
    self.backgroundColor = [SKColor clearColor];
    [self addChild:backGround];
  }
  return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    [self TextfiledResignFirstResponder];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    NSLog(@"%@",node.name);
    if ([node.name isEqual:self.labelNode.name] || [node.name isEqual:@"BACKGROUND"] || [node.name isEqual:@"puzzle"]) {
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
        [self updateLabelText:[self getProblemText]];
      }
    }
    if (self.currentProblemNumber > 0) {
      [self setTextFieldText:[self getStringFromCrossWordWithStringBefore:@""]];
    }
  }
}

-(void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}


#pragma mark - Public Method
- (void)createAcross {
  [self createWordArray];
  [self initHorProblem];
  [self initVerProblem];
  [self initNodeArray];
  [self createAnswerLabel];
  [self fillWithInput];
}

- (void)selectProblemWithIndex:(NSInteger)index andDirection:(NSNumber *)direction {
  [self resetColor];
  if ([direction isEqual:@(0)]) {
    CGPoint mytouch = [[self.horProblemArray objectAtIndex:index] CGPointValue];
    [self fillingLeft:mytouch];
    [self fillingRight:mytouch];
    self.currentProblemNumber = index + 1;
  } else {
    CGPoint mytouch = [[self.verProblemArray objectAtIndex:index] CGPointValue];
    [self fillDown:mytouch];
    [self fillUp:mytouch];
    self.currentProblemNumber = index + 1;
  }
  [self resetLabelColor];
  [self updateLabelText:[self getProblemText]];
  if (self.currentProblemNumber > 0) {
    [self setTextFieldText:[self getStringFromCrossWordWithStringBefore:@""]];
  }
}

- (void)textfieldReturened:(NSString *)text {
  if (self.currentProblemNumber > 0) {
    [self setAnswerStringToCrossWithString:text];
    [self saveInput:text];
  }
}

- (NSString *)textFieldWillBeginEditWithText {
  return (self.currentProblemNumber > 0) ? [self getStringFromCrossWordWithStringBefore:@""] : @"";
}

#pragma - mark Private Method

- (void)createWordArray {
  PuzzleGame *puzzleGame = [[PuzzleGame alloc]initWithPuzzleTitle:self.title size:self.size];
  self.puzzle = puzzleGame.puzzleNode;
  self.wordArray = puzzleGame.mapGrid;
  NSArray *firstArray = [self.wordArray objectAtIndex:0];
  self.wordArrayXMaxNumber = self.wordArray.count;
  self.wordArrayYMaxNumber = firstArray.count;
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
  [self addChild:self.puzzle];
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
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]];
        currentnode.texture = [SKTexture textureWithImageNamed:@"empty.png"];
      } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]];
        currentnode.texture = [SKTexture textureWithImageNamed:@"block.png"];
      }
    }
  }
}

#pragma mark - SaveMethod

- (void)saveInput:(NSString *)text {
  [Item saveInputbyDirection:(self.hor?@(0):@(1)) andOrder:@(self.currentProblemNumber - 1) andPuzzleId:self.puzzleId andInputString:text completion:^(BOOL success, NSError *error) {
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

#pragma mark - delegate sender


- (void)TextfiledResignFirstResponder {
  if ([self.delegate respondsToSelector:@selector(MySceneTextfiledResignFirstResponder)]) {
    [self.delegate MySceneTextfiledResignFirstResponder];
  }
}

- (void)setTextFieldText:(NSString *)text {
  if ([self.delegate respondsToSelector:@selector(MySceneUpdateTextFieldText:)]) {
    [self.delegate MySceneUpdateTextFieldText:text];
  }
}

- (void)resetLabelColor {
  if ([self.delegate respondsToSelector:@selector(MySceneUpdateLabelColor:)]) {
    [self.delegate MySceneUpdateLabelColor:([[self getInputText] isEqual: [self getCorrectAnswerText]]) ? [UIColor greenColor] : [UIColor blackColor]];
  }
}

- (void)updateLabelText:(NSString *)text {
  if ([self.delegate respondsToSelector:@selector(MySceneSetLabelText:)]) {
    [self.delegate MySceneSetLabelText:text];
  }
}

#pragma mark - UIScreen Tool

- (CGFloat)screenWidth {
  return [[UIScreen mainScreen] bounds].size.width;
}

- (CGFloat)screenHeight {
  return [[UIScreen mainScreen] bounds].size.height;
}

@end
