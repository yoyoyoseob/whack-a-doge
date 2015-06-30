//
//  MYBackground.h
//  whackadoge
//
//  Created by Yoseob Lee on 6/25/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MYBackground : SKSpriteNode

-(instancetype)initWithImageNamed:(NSString *)name width:(CGFloat)width height:(CGFloat)height;
-(void)transitionToNextBackground;


@end
