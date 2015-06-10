//
//  Hero.m
//  Jumpy
//
//  Created by Łukasz Kowalski on 08/06/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import "Hero.h"

@interface Hero ()
@property BOOL isJumping;
@end

@implementation Hero

static const uint32_t heroCategory = 0x1 << 0;
static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;


+ (id)createHero
{
    Hero *hero = [Hero spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(40, 40)];
    hero.name = @"hero";
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];
    hero.physicsBody.categoryBitMask = heroCategory;
    hero.physicsBody.contactTestBitMask = obstacleCategory | groundCategory;

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
    if (!self.isJumping)
    {
        [self.physicsBody applyImpulse:CGVectorMake(0, 47)];
        self.isJumping = YES;
        [self runAction:[SKAction playSoundFileNamed:@"onJump.wav" waitForCompletion:NO]];
    }
}

- (void)start
{
    SKAction *incrementRight = [SKAction moveByX:1 y:0 duration:0.006];
    SKAction *moveRight = [SKAction repeatActionForever:incrementRight];
    [self runAction:moveRight];
}
- (void)stop
{
    [self removeAllActions];
}
- (void)land
{
    self.isJumping = NO;
}

@end
