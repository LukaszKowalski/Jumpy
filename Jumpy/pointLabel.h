//
//  pointLabel.h
//  Jumpy
//
//  Created by Łukasz Kowalski on 09/06/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface pointLabel : SKLabelNode

@property int number;
+ (id)pointsLabelWithFontNamed:(NSString *)fontName;
-(void)increment;
-(void)setPoints:(int)points;
-(void)reset;


@end
