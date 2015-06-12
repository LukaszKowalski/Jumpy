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

+ (id)createBonus
{
    
    SKSpriteNode *bonus = [SKSpriteNode spriteNodeWithImageNamed:@"heart.png"];
    bonus.size = CGSizeMake(40, 20);
    bonus.position = CGPointMake(100,0);
    bonus.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bonus.size];
    bonus.physicsBody.dynamic = NO;
    bonus.name = @"bonus";
    return bonus;
}


@end
