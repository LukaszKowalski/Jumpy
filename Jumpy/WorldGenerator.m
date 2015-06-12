//
//  WorldGenerator.m
//  Jumpy
//
//  Created by Łukasz Kowalski on 08/06/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import "WorldGenerator.h"
#import "bonus.h"

@interface WorldGenerator ()

@property double currentGroundX;
@property double currentObstacleX;
@property double currentBonusX;
@property SKNode *world;
@property bonus *bonusLife;

@end

@implementation WorldGenerator

static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;


+(id)generatorWithWorld:(SKNode *)world
{
    WorldGenerator *generator = [WorldGenerator node];
    generator.currentGroundX = 0;
    generator.currentObstacleX = 400;
    generator.currentBonusX = 100;
    generator.world = world;
    

    return  generator;
}

- (void)populate
{
    for (int i = 0; i < 3; i++) {
        [self generateLevelOne];
    }
}
- (void)generateLevelOne
{
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[UIColor brownColor] size:CGSizeMake(self.scene.frame.size.width, 100)];
    ground.position = CGPointMake(self.currentGroundX, -self.scene.frame.size.height/2 + ground.frame.size.height/2);
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    ground.physicsBody.dynamic = NO;
    ground.physicsBody.categoryBitMask = groundCategory;
    ground.name = @"ground";
    
    [self.world addChild:ground];
    
    self.currentGroundX += ground.frame.size.width;
    
    SKSpriteNode *obstacle = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(40, 60)];
    obstacle.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2);
    obstacle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obstacle.size];
    obstacle.physicsBody.dynamic = NO;
    obstacle.physicsBody.categoryBitMask = obstacleCategory;
    obstacle.name = @"obstacle";
    
    self.bonusLife = [bonus createBonus];
    self.bonusLife.position = CGPointMake(self.currentBonusX,0);
    
    [self.world addChild:self.bonusLife];
    [self.world addChild:obstacle];
    
    self.currentObstacleX += 250;
    self.currentBonusX += 1500;
}
- (UIColor *)getRandomColor
{
    int rand = arc4random() % 6;
    
    UIColor *color;
    switch (rand) {
        case 0:
            color = [UIColor redColor];
            break;
        case 1:
            color = [UIColor greenColor];
        case 2:
            color = [UIColor purpleColor];
        case 3:
            color = [UIColor blueColor];
        case 4:
            color = [UIColor whiteColor];
        case 5:
            color = [UIColor yellowColor];
            break;
        default:
            break;
    }
    
    return color;
}

@end
