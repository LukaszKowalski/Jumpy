//
//  Hero.h
//  Jumpy
//
//  Created by Łukasz Kowalski on 08/06/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Hero : SKSpriteNode

@property int heroLifeLeft;

+(id)createHero;
- (void)jump;
- (void)start;
- (void)stop;
- (void)land;

@end
