//
//  canonBall.m
//  Sea Battle
//
//  Created by Zuhao Chen on 2/24/12.
//  Copyright (c) 2012 Michigan State University. All rights reserved.
//

#import "canonBall.h"

@implementation canonBall

-(id) initWithAngle:(float)angle posx:(float)posx posy:(float)posy
{
    if ((self = [super init]))
    {
        posX = posx;
        posY = posy;
        xM = 20.0;
        yM = 20.0;
        cannonAngle = angle;
        float len = sqrt(pow(xM,2) + pow(yM, 2));
        
        xM = cos(angle)*len;
        yM = sin(angle)*len;
        
        timeCounter = 0;
        
        image = [[SPImage alloc] initWithContentsOfFile:@"cannonBall.png"];
        [self addEventListener:@selector(update:)  atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
        [self addChild:image];
    }
    return self;
}

// Setters
-(void) setPosX:(float)posx
{
    posX = posx;
}

-(void) setPosY:(float)posy
{
    posY = posy;
}

-(void) setXM:(float)XM
{
    xM = XM;
}

-(void) setYM:(float)YM
{
    yM = YM;
}

// Getters
-(float) getPosX
{
    return posX;
}

-(float) getPosY
{
    return posY;
}

-(float) getXM
{
    return xM;
}

-(float) getYM
{
    return yM;
}

-(SPImage *) getImage
{
    return image;
}

-(void) updateBallPos
{
    int tempX = [self getPosX];
    int tempY = [self getPosY];
    
    if (tempX < 1000 || tempX > 0)
    {
        tempX += [self getXM];
    }
    else
    {
        [self setXM:-([self getXM])];
        tempX += [self getXM];
    }
    if (tempY < 1000 || tempY > 0)
    {
        tempY += [self getYM];
    }
    else
    {
        [self setYM:-([self getYM])];
        tempY += [self getYM];
    }
    
    [self setPosX:tempX];
    [self setPosY:tempY];
}

-(void) update:(SPEnterFrameEvent*) event
{
    timeCounter++;
    if (timeCounter == 100)
    {
        [self dealloc];
    }
}

@end
