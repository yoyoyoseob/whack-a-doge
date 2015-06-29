//
//  GameScene.m
//  whackadoge
//
//  Created by Yoseob Lee on 6/23/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "GameScene.h"
#import "MYDoge.h"
#import "MYScoreboard.h"
#import "MYBackground.h"
#import "MYGrumpyCat.h"
#import "MYTrollLabel.h"

@interface GameScene () <SKPhysicsContactDelegate>
@property (nonatomic, strong)   NSMutableArray  *explosionTextures;
@property (nonatomic, strong)   MYScoreboard    *scoreboard;
@property (nonatomic, strong)   MYBackground    *background;
@property (nonatomic)           CGFloat         spawnInterval;
@property (nonatomic)           BOOL            sceneHasChanged;
@property (nonatomic)           NSUInteger      streakCount;
@property (nonatomic, strong)   MYTrollLabel    *trollLabel;

@end

@implementation GameScene

#pragma mark - Game Setup
-(instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self){
        self.streakCount = 0;
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        self.sceneHasChanged = NO;
        self.spawnInterval = 1.5;
        // Load Scoreboard
        _scoreboard = [[MYScoreboard alloc]initWithWidth:self.size.width height:self.size.height];
        [self addChild:_scoreboard];
        _scoreboard.text = [NSString stringWithFormat:@"Score: %lu", _scoreboard.score];
        
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction performSelector:@selector(spawnDoge) onTarget:self], [SKAction waitForDuration:self.spawnInterval]]]] withKey:@"spawnDoge"];
        
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction performSelector:@selector(spawnGrumpyCat) onTarget:self], [SKAction waitForDuration:1]]]] withKey:@"spawnGrumpyCat"];
        
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

#pragma mark - Scene Update Method
-(void)update:(NSTimeInterval)currentTime
{
    if (self.sceneHasChanged)
    {
        [self spawnDogeWithInterval:self.spawnInterval];
        self.sceneHasChanged = NO;
    }
}

#pragma mark - Sprite Action Methods

-(void)spawnDogeWithInterval:(CGFloat)spawnInterval
{
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction performSelector:@selector(spawnDoge) onTarget:self], [SKAction waitForDuration:self.spawnInterval]]]] withKey:@"spawnDoge"];
}

-(void)spawnDoge // Spawns doge in random point on the screen
{
    MYDoge *myDoge = [[MYDoge alloc]initWithImageNamed:@"doge" width:self.size.width height:self.size.height];
    [self addChild:myDoge];
    
    [myDoge runAction:myDoge.actionSequence];
}

-(void)spawnGrumpyCat
{
    MYGrumpyCat *myGrumpyCat = [[MYGrumpyCat alloc]initWithImageNamed:@"GrumpyCatHead" width:self.size.width height:self.size.height];
    [self addChild:myGrumpyCat];
    
    [myGrumpyCat runAction:myGrumpyCat.actionSequence];
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
    if ((firstBody.categoryBitMask & grumpyCatCategory) != 0){
        
        SKNode *grumpyCat = (contact.bodyA.categoryBitMask & grumpyCatCategory) ? contact.bodyA.node : contact.bodyB.node;
        SKNode *doge = (contact.bodyA.categoryBitMask & grumpyCatCategory) ? contact.bodyB.node : contact.bodyA.node;
        [grumpyCat runAction:[SKAction removeFromParent]];
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event // NEED TO FIGURE OUT HOW TO REMOVE SPECIFIC NODES ONLY
{
    UITouch *touchedNode = [touches anyObject]; // Registers the touch
    CGPoint touchPoint = [touchedNode locationInNode:self]; // (x, y) of where the touch was
    
    SKNode *node = [self nodeAtPoint:touchPoint]; // Returns the node at touch
    
    if ([node containsPoint:touchPoint])
    {
        if ([node isKindOfClass:[MYDoge class]])
        {
            [node removeFromParent];
            self.scoreboard.score ++;
            self.scoreboard.text = [NSString stringWithFormat:@"Score: %lu", self.scoreboard.score];
            [self fadeInBackgroundWithScore:self.scoreboard.score];
            //increment spawn interval for every succesful scoring
            self.spawnInterval-= 0.05;
            
            //If you made a succesful tap, then increase streak count
            self.streakCount++;
            
            if (self.streakCount>2)
            {
                self.trollLabel = [[MYTrollLabel alloc]initWithWidth:self.size.width height:self.size.height];
                [self.trollLabel updateToRandomTrollText];
                [self addChild:self.trollLabel];
                [self.trollLabel runAction:[self.trollLabel display]];
                self.streakCount = 0;
            }
            
            //EVERY TIME the scene is changed you need change the sceneHasChanged flag so the update function doesn't try and render every single action, since not every frame needs to udpdate the action qeue.
            self.sceneHasChanged = YES;
        }
    }
}

-(void)fadeInBackgroundWithScore:(NSInteger)score
{
    if (score == 10)
    {
        // Background will spawn after [X] condition has been met - starts off pretty tame (MOVE OUT OF INITIALIZER)
        self.background = [[MYBackground alloc]initWithImageNamed:@"Background" width:self.size.width height:self.size.height];
        [self addChild:self.background];
    }
}

@end
