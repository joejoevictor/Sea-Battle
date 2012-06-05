//
//  Ship.m
//  Sea Battle
//
//  Created by Zuhao Chen on 2/01/12.
//  Copyright (c) 2012 Michigan State University. All rights reserved.
//

#import "Ship.h"
#include <stdlib.h>

@implementation Ship

-(id) init
{
    if ((self = [super init]))
    {
        HP = 3;
        
        // Position Initialization
        posX = 0;
        posY = 0;
        xM = 2;
        yM = 2;
        
        speed = 2;
        
        // Angle initialization
        shipAngle = [self computeAngle:posX yVal:posY];
        
        // Image initialization
        image = [[SPImage alloc] initWithContentsOfFile:@"myShip.png"];
        image.scaleX = 0.4;
        image.scaleY = 0.4;
        image.x = -image.width / 2.0f;
        image.y = -image.height / 2.0f;
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

-(void) setShipAngle:(float)ang
{
    shipAngle = ang;
    /*
    int tX = xM;
    int tY = yM;
    float len = sqrt(pow(tX,2)+pow(tY,2));
    xM = cos(ang) * len;
    yM = -(sin(ang) * len);
    NSLog(@"xM:%f ",xM);
    NSLog(@"yM:%f ",yM);*/
}

-(void) setHP:(int)hp
{
    HP = hp;
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

-(float) getShipAngle
{
    return shipAngle;
}

-(SPImage *) getImage
{
    return image;
}

-(int) getHP
{
    return HP;
}

// Other Functions
-(float) computeAngle:(float)xVal yVal:(float)yVal
{
    float angle = atan2(yVal, xVal);
    return angle;
}

-(void) updateShipPos
{
    float tempX = [self getPosX];
    float tempY = [self getPosY];
    
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
    //[self RotateShip:[self computeAngle:xM yVal:-yM]];
    NSLog(@"posX:%f",posX);
    NSLog(@"posY:%f",posY);
}

-(void) updateMyShipPos
{
    float tempX = [self getPosX];
    float tempY = [self getPosY];
    
    if (tempX < 1000.0 || tempX > 0.0)
    {
        tempX += [self getXM];
    }
    else
    {
        [self setXM:-([self getXM])];
        tempX += [self getXM];
    }
    
    if (tempY < 1000.0 || tempY > 0.0)
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

- (void) RotateShip:(float)x y:(float)y
{
    //    float angle = atan(y/x);
    float angle = atan2(y,x);
    self.rotation = angle+SP_D2R(90);
}

- (void) RotateShip:(float)angle
{
    self.rotation = angle + SP_D2R(90);
}

/*
-(void) setTarget:(float)posx posy:(float)posy target:(Ship *)target
{
    double angle = [target computeAngle:[target getPosX] yVal:[target getPosY]];
    [self RotateShip:[self computeAngle:posx yVal:posy]];
    [self setShipAngle:atan2(posy, posx)];
    float len = sqrt(pow(xM,2)+pow(yM,2));
    xM = cos(angle) * len;
    NSLog(@"xM:%f",xM);
    yM = sin(angle) * len;
    NSLog(@"yM:%f",yM);
}*/

-(void) setTarget:(Ship *)target
{
    float dVectorX = ([target getPosX] - posX);
    float dVectorY = -([target getPosY] - posY);
    float tempAngle = [self computeAngle:dVectorX yVal:dVectorY];
    [self setShipAngle:tempAngle];
    
    [self setXM:(cos(tempAngle) * speed)];
    [self setYM:-(sin(tempAngle) * speed)];
    
    [self getImage].rotation = -atan2(dVectorY,dVectorX) + SP_D2R(90);
    
    /*if ((tempAngle >= SP_D2R(0)) && (tempAngle < SP_D2R(90)))
    {
        xM = cos(tempAngle) * len;
        yM = sin(tempAngle) * len;
    }
    else if ((tempAngle >= SP_D2R(90)) && (tempAngle <= SP_D2R(180)))
    {
        xM = cos(tempAngle) * len;
        yM = sin(tempAngle) * len;
    }
    else if ((tempAngle >= (-SP_D2R(90))) && (tempAngle < SP_D2R(0)))
    {
        xM = cos(tempAngle) * len;
        yM = sin(tempAngle) * len;
    }
    else
    {
        xM = cos(tempAngle) * len;
        yM = sin(tempAngle) * len;
    }*/
    NSLog(@"xM:%f",xM);
    NSLog(@"yM:%f",yM);
}

/*
-(id) initEnemyType
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

-(void) setup:(int) posX posY:(int)posY
{
    SPImage *image = [[SPImage alloc] initWithTexture:[SPTexture textureWithContentsOfFile:@"myShip.png"]];
    [self addChild:image];
    self.x = posX;
    self.y = posY;
    
    [self addEventListener:@selector(update:)  atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

-(void) updatePos
{
    if ((x + xM) <= 1000 ||(x + xM) >=0)
    {
        x += xM;
    }
    else
    {
        xM = -xM;
        x += xM;
    }
    
    if((y + yM) <= 1000 || (y + yM) >=0)
    {   
        y += yM;
    }
    else
    {
        yM = -yM;
        y += yM;
    }
    
    xM = (arc4random()%40) - 20;
    yM = (arc4random()%40) - 20;
    
    shipAngle = [self calAngle:xM yVal:yM];
}

-(void) update:(SPEnterFrameEvent*) event
{
    [self updatePos];
    [self removeAllChildren];
    
    SPImage *image = [[SPImage alloc] initWithTexture:[SPTexture textureWithContentsOfFile:@"myShip.png"]];
    image.x = self.x;
    image.y = self.y;
    [self addChild:image];
}

-(void) setPosX:(int)posx
{
    self.x = posx;
}

-(void) setPosY:(int)posy
{
    self.y = posy;
}

-(void) setXM:(int)xm
{
    self.xM = xm;
}

-(void) setYM:(int)ym
{
    self.yM = ym;
}

-(float) calAngle:(float)xVal yVal:(float)yVal
{
    float angle = atan(yVal/xVal);
    return angle;
}
*/
@end
