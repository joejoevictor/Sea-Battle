//
//  inBattle.m
//  Sea Battle
//
//  Created by Zuhao Chen on 2/01/12.
//  Copyright (c) 2012 Michigan State University. All rights reserved.
//

#import "inBattle.h"
#import "myTile.h"
#include <stdlib.h>
#include "canonBall.h"

@implementation inBattle

- (id) init
{
    if ((self = [super init]))
    {
        
        /* 
         *  Player's ship initialization
         */
        /*
        SPImage *ship = [[SPImage alloc] initWithContentsOfFile:@"myShip.png"];
        ship.x = -ship.width / 2.0f;
        ship.y = -ship.height / 2.0f;
        myShip = [[Ship alloc] init];
        [myShip addChild:ship];
        [myShip setX:160];
        [myShip setY:240];*/
        
        myShip = [[Ship alloc] init];
        // Set position in map
        [myShip setPosX:500];
        [myShip setPosY:500];
        // Set ship position
        [myShip setX:160];
        [myShip setY:240];
        
        
        
        /* 
         *  Map initialization
         */
        myTile *map = [[myTile alloc] init];
        mapHeight = 1000;
        mapWidth = 1000;
        
        /*
         *  Enemy ship initialization
         */
        enemyShips = [[SPSprite alloc] init];
        [self initializingEnemies:4];
        
        /*
         *  Cannon fires container initialization
         */
        cannonFire = [[SPSprite alloc] init];
        cannonBalls = [[NSMutableArray alloc] init];
        
        /*
         *  Text - Including level displays and enemy ship left
         */
        SPTextField *levelTextField = [[SPTextField alloc] initWithText:[NSString stringWithFormat:@"Level: %d", level]];
        levelTextField.fontName = @"Marker Felt";
        levelTextField.x = 160;
        levelTextField.y = 7;
        levelTextField.vAlign = SPVAlignTop;
        levelTextField.hAlign = SPHAlignRight;
        levelTextField.fontSize = 20;
        SPTextField *enemyTextField = [[SPTextField alloc] initWithText:[NSString stringWithFormat:@"Enemy: %d", enemyLeft]];
        enemyTextField.fontName = @"Marker Felt";
        enemyTextField.x = 0;
        enemyTextField.y = 7;
        enemyTextField.vAlign = SPVAlignTop;
        enemyTextField.fontSize = 20;
        
        
        [self addChild:map];
        [self addChild:enemyShips];
        [self addChild:myShip];
        [self addChild:levelTextField];
        [self addChild:enemyTextField];
        
        [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
        [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    return self;
}

// Other Functions
-(void) initializingEnemies:(int)l
{
    enemies = [[NSMutableArray alloc] initWithObjects: nil];
    for( int i=0 ; i < l ; i++ )
    {
        Ship *newEnemy = [[Ship alloc] init];
        //[newEnemy setup:arc4random()%1000 posY:arc4random()%1000];
        [newEnemy setPosX:[myShip getPosX]-100+(arc4random()%200)];
        [newEnemy setPosY:[myShip getPosY]-100+(arc4random()%200)];
        [enemies addObject:newEnemy];
        enemyLeft++;
    }
}

-(void) drawEnemies
{
    [enemyShips removeAllChildren];
    for(id Ship in enemies)
    {
        if ((abs([myShip getPosX] - [Ship getPosX]) <= 160) && (abs([myShip getPosY] - [Ship getPosY]) <= 240)){
            [[Ship getImage] setX:(160+([Ship getPosX]-[myShip getPosX]))];
            [[Ship getImage] setY:(240+([Ship getPosY]-[myShip getPosY]))];
            [enemyShips addChild:Ship];
        }
    }
}

-(void) updateAllEnemyShip
{
    for(id Ship in enemies)
    {
        [Ship setTarget:myShip];
        [Ship updateShipPos];
//        [Ship setTarget:[Ship getPosX] posy:[Ship getPosY]];
    }
}

-(void) updateMyShipPos
{
    [myShip updateMyShipPos];
}

-(void) onEnterFrame:(SPEnterFrameEvent*) event
{
    [self updateAllEnemyShip];
    [self updateCannonBalls];
    [self detectHits];
    [self drawEnemies];
    [self drawCannonFires];
    [self updateMyShipPos];
    //NSLog(@"posX:%f , posY:%f ", [myShip getPosX], [myShip getPosY]);
    //NSLog(@"xM:%f , yM:%f ", [myShip getXM], [myShip getYM]);
}

- (void)onTouch:(SPTouchEvent*)event
{
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    if (touch)
    {
        SPPoint *touchPosition = [touch locationInSpace:self];
        float tempX = touchPosition.x - 160;
        float tempY = 240 - touchPosition.y;
        
        float rad = sqrt(pow(tempX,2) + pow(tempY,2));
        
        if(rad <= 60)
        {
            float angle = atan2([myShip getYM], [myShip getXM]);
            [self fire:[myShip getShipAngle] posx:[myShip getPosX] posy:[myShip getPosY]];
        }
        else
        {
            float xPos = (touchPosition.x -160);
            float yPos = (touchPosition.y -240);
            [myShip RotateShip:xPos y:yPos];
            //NSLog(@"xPos:%f , yPos:%f",xPos, yPos);
            //float len = sqrt(pow(xPos,2) + pow(yPos, 2));
            float len2 = sqrt(pow([myShip getXM],2) + pow([myShip getYM], 2));
            float angle = atan2(yPos, xPos);
            [myShip setXM:(cos(angle)*len2)];
            [myShip setYM:(sin(angle)*len2)];
            //NSLog(@"angle:%f",angle);
            [myShip setShipAngle:angle];
            //NSLog(@"xM:%f , yM:%f ", [myShip getXM], [myShip getYM]);
        }
    }
}

-(void) fire:(float)angle posx:(float)posx posy:(float)posy
{
    canonBall *newLeft = [[canonBall alloc] initWithAngle:angle-SP_D2R(90) posx:posx posy:posy];
    canonBall *newRight = [[canonBall alloc] initWithAngle:angle+SP_D2R(90) posx:posx posy:posy];
    
    //if([cannonBalls count] <= 6)
    {
        [cannonBalls addObject:newLeft];
        [cannonBalls addObject:newRight];
    }
}

-(void) drawCannonFires;
{
    [cannonFire removeAllChildren];
    for(id Balls in cannonBalls)
    {
        if ((abs([myShip getPosX] - [Balls getPosX]) <= 160) && (abs([myShip getPosY] - [Balls getPosY]) <= 240))
        {
            [[Balls getImage] setX:(160-([myShip getPosX] - [Balls getPosX]))];
            [[Balls getImage] setY:(240-([myShip getPosY] - [Balls getPosY]))];
            [enemyShips addChild:Balls];
        }
    }
}

-(void) updateCannonBalls
{
    for(id Balls in cannonBalls)
    {
        [Balls updateBallPos];
    }
}

-(void) detectHits
{
    NSMutableArray *toDelete=[[NSMutableArray alloc] init];
    for(id Ship in enemies)
    {
        for (id Balls in cannonBalls) 
        {
            if((([Ship getPosX]) <= [Balls getPosX]+25) && (([Ship getPosX]) >= [Balls getPosX]-25))
            {
                if((([Ship getPosY]) <= [Balls getPosY]+25) && (([Ship getPosY]) >= [Balls getPosY]-25))
                {
                    int tempHP = [Ship getHP];
                    tempHP--;
                    [Ship setHP:tempHP];
                    if(tempHP <= 0)
                    {
                        SPTween *T=[SPTween tweenWithTarget:Ship time:1.0];
                        [T animateProperty:@"alpha" targetValue:0.0];
                        [self.stage.juggler addObject:T];
                        [T addEventListener:@selector(didFinishSinking:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
                    }
                    
                    [cannonFire removeChild:Balls];
                    //[cannonBalls removeObject:Balls];
                    [toDelete addObject:Balls];
                    //[Balls dealloc];
                }
            }
        }
    }
    [cannonBalls removeObjectsInArray:toDelete];
}

-(void)didFinishSinking:(SPEvent*)event{
    SPTween *T=(SPTween*) event.target;
    [enemies removeObject:(Ship*)T.target];
    [enemyShips removeChild:(Ship*)T.target];
}

/*
- (void) RotateShip:(float)x y:(float)y
{
//    float angle = atan(y/x);
    float angle = atan2(y,x);
    NSLog(@"angle: %f",
          angle);
    myShip.rotation = angle+SP_D2R(90);
}*/

- (void) Fire
{
    
}

@end
