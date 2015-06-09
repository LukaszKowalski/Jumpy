//
//  pointLabel.m
//  Jumpy
//
//  Created by Łukasz Kowalski on 09/06/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import "pointLabel.h"

@implementation pointLabel

+ (id)pointsLabelWithFontNamed:(NSString *)fontName
{
    pointLabel *pointsLabel = [pointLabel labelNodeWithFontNamed:fontName];
    pointsLabel.text = @"0";
    pointsLabel.number = 0;
    pointsLabel.name = @"pointsLabel";
    return pointsLabel;
}

-(void)increment
{
    self.number++;
    self.text = [NSString stringWithFormat:@"%i", self.number];
}

-(void)setPoints:(int)points
{
    self.number = points;
    self.text = [NSString stringWithFormat:@"%i", self.number];
}

-(void)reset
{
    self.number = 0;
    self.text = @"0";
}

@end
