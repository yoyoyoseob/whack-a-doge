//
//  MYTrollLabel.h
//  whackadoge
//
//  Created by Marcus Grant on 6/26/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MYTrollLabel : SKLabelNode
//@property (nonatomic, strong) SKAction *actionSequence;

-(instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;

-(SKAction *)display;

-(void)updateToRandomTrollText;


@end
