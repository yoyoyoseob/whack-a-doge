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
    if (self)
    {
        //UIFont *comicSans = [UIFont fontWithName:@"ComicSansMS" size:32];

        self.fontName = @"ComicSansMS";
        self.position = CGPointMake(width/2, height - 55);
        self.fontColor = [UIColor whiteColor];
        self.fontSize = 30;
        self.zPosition = 1;
    }
    return self;
}

@end
