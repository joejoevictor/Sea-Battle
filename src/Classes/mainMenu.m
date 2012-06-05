//
//  mainMenu.m
//  Sea Battle
//
//  Created by Zuhao Chen on 2/01/12.
//  Copyright (c) 2012 Michigan State University. All rights reserved.
//

#import "mainMenu.h"
#import "Game.h"

@implementation mainMenu

- (id)init
{
    if ((self = [super init]))
    {
        SPImage *backgroundImage = [[SPImage alloc] initWithContentsOfFile:@"Ship.jpg"];
        SPTexture *buttonTexture = [[SPTexture alloc] initWithContentsOfFile:@"button_main_menu.png"];
        SPButton *startButton = [[SPButton alloc] initWithUpState:buttonTexture text:@"START"];
        
        // Buttons Positioning
        startButton.y = 240 - 15;
        startButton.x = 160 - 51;
        
        [startButton addEventListener:@selector(onStartButtonTriggered:) atObject:self
                               forType:SP_EVENT_TYPE_TRIGGERED];
        
        [self addChild:backgroundImage];
        [self addChild:startButton];
    }
    return self;
}

- (void) onStartButtonTriggered:(SPEvent *)event
{
    [(Game *)self.stage showBattleScene];
}

@end
