//
//  WorldGenerator.m
//  Jumpy
//
//  Created by Łukasz Kowalski on 08/06/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import "WorldGenerator.h"

@interface WorldGenerator ()

@property double currentGroundX;
@property double currentObstacleX;
@property SKNode *world;

@end

@implementation WorldGenerator

+(id)generatorWithWorld:(SKNode *)world
{
    WorldGenerator *generator = [WorldGenerator node];
    generator.currentGroundX = 0;
    generator.currentObstacleX = 400;
    generator.world = world;
    

    return  generator;
}

- (void)populate
{
    for (int i = 0; i < 3 ; i++) {
        [self generate];
    }
}
- (void)generate
{
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(self.scene.frame.size.width, 100)];
    ground.position = CGPointMake(self.currentGroundX, -self.scene.frame.size.height/2 + ground.frame.size.height/2);
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    ground.physicsBody.dynamic = NO;
    ground.name = @"ground";
    
    [self.world addChild:ground];
    
    self.currentGroundX += ground.frame.size.width;
    
    SKSpriteNode *obstacle = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(40, 70)];
    obstacle.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2);
    obstacle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obstacle.size];
    obstacle.physicsBody.dynamic = NO;
    obstacle.name = @"obstacle"; 
    
    [self.world addChild:obstacle];
    
    self.currentObstacleX += 250;
}

@end
