//
//  Hero.m
//  Jumpy
//
//  Created by Łukasz Kowalski on 08/06/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import "Hero.h"

@implementation Hero

+ (id)createHero
{
    Hero *hero = [Hero spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(50, 50)];
    hero.name = @"hero";
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];

    SKSpriteNode *leftEye = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(5, 5)];
    leftEye.position = CGPointMake(-3, 8);
    [hero addChild:leftEye];
    
    SKSpriteNode *rightEye = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(5, 5)];
    rightEye.position = CGPointMake(11, 8);
    [hero addChild:rightEye];
    
    return hero;
}

- (void)jump
{
    [self.physicsBody applyImpulse:CGVectorMake(0, 40)];
}

- (void)start
{
    SKAction *incrementRight = [SKAction moveByX:1 y:0 duration:0.03];
    SKAction *moveRight = [SKAction repeatActionForever:incrementRight];
    [self runAction:moveRight];
}

@end
