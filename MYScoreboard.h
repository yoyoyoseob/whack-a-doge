//
//  MYScoreboard.h
//  whackadoge
//
//  Created by Yoseob Lee on 6/25/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MYScoreboard : SKLabelNode
@property (nonatomic) NSUInteger score;

-(instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;

@end
