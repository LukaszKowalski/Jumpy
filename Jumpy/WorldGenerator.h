//
//  WorldGenerator.h
//  Jumpy
//
//  Created by Łukasz Kowalski on 08/06/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WorldGenerator : SKNode

+(id)generatorWithWorld:(SKNode *)world;
-(void)generateLevelOne;
-(void)populate;

@end
