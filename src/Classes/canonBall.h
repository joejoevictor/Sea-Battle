//
//  canonBall.h
//  Sea Battle
//
//  Created by Zuhao Chen on 2/20/12.
//  Copyright (c) 2012 Michigan State University. All rights reserved.
//

#import "SPSprite.h"

@interface canonBall : SPSprite{
    float posX;
    float posY;
    float xM;
    float yM;
    
    float cannonAngle;
    
    SPImage *image;
    
    int timeCounter;
}

-(id) initWithAngle:(float)angle posx:(float)posx posy:(float)posy;

// Setter
-(void) setPosX:(float)posx;
-(void) setPosY:(float)posy;
-(void) setXM:(float)XM;
-(void) setYM:(float)YM;

// Getter
-(float) getPosX;
-(float) getPosY;
-(float) getXM;
-(float) getYM;
-(SPImage *) getImage;

//Other
-(void) updateBallPos;
-(void) update:(SPEnterFrameEvent*) event;

@end
