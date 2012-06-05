//
//  Game.h
//  AppScaffold
//

#import <Foundation/Foundation.h>

@interface Game : SPStage{
    SPSprite *currentScene;
}

- (void) showScene:(SPSprite *)scene;
- (void) showBattleScene;

@end
