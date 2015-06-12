//
//  GameScene.m
//  Jumpy
//
//  Created by Łukasz Kowalski on 6/7/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import "GameScene.h"
#import "Hero.h"
#import "WorldGenerator.h"
#import "pointLabel.h"
#import "GameData.h"
#import "bonus.h"

@interface GameScene ()

@property BOOL isStarted;
@property BOOL isGameOver;
@property bonus *bonusLife;


@end
@implementation GameScene
{
    Hero *hero;
    SKNode *world;
    WorldGenerator *generator;

}

static NSString *game_font = @"AmericanTypewriter-Bold";

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.backgroundColor = [SKColor colorWithRed:0.54 green:0.7853 blue:1.0 alpha:1.0];
    self.physicsWorld.contactDelegate = self;
    
    world = [SKNode node];
    [self addChild:world];
    
    generator = [WorldGenerator generatorWithWorld:world];
    [self addChild:generator];
    [generator populate];
    
    hero = [Hero createHero];

    [world addChild:hero];
    

    
    SKLabelNode *tapToBeginLabel = [SKLabelNode labelNodeWithFontNamed:game_font];
    tapToBeginLabel.text = @"Tap to begin";
    tapToBeginLabel.fontSize = 20;
    tapToBeginLabel.name = @"tapToBeginLabel";
    [self addChild:tapToBeginLabel];
    [self animateWithPulse:tapToBeginLabel];
    
    [self loadClouds];
    [self loadScoreLabels];
    [self loadLifes];
    
    self.bonusLife = [bonus nodeWithFileNamed:@"bonus"];

}

- (void)loadLifes
{
    
    int heartXPosition = - 250;

    for (int i=0; i < hero.heroLifeLeft; i++){
    SKSpriteNode *heart = [SKSpriteNode spriteNodeWithImageNamed:@"heart"];
    heart.size = CGSizeMake(100, 50);
    heart.position = CGPointMake(heartXPosition, 120);
    heartXPosition += 50;
    heart.name = @"heart";
    
    [self addChild:heart];
    }
}

- (void)loadScoreLabels
{
    GameData *data = [GameData data];
    [data load];
    
    pointLabel *pointsLabel = [pointLabel pointsLabelWithFontNamed:game_font];
    pointsLabel.position = CGPointMake(0, 120);
    
    [self addChild:pointsLabel];
    
    pointLabel *highScore = [pointLabel pointsLabelWithFontNamed:game_font];
    highScore.position = CGPointMake(200, 120);
    [highScore setPoints:data.highscore];
    highScore.name = @"highScore";
    
    [self addChild:highScore];
    
    SKLabelNode *bestLabel = [SKLabelNode labelNodeWithFontNamed:game_font];
    bestLabel.position = CGPointMake(-38, 0);
    bestLabel.text = @"best";
    bestLabel.fontSize = 16.0;
    [highScore addChild:bestLabel];
    
}

- (void)loadClouds
{
    SKShapeNode *cloud1 = [SKShapeNode node];
    cloud1.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 65, 100, 40)].CGPath;
    cloud1.fillColor = [UIColor whiteColor];
    cloud1.strokeColor = [UIColor blackColor];
    
    [world addChild: cloud1];
    
    SKShapeNode *cloud2 = [SKShapeNode node];
    cloud2.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-250, 45, 100, 40)].CGPath;
    cloud2.fillColor = [UIColor whiteColor];
    cloud2.strokeColor = [UIColor blackColor];
    
    [world addChild: cloud2];
}

-(void)startMoving
{
    self.isStarted = YES;
    [[self childNodeWithName:@"tapToBeginLabel"] removeFromParent];
    [hero start];
}

-(void)clear
{
    GameScene *scene = [GameScene sceneWithSize:self.frame.size];
    [self.view presentScene:scene];
}

