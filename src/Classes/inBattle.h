//
//  inBattle.h
//  Sea Battle
//
//  Created by Zuhao Chen on 2/01/12.
//  Copyright (c) 2012 Michigan State University. All rights reserved.
//

#import "SPSprite.h"
#import "Ship.h"

@interface inBattle : SPSprite
{
    // Ship data
    NSMutableArray *enemies;
    Ship *myShip;
    SPSprite *enemyShips;
    SPSprite *cannonFire;
    NSMutableArray *cannonBalls;
    
    // Map data
    int mapWidth;
    int mapHeight;
    
    // Other data
    int level;
    int enemyLeft;    
}

// Other Functions
-(void) initializingEnemies:(int) l;
-(void) drawEnemies;
-(void) updateAllEnemyShip;
-(void) fire:(float)angle posx:(float)posx posy:(float)posy;
-(void) drawCannonFires;
-(void) updateCannonBalls;
-(void) detectHits;

/*
- (void) initializingEnemies:(int) l;
- (void) onEnterFrame:(SPEnterFrameEvent*) event;
- (void)onTouch:(SPTouchEvent*)event;
- (void) RotateShip:(float)x y:(float)y;
*/
@end
