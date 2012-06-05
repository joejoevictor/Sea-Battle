//
//  Game.m
//  AppScaffold
//

#import "Game.h"
#import "mainMenu.h"
#import "inBattle.h"

@implementation Game

- (id)initWithWidth:(float)width height:(float)height
{
    if ((self = [super initWithWidth:width height:height]))
    {
        mainMenu *menuScene = [[mainMenu alloc] init];
        [self showScene:menuScene];
        [menuScene release];
    }
    return self;
}

- (void) showScene:(SPSprite *)scene 
{
    if ([self containsChild:currentScene]) {
        [self removeChild:currentScene];
    }
    [self addChild:scene];
    currentScene = scene;
}

- (void) showBattleScene
{
    inBattle *battleScene = [[inBattle alloc] init];
    [self showScene:battleScene];
    [battleScene release];
}

@end
