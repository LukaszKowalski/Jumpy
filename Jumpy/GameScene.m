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

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.backgroundColor = [SKColor whiteColor];
    
    world = [SKNode node];
    [self addChild:world];
    
    generator = [WorldGenerator generatorWithWorld:world];
    [self addChild:generator];
        [generator populate];
    
    hero = [Hero createHero];
    [world addChild:hero];
    
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
    [self handleGeneration];
    [self handleCleanup];
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
