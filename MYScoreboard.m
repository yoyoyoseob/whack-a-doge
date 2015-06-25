//
//  MYScoreboard.m
//  whackadoge
//
//  Created by Yoseob Lee on 6/25/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "MYScoreboard.h"

@implementation MYScoreboard

-(instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height
{
    self = [super init];
    if (self){
        self.position = CGPointMake(width/2, height - 55);
        self.fontColor = [UIColor whiteColor];
        self.fontSize = 30;
    }
    return self;
}

@end
