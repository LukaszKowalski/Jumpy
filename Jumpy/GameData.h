//
//  GameData.h
//  Jumpy
//
//  Created by Łukasz Kowalski on 6/10/15.
//  Copyright (c) 2015 Lukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property int highscore;
+ (id)data;
- (void)save;
- (void)load;


@end
