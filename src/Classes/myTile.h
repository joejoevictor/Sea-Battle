//
//  myTile.h
//  Sea Battle
//
//  Created by Zuhao Chen on 2/01/12.
//  Copyright (c) 2012 Michigan State University. All rights reserved.
//

#import "SPSprite.h"

@interface myTile : SPSprite{
	NSMutableArray *tiles;

	int viewportWidth;
	int viewportHeight;
    
    SPPoint *camera;
}

@end
