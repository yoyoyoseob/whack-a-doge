//
//  MYDoge.h
//  whackadoge
//
//  Created by Yoseob Lee on 6/24/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MYGrumpyCat.h"

static const uint8_t dogeCategory = 2;

@interface MYDoge : SKSpriteNode
@property (nonatomic, strong) SKAction *actionSequence;

-(instancetype)initWithImageNamed:(NSString *)name width:(CGFloat)width height:(CGFloat)height;
-(void)changeDogeImageToAngry;
-(SKAction *)appearMoveDisapear:(CGFloat)timeToAppear timeToMove:(CGFloat)timeToMove timeToDisappear:(CGFloat)timeToDisappear;

@end
