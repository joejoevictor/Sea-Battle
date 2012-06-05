//
//  myTile.m
//  Sea Battle
//
//  Created by Zuhao Chen on 2/01/12.
//  Copyright (c) 2012 Michigan State University. All rights reserved.
//

#import "myTile.h"

@implementation myTile

-(id) init
{
    if ((self = [super init]))
    {
        viewportHeight = 480;
        viewportWidth = 320;
        
        SPTexture *oceanTexture = [[SPTexture alloc] initWithContentsOfFile:@"ocean.png"];
        for (int yy =0; yy < viewportHeight ; yy++)
        {
            for(int xx = 0; xx < viewportWidth ; xx++)
            {
                SPImage *oceanImage = [[SPImage alloc] initWithTexture:oceanTexture];
                oceanImage.x = xx;
                oceanImage.y = yy;
                [self addChild:oceanImage];
            }
        }
    }
    return self;
}

@end
