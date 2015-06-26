//
//  MYSpaceship.m
//  whackadoge
//
//  Created by Yoseob Lee on 6/24/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "MYSpaceship.h"

@interface MYSpaceship ()
@property (nonatomic, strong) NSArray *sidesArray;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@end

#define ARC4RANDOM_MAX      0x100000000
static inline CGFloat RandomRange(CGFloat min, CGFloat max){
    return floorf(((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min);
}

@implementation MYSpaceship

-(instancetype)initWithImageNamed:(NSString *)name width:(CGFloat)width height:(CGFloat)height
{
    self = [super initWithImageNamed:name];
    if (self)
    {
        _width = width;
        _height = height;
        
        self.size = CGSizeMake(50, 44); // Default size is 394 x 347
        self.name = @"spaceship";
        self.zPosition = 1;
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = spaceshipCategory;
        self.physicsBody.contactTestBitMask = dogeCategory;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.usesPreciseCollisionDetection = YES;
    
        _actionSequence = [SKAction sequence:@[[self selectStartingPoint]]];
    }
    return self;
}

-(SKAction *)selectStartingPoint
{
    self.sidesArray = @[@"Top", @"Bottom", @"Left", @"Right"];
    
    NSInteger randomIndex = (NSInteger)RandomRange(0, 4);
    NSString *randomSide = self.sidesArray[randomIndex];
    
    if ([randomSide isEqualToString:@"Top"])
    {
        CGPoint startLocation = CGPointMake(RandomRange(0, self.width), self.height + 50);
        CGPoint endLocation = CGPointMake(RandomRange(0, self.width), -50);
        self.position = startLocation;

        return [self returnActionSequenceWithStartingLocation:startLocation endLocation:endLocation];
    }
    else if ([randomSide isEqualToString:@"Bottom"])
    {
        CGPoint startLocation = CGPointMake(RandomRange(0, self.width), -50);
        CGPoint endLocation = CGPointMake(RandomRange(0, self.width), self.height + 50);
        self.position = startLocation;
        
        return [self returnActionSequenceWithStartingLocation:startLocation endLocation:endLocation];
    }
    else if ([randomSide isEqualToString:@"Left"])
    {
        CGPoint startLocation = CGPointMake(-50, RandomRange(0, self.height));
        CGPoint endLocation = CGPointMake(self.width + 50, RandomRange(0, self.height));
        self.position = startLocation;
        
        return [self returnActionSequenceWithStartingLocation:startLocation endLocation:endLocation];
    }
    else
    {
        CGPoint startLocation = CGPointMake(self.width + 50, RandomRange(0, self.height));
        CGPoint endLocation = CGPointMake(-50, RandomRange(0, self.height));
        self.position = startLocation;
       
        return [self returnActionSequenceWithStartingLocation:startLocation endLocation:endLocation];
    }
}

-(SKAction *)returnActionSequenceWithStartingLocation:(CGPoint)startLocation endLocation:(CGPoint)endLocation
{
    CGFloat angle = atan2(startLocation.y - endLocation.y, startLocation.x - endLocation.x);
    
    SKAction *rotate = [SKAction rotateToAngle:(angle + M_PI_2) duration:1];
    SKAction *flyBy = [SKAction moveTo:endLocation duration:5];
    SKAction *removeFromParent = [SKAction removeFromParent];
    
    SKAction *shipActionSequence = [SKAction sequence:@[rotate, flyBy, removeFromParent]];
    return shipActionSequence;
}

@end
