//
//  MYBackground.m
//  whackadoge
//
//  Created by Yoseob Lee on 6/25/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "MYBackground.h"

@interface MYBackground ()
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic, strong) NSMutableArray *backgroundGIF;
@property (nonatomic, strong) NSMutableArray *backgroundGIF2;

@end

@implementation MYBackground

-(instancetype)initWithImageNamed:(NSString *)name width:(CGFloat)width height:(CGFloat)height
{
    self = [super initWithTexture:[_backgroundGIF objectAtIndex:0]];
    if (self)
    {
        _width = width;
        _height = height;
        self.size = CGSizeMake(400, 400);
        self.position = CGPointMake(_width/2, _height/2);
        self.name = @"geometric background";
        self.zPosition = 0;
        self.xScale = 1.67;
        self.yScale = 1.67;
        self.alpha = 0;
        
        
        //load all texture files for all backgrounds
        SKTextureAtlas  *backgroundAtlas = [SKTextureAtlas atlasNamed:name];
        NSArray         *textureNames = [backgroundAtlas textureNames];
        SKTextureAtlas  *backgroundAtlas2 = [SKTextureAtlas atlasNamed:@"background2"];
        NSArray         *textureNames2 = [backgroundAtlas2 textureNames];
        
        _backgroundGIF = [NSMutableArray new];
        _backgroundGIF2 = [NSMutableArray new];
        for (NSString *name in textureNames)
        {
            SKTexture *texture = [backgroundAtlas textureNamed:name];
            [_backgroundGIF addObject:texture];
        }
        for (NSString *name in textureNames2)
        {
            SKTexture *texture = [backgroundAtlas2 textureNamed:name];
            [_backgroundGIF2 addObject:texture];
        }
        
        
        
        [self animateBackground];
    }
    return self;
}

-(void)animateBackground
{
    SKAction *fadeIn = [SKAction fadeInWithDuration:60];
    [self runAction:fadeIn];
    
    SKAction *animation = [SKAction repeatActionForever:[SKAction animateWithTextures:_backgroundGIF timePerFrame:0.03f resize:NO restore:YES]];
    
    [self runAction:[SKAction sequence:@[animation]] withKey:@"animateBackground"];
}

-(void)transitionToNextBackground
{
    [self runAction:[SKAction fadeOutWithDuration:2]];
    SKAction *fadeInNewBG = [SKAction fadeInWithDuration:10];
    SKAction *changeBG = [SKAction animateWithTextures:_backgroundGIF2 timePerFrame:.02f resize:NO restore:YES];
    SKAction *BGSequence = [SKAction repeatActionForever:changeBG];
    [self runAction:[SKAction fadeInWithDuration:10]];
    [self runAction:BGSequence];
}

@end
