//
//  bonus.m
//  Jumpy
//
//  Created by Łukasz Kowalski on 12/06/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import "bonus.h"

@interface bonus ()

@end

@implementation bonus

static const uint32_t heroCategory = 0x1 << 0;
static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;
static const uint32_t bonusCategory = 0x1 << 3;

+ (id)createBonus
{
    
    SKSpriteNode *bonus = [SKSpriteNode spriteNodeWithImageNamed:@"heart.png"];
    bonus.size = CGSizeMake(40, 20);
    bonus.position = CGPointMake(100,0);
    bonus.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bonus.size];
    bonus.physicsBody.dynamic = NO;
    bonus.physicsBody.categoryBitMask = bonusCategory;
    bonus.physicsBody.collisionBitMask = heroCategory;
    bonus.physicsBody.contactTestBitMask = heroCategory;
    bonus.name = @"bonus";
    return bonus;
}


@end
