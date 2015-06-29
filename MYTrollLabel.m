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

@interface MYTrollLabel ()

@property (strong, nonatomic) NSArray *trollTexts;

@end

@implementation MYTrollLabel

-(instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height
{
    self = [super init];
    if (self)
    {
        //UIFont *comicSans = [UIFont fontWithName:@"ComicSansMS" size:32];
        
        self.alpha = 0;
        self.fontName = @"ComicSansMS";
        self.position = CGPointMake(RandomRange(0, width), RandomRange(0, height));
        self.fontColor = [UIColor whiteColor];
        self.fontSize = 30;
        self.zPosition = 1;
        
        _trollTexts = @[@"Wow.",@"amaze",@"vury skil", @"such ponts",@"excite",@"so scare", @"WOW", @"Amaze", @"much kat", @"w00f", @"very sdeep", @"much fast", @"doge style ;-)", @"doge wid it", @"Wow.", @"v3ry gamplay"];
        
        
        
        
        
        //_actionSequence = [SKAction sequence:@[[self display]]];
    }
    return self;
}

-(SKAction *)display
{
    SKAction *wiggleClockwise   = [SKAction rotateByAngle:M_PI/6 duration:0.2];
    SKAction *wiggleCClockwise  = [SKAction rotateByAngle:-M_PI/6 duration:0.2];
    SKAction *wiggleWiggle      = [SKAction sequence:@[wiggleClockwise,wiggleCClockwise,wiggleClockwise,wiggleCClockwise]];
    
    SKAction *fadeInAction = [SKAction fadeInWithDuration:1];
    SKAction *waitForDuration = [SKAction waitForDuration:2];
    SKAction *fadeOutAction = [SKAction fadeOutWithDuration:1];
    SKAction *removeFromParent = [SKAction removeFromParent];
    SKAction *displaySequence = [SKAction sequence:@[fadeInAction, wiggleWiggle, waitForDuration, fadeOutAction, removeFromParent]];
    
    return displaySequence;
}

-(void)updateToRandomTrollText
{
    self.text = self.trollTexts[(NSUInteger) RandomRange(0, self.trollTexts.count)];
    //TODO: add random colors as well
}

@end
