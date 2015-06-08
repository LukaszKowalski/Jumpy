//
//  GameScene.m
//  Jumpy
//
//  Created by Łukasz Kowalski on 6/7/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import "GameScene.h"
#import "Hero.h"

@interface GameScene ()

@property BOOL isStarted;
@property BOOL isGameOver;

@end
@implementation GameScene
{
    Hero *hero;
    SKNode *world;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.backgroundColor = [SKColor whiteColor];
    
    world = [SKNode node];
    [self addChild:world];
    
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(self.frame.size.width, 100)];
    ground.position = CGPointMake(0, -self.frame.size.height/2 + ground.frame.size.height/2);
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    ground.physicsBody.dynamic = NO;
    
    [world addChild:ground];
    
    hero = [Hero createHero];
    [world addChild:hero];
}
-(void)start
{
    self.isStarted = YES;
    [hero start];
}

-(void)clear
{

}

-(void)gameOver
{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.isStarted){
        [hero start];
    }
    [hero jump];
    
}
-(void)didSimulatePhysics
{
    [self centerOnNode:hero];
}
-(void)centerOnNode:(SKNode *)node
{
    CGPoint positionInScene = [self convertPoint:node.position fromNode:node.parent];
    world.position = CGPointMake(world.position.x -positionInScene.x, world.position.y);
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