-(void)gameOver
{
    if (hero.heroLifeLeft == 0) {
    
    self.isGameOver = YES;
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:game_font];
    gameOverLabel.text = @"Game Over";
    gameOverLabel.position = CGPointMake(0, 60);
    [self addChild:gameOverLabel];
    
    SKLabelNode *tapToResetLabel = [SKLabelNode labelNodeWithFontNamed:game_font];
    tapToResetLabel.text = @"Tap to reset";
    tapToResetLabel.fontSize = 20;
    tapToResetLabel.name = @"tapToResetLabel";
    [self addChild:tapToResetLabel];
    [self animateWithPulse:tapToResetLabel];
    [hero stop];
    
//    [self runAction:[SKAction playSoundFileNamed:@"onGameOver.mp3" waitForCompletion:NO]];
    
    [self updateHighscore];
        
    }
}
- (void)updateHighscore
{
    pointLabel *pointsLabel = (pointLabel *)[self childNodeWithName:@"pointsLabel"];
    pointLabel *highScore = (pointLabel *)[self childNodeWithName:@"highScore"];
    
    if (pointsLabel.number > highScore.number ){
        [highScore setPoints:pointsLabel.number];
        
        GameData *data = [GameData data];
        data.highscore = pointsLabel.number;
        
        [data save];
    }
                                         
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.isStarted){
        [self startMoving];
    }else if (self.isGameOver){
        [self clear];
    }else{
        [hero jump];
    }
}
-(void)didSimulatePhysics
{
    [self centerOnNode:hero];
    [self handlePoints];
    [self handleGeneration];
    [self handleCleanup];

}
-(void)handleHearts
{
    [self enumerateChildNodesWithName:@"heart" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
}

-(void)handlePoints
{
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x) {
            pointLabel *pointsLabel = (pointLabel*)[self childNodeWithName:@"pointsLabel"];
            [pointsLabel increment];
        }
    }];
}
-(void)handleGeneration;
{
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x) {
            node.name = @"obstacle_cancelled";
            [generator generateLevelOne];
        }
    }];
}
-(void)handleCleanup
{
    [world enumerateChildNodesWithName:@"ground" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x <hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
    
    [world enumerateChildNodesWithName:@"obstacle_cancelled" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
}
- (void)getBonus
{
    NSLog(@"getBonus");
    hero.heroLifeLeft = hero.heroLifeLeft + 1;
    [self handleHearts];
    [self loadLifes];
    

}

-(void)centerOnNode:(SKNode *)node
{
    CGPoint positionInScene = [self convertPoint:node.position fromNode:node.parent];
    world.position = CGPointMake(world.position.x -positionInScene.x, world.position.y);
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"didBegin");
    if ([contact.bodyA.node.name isEqualToString: @"ground"] || [contact.bodyB.node.name isEqualToString: @"ground"]){
        [hero land];
    }else if([contact.bodyA.node.name isEqualToString:@"bonus"] && [contact.bodyB.node.name isEqualToString:@"hero"] && !self.bonusLife.isTouched){
        
        
        NSLog(@"p1 %lul", (unsigned long)contact.bodyA.node.hash);
        [contact.bodyA.node removeFromParent];
        NSLog(@"p2 %ol", contact.bodyA.node.parent);
        
//        NSLog(@"bonus");
//        [world enumerateChildNodesWithName:@"bonus" usingBlock:^(SKNode *node, BOOL *stop) {
//            NSLog(@"%@", node.name);
//            [node removeFromParent];
        
//        }];
        self.bonusLife.isTouched = YES;
        [self getBonus];
        
    }else if([contact.bodyA.node.name isEqualToString:@"hero"] && [contact.bodyB.node.name isEqualToString:@"bonus"]){
//        [world enumerateChildNodesWithName:@"bonus" usingBlock:^(SKNode *node, BOOL *stop) {
//            NSLog(@"%@", node.name);
//            [node removeFromParent];
    }
    
    else{
        hero.heroLifeLeft = hero.heroLifeLeft -  1;
        [self handleHearts];
        [self loadLifes];
        [self gameOver];
    }
}

// Animate //
-(void)animateWithPulse:(SKNode*)node
{
    SKAction *disappear = [SKAction fadeAlphaTo:0.0 duration:0.6];
    SKAction *appear = [SKAction fadeAlphaTo:1.0 duration:0.6];
    SKAction *pulse = [SKAction sequence:@[disappear, appear]];
    [node runAction:[SKAction repeatActionForever:pulse]];
}
@end
