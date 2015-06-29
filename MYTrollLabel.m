//
//  MYTrollLabel.m
//  whackadoge
//
//  Created by Marcus Grant on 6/26/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "MYTrollLabel.h"

#define ARC4RANDOM_MAX      0x100000000

static inline CGFloat RandomRange(CGFloat min, CGFloat max){
    return floorf(((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min);
}

@implementation MYTrollLabel

-(instancetype)initWithString:(NSString *)text
                        color:(UIColor *)color
          horizontalBoundrary:(CGFloat)horizontalBoundrary
            verticalBoundrary:(CGFloat)verticalBoundrary
{
    self = [super initWithFontNamed:@"ComicSansMS"];
    if (!self)
    {
        self.text = text;
        self.color  = color;
        _horizontalBoundrary    = horizontalBoundrary;
        _verticalBounrary       = verticalBoundrary;
        
        UIFont *comicSans       = [UIFont fontWithName:@"ComicSansMS" size:32];
        
        self.position           = CGPointMake(RandomRange(0, horizontalBoundrary - 60),
                                              RandomRange(0, verticalBoundrary - 100));
        self.alpha              = 1;
        self.fontName           = @"ComicSansMS";
        self.fontColor          = color;
        self.zPosition          = 10;
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (!self)
    {
        self.text = [[NSString alloc]init];
    }
    return self;
}

-(SKAction *)display
{
    //self.alpha = 0;
    SKAction *fadeInAction      = [SKAction fadeInWithDuration:0.3];
    SKAction *waitForDuration   = [SKAction waitForDuration:2];
//    SKAction *wiggleClockwise   = [SKAction rotateByAngle:M_PI/6 duration:0.2];
//    SKAction *wiggleCClockwise  = [SKAction rotateByAngle:-M_PI/6 duration:0.2];
//    SKAction *wiggleWiggle      = [SKAction sequence:@[wiggleClockwise,wiggleCClockwise,wiggleClockwise,wiggleCClockwise]];
    SKAction *fadeOutAction     = [SKAction fadeOutWithDuration:0.3];
    SKAction *removeFromParent  = [SKAction removeFromParent];
    SKAction *displaySequence   = [SKAction sequence:@[fadeInAction]];
    
    return displaySequence;
}

@end
