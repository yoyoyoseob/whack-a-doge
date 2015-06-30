//
//  GameViewController.m
//  whackadoge
//
//  Created by Yoseob Lee on 6/23/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "AVFoundation/AVFoundation.h"

@interface GameViewController ()

@end

@implementation GameViewController

// Ensures we set the correct size for our view
- (void)viewWillLayoutSubviews
{
    SKView *skView = (SKView *)self.view;
    if (!skView.scene){
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        skView.ignoresSiblingOrder = YES;
        
        // Initializes a new "SKScene" --> scene contains what will be on the screen
        // We set our current view to skView and we're setting the size of the SCENE as the size of our skView
        GameScene *scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Presents the created scene
        [skView presentScene:scene];
        

    }
}

- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    // retrieve the SCNView
    SCNView *scnView = (SCNView *)self.view;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        // highlight it
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [UIColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor redColor];
        
        [SCNTransaction commit];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
