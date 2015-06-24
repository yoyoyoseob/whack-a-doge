//
//  MYSpaceship.m
//  whackadoge
//
//  Created by Yoseob Lee on 6/24/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "MYSpaceship.h"

#define ARC4RANDOM_MAX      0x100000000
static inline CGFloat RandomRange(CGFloat min, CGFloat max){
    return floorf(((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min);
}

@implementation MYSpaceship

-(instancetype)initWithImageNamed:(NSString *)name width:(CGFloat)width height:(CGFloat)height
{
    self = [super initWithImageNamed:@"Spaceship"];
    if (self){
        
        self.size = CGSizeMake(50, 44); // Default size is 394 x 347
        
        CGPoint startLocation = CGPointMake(-50, RandomRange(0, height));
        self.position = startLocation;
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = spaceshipCategory;
        self.physicsBody.contactTestBitMask = dogeCategory;
        self.physicsBody.collisionBitMask = 0;
        
        self.name = @"spaceship";
        
        CGPoint endLocation = CGPointMake(width + 50, RandomRange(0, height)); // Where the ship will end up
        
        CGFloat angle = atan2(startLocation.y - endLocation.y, startLocation.x - endLocation.x);
        
        SKAction *rotate = [SKAction rotateToAngle:(angle + M_PI_2) duration:1];
        
        SKAction *flyBy = [SKAction moveTo:endLocation duration:5];
        SKAction *removeFromParent = [SKAction removeFromParent];
        _actionSequence = [SKAction sequence:@[rotate, flyBy, removeFromParent]];
    }
    return self;
}

@end
