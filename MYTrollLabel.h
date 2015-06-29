//
//  MYTrollLabel.h
//  whackadoge
//
//  Created by Marcus Grant on 6/26/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface MYTrollLabel : SKLabelNode

@property   (strong, nonatomic) NSString        *text;
@property   (nonatomic)         CGFloat         horizontalBoundrary;
@property   (nonatomic)         CGFloat         verticalBounrary;


-(instancetype)initWithString:(NSString *)text
                        color:(UIColor *)color
          horizontalBoundrary:(CGFloat)horizontalBoundrary
            verticalBoundrary:(CGFloat)verticalBoundrary;

-(instancetype) init;

-(SKAction *)   display;


@end
