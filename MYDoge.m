//
//  MYDoge.m
//  whackadoge
//
//  Created by Yoseob Lee on 6/24/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "MYDoge.h"

#define ARC4RANDOM_MAX      0x100000000
static inline CGFloat RandomRange(CGFloat min, CGFloat max){
    return floorf(((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min);
}

@implementation MYDoge

-(instancetype)initWithImageNamed:(NSString *)name width:(CGFloat)width height:(CGFloat)height
{
    self = [super initWithImageNamed:name];
    if (self){
        
        self.size = CGSizeMake(65, 68.9);
        self.position = CGPointMake(RandomRange(0, width), RandomRange(0, height - 55));
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = YES;
        self.physicsBody.categoryBitMask = dogeCategory;
        self.physicsBody.contactTestBitMask = spaceshipCategory;
        self.physicsBody.collisionBitMask = 0;
        
        self.name = @"doge";
        self.xScale = 0; // We set the x/y scale to 0 to make them invisible, used for animation to "spawn" doge (gets bigger from 0 to 1)
        self.yScale = 0;
        
        // Actions that relate to the spawning of food
        SKAction *appear = [SKAction scaleTo:1.0 duration:0.5];
        SKAction *disappear = [SKAction scaleTo:0.0 duration:0.5];
        SKAction *waitOnScreen = [SKAction waitForDuration:.5];
        SKAction *removeFromParent = [SKAction removeFromParent];
        SKAction *moveOnScreen = [SKAction moveTo:CGPointMake(RandomRange(0, width), RandomRange(0, height - 55)) duration:5];

        _actionSequence = [SKAction sequence:@[appear, waitOnScreen, moveOnScreen, disappear, removeFromParent]];
    }
    return self;
}

@end
