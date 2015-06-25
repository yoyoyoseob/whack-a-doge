//
//  GameScene.m
//  whackadoge
//
//  Created by Yoseob Lee on 6/23/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "GameScene.h"
#import "MYDoge.h"
#import "MYSpaceship.h"
#import "MYScoreboard.h"
#import "MYBackground.h"

@interface GameScene () <SKPhysicsContactDelegate>
@property (nonatomic, strong) NSMutableArray *explosionTextures;
@property (nonatomic, strong) MYScoreboard *scoreboard;
@property (nonatomic, strong) MYBackground *background;

@end

@implementation GameScene

#pragma mark - Game Setup
-(instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self){
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        // Load Scoreboard
        _scoreboard = [[MYScoreboard alloc]initWithWidth:self.size.width height:self.size.height];
        [self addChild:_scoreboard];
        _scoreboard.text = [NSString stringWithFormat:@"Score: %lu", _scoreboard.score];
        
        
        _background = [[MYBackground alloc]initWithImageNamed:@"Background" width:self.size.width height:self.size.height];
        [self addChild:_background];
        
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction performSelector:@selector(spawnDoge) onTarget:self], [SKAction waitForDuration:1]]]] withKey:@"spawnDoge"];
        
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction performSelector:@selector(spawnSpaceship) onTarget:self], [SKAction waitForDuration:1]]]] withKey:@"spawnSpaceship"];
        
        // Load Textures
        SKTextureAtlas *explosionAtlas = [SKTextureAtlas atlasNamed:@"EXPLOSION"];
        NSArray *textureNames = [explosionAtlas textureNames];
        _explosionTextures = [NSMutableArray new];
        for (NSString *name in textureNames) {
            SKTexture *texture = [explosionAtlas textureNamed:name];
            [_explosionTextures addObject:texture];
        }
    }
    return self;
}

-(void)spawnDoge // Spawns doge in random point on the screen
{
    MYDoge *myDoge = [[MYDoge alloc]initWithImageNamed:@"doge" width:self.size.width height:self.size.height];
    [self addChild:myDoge];
    
    [myDoge runAction:myDoge.actionSequence];
}

-(void)spawnSpaceship
{
    MYSpaceship *mySpaceship = [[MYSpaceship alloc]initWithImageNamed:@"Spaceship" width:self.size.width height:self.size.height];
    [self addChild:mySpaceship];
    
    [mySpaceship runAction:mySpaceship.actionSequence];
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else{
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    if ((firstBody.categoryBitMask & spaceshipCategory) != 0){
        
        SKNode *spaceship = (contact.bodyA.categoryBitMask & spaceshipCategory) ? contact.bodyA.node : contact.bodyB.node;
        SKNode *doge = (contact.bodyA.categoryBitMask & spaceshipCategory) ? contact.bodyB.node : contact.bodyA.node;
        [spaceship runAction:[SKAction removeFromParent]];
        [doge runAction:[SKAction removeFromParent]];
        
        // add explosions
        SKSpriteNode *explosion = [SKSpriteNode spriteNodeWithTexture:[_explosionTextures objectAtIndex:0]];
        explosion.zPosition = 1;
        explosion.scale = 0.6;
        explosion.position = contact.bodyA.node.position;
        
        [self addChild:explosion];
        
        SKAction *explosionAction = [SKAction animateWithTextures:_explosionTextures timePerFrame:0.05];
        SKAction *remove = [SKAction removeFromParent];
        [explosion runAction:[SKAction sequence:@[explosionAction,remove]]];
    }
}

#pragma mark - Game Actions
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touchedNode = [touches anyObject]; // Registers the touch
    CGPoint touchPoint = [touchedNode locationInNode:self]; // (x, y) of where the touch was
    
    SKNode *node = [self nodeAtPoint:touchPoint]; // Returns the node at touch
    
//    SKAction *zoomIn = [SKAction scaleTo:1.67 duration:10];
//    [self.background runAction:zoomIn];
    
    if ([node containsPoint:touchPoint]){
        [node removeFromParent];
        self.scoreboard.score ++;
        self.scoreboard.text = [NSString stringWithFormat:@"Score: %lu", self.scoreboard.score];

    }
}

@end
