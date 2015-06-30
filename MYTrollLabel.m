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
@property (strong, nonatomic) NSArray *trollColors;

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
        self.position = CGPointMake(RandomRange(100, width-100), RandomRange(10, height-60));
        self.fontColor = [UIColor whiteColor];
        self.fontSize = 42;
        self.zPosition = 1;
        
        _trollTexts = @[@"Wow.",@"amaze",@"vury skil", @"such ponts",@"excite",@"so scare",
                        @"WOW", @"Amaze", @"much kat", @"w00f", @"much fast",
                        @"doge style ;-)", @"doge wid it"];
        
        _trollColors = @[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],
                         [UIColor magentaColor],[UIColor whiteColor],[UIColor cyanColor]];
        
        
        
        
        //_actionSequence = [SKAction sequence:@[[self display]]];
    }
    return self;
}

-(SKAction *)display
{
    //Create action sequence to wiggle the label
    SKAction *initialWiggle         = [SKAction rotateByAngle:M_PI/12 duration:0.1];
    SKAction *wiggleClockwise       = [SKAction rotateByAngle:-M_PI/6 duration:0.1];
    SKAction *wiggleAntiClockwise   = [SKAction rotateByAngle:M_PI/6 duration:0.1];
    SKAction *wiggleWiggle          = [SKAction sequence:@[initialWiggle,wiggleClockwise,
                                                           wiggleAntiClockwise,wiggleClockwise,
                                                           wiggleAntiClockwise,wiggleClockwise,
                                                           initialWiggle]];
    
    //create the complete action sequence
    SKAction *fadeInAction = [SKAction fadeInWithDuration:.3];
    SKAction *waitForDuration = [SKAction waitForDuration:0.5];
    SKAction *fadeOutAction = [SKAction fadeOutWithDuration:.5];
    SKAction *removeFromParent = [SKAction removeFromParent];
    SKAction *displaySequence = [SKAction sequence:@[fadeInAction, wiggleWiggle, waitForDuration,
                                                     fadeOutAction, removeFromParent]];
    
    return displaySequence;
}

-(void)updateToRandomTrollText
{
    self.text  = self.trollTexts[(NSUInteger) RandomRange(0, self.trollTexts.count)];
    self.fontColor = self.trollColors[(NSUInteger) RandomRange(0, self.trollColors.count)];
}

@end
