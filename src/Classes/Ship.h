//
//  Ship.h
//  Sea Battle
//
//  Created by Zuhao Chen on 2/01/12.
//  Copyright (c) 2012 Michigan State University. All rights reserved.
//

#import "SPSprite.h"

@interface Ship : SPSprite{
    float posX;
    float posY;
    float xM;
    float yM;
    
    float shipAngle;
    
    // Ship Image
    SPImage *image;
    
    int HP;
    int speed;
}

// Setter
-(void) setPosX:(float)posx;
-(void) setPosY:(float)posy;
-(void) setXM:(float)XM;
-(void) setYM:(float)YM;
-(void) setShipAngle:(float)ang;
-(void) setHP:(int)hp;

// Getter
-(float) getPosX;
-(float) getPosY;
-(float) getXM;
-(float) getYM;
-(float) getShipAngle;
-(SPImage *) getImage;
-(int) getHP;

// Other Functions
-(float) computeAngle:(float)xVal yVal:(float)yVal;
-(void) updateShipPos;
-(void) updateMyShipPos;
- (void) RotateShip:(float)x y:(float)y;
- (void) RotateShip:(float)angle;
//-(void) setTarget:(float)posx posy:(float)posy target:(Ship *)target;
-(void) setTarget:(Ship *)target;
/*
-(void) setup:(int) posx posY:(int)posy;
-(void) updatePos;
-(void) update:(SPEnterFrameEvent *) event;
-(void) setPosX:(int)posx;
-(void) setPosY:(int)posy;
-(void) setXM:(int)xm;
-(void) setYM:(int)ym;
-(float) calAngle:(float)xVal yVal:(float)yVal;
 */
@end
