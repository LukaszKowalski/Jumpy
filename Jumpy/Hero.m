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

    return hero;
}

- (void)walkRight
{
    SKAction *goRight = [SKAction moveByX:10 y:0 duration:0];
    [self runAction:goRight];
}

@end
