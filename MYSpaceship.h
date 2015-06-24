//
//  MYSpaceship.h
//  whackadoge
//
//  Created by Yoseob Lee on 6/24/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MYDoge.h"

static const uint8_t spaceshipCategory = 1;

@interface MYSpaceship : SKSpriteNode
@property (nonatomic, strong) SKAction *actionSequence;

-(instancetype)initWithImageNamed:(NSString *)name width:(CGFloat)width height:(CGFloat)height;

@end
