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

@interface GameScene ()

@property BOOL isStarted;
@property BOOL isGameOver;

@end
@implementation GameScene
{
    Hero *hero;
    SKNode *world;
    WorldGenerator *generator;

}

static NSString *game_font = @"Helvetica";

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.backgroundColor = [SKColor blueColor];
    self.physicsWorld.contactDelegate = self;
    
    world = [SKNode node];
    [self addChild:world];
    
    generator = [WorldGenerator generatorWithWorld:world];
    [self addChild:generator];
        [generator populate];
    
    hero = [Hero createHero];
    [world addChild:hero];
    
    pointLabel *pointsLabel = [pointLabel pointsLabelWithFontNamed:game_font];
    pointsLabel.position = CGPointMake(-200, 100);
    
    [self addChild:pointsLabel];
    
}
-(void)startMoving
{
    self.isStarted = YES;
    [hero start];
}

-(void)clear
{

}

-(void)gameOver
{
    self.isGameOver = YES;
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:game_font];
    gameOverLabel.text = @"Game Over";
    gameOverLabel.position = CGPointMake(0, 60);
    [self addChild:gameOverLabel];
    
    [hero stop];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.isStarted){
        NSLog(@"dupa");
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
            [generator generate];
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
    [self gameOver];
}

@end
