/*
 * Copyright (C) 2013 Mobs and Geeks
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the
 * License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author Balachander.M <chicjai@gmail.com>
 * @version 0.1
 */


#import "BCSliderView.h"
#import <QuartzCore/QuartzCore.h>
#import "CoreImage/CoreImage.h"

#define HALF_FLIP_DURATION 0.5

@implementation MyLayerDelegate

- (id)initWithLayerFrame:(CGRect)layerFrame
{
    self = [super init];
    if (self) {
         _layerFrame = layerFrame;
    }
    return self;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{   
    for (CALayer *subLayer in layer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
    // Customize here.
    CATextLayer *labelTextLayer = [[CATextLayer alloc] init];
    [labelTextLayer setFont:@"Helvetica-Bold"];
    
    int fontSize = (60 * MIN(_layerFrame.size.width,_layerFrame.size.height)) / 75;
    
    [labelTextLayer setFontSize:fontSize];
    [labelTextLayer setFrame:_layerFrame];
    [labelTextLayer setBackgroundColor:[UIColor blackColor].CGColor];
    [labelTextLayer setString:[NSString stringWithFormat:@"%d",_value]];
    [labelTextLayer setAlignmentMode:kCAAlignmentCenter];
    [labelTextLayer setForegroundColor:[[UIColor whiteColor] CGColor]];
    [labelTextLayer setShadowColor:[UIColor whiteColor].CGColor];
    [labelTextLayer setShadowOffset:CGSizeMake(0,1)];
    [labelTextLayer setCornerRadius:4];
    [labelTextLayer setBorderColor:[UIColor grayColor].CGColor];
    [labelTextLayer setBorderWidth:4];

    [layer addSublayer:labelTextLayer];
}

@end

@interface BCSliderView ()

- (void)setDefaultLayers;

@end

@implementation BCSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {    
        CGRect layerRect = self.bounds;

        layerDelegate = [[MyLayerDelegate alloc] initWithLayerFrame:layerRect];
        layerDelegate.value = 0;
        [self setDefaultLayers];
    }
    return self;
}

- (void)setDefaultValue:(int)defaultValue
{
    _defaultValue = defaultValue;
    [layerDelegate setValue:_defaultValue];
    [frontLayer setNeedsDisplay];
}

#pragma mark - SetLayersContents

- (void)setDefaultLayers
{
    frontLayer = [CALayer layer];
    frontLayer.delegate = layerDelegate;
    frontLayer.frame = self.bounds;
    [frontLayer setNeedsDisplay];

    backLayer = [CALayer layer];
    backLayer.delegate = layerDelegate;
    backLayer.frame = self.bounds;
    [frontLayer setNeedsDisplay];
    
    [self.layer addSublayer:backLayer];
    [self.layer addSublayer:frontLayer];

    CATransform3D aTransform = CATransform3DIdentity;
    float zDistance = 1000;
    aTransform.m34 = 1.0 / -zDistance;
    [self layer].sublayerTransform = aTransform;
}

#pragma mark - Animation Sections

- (void)slideToValue:(int)value
{
    [layerDelegate setValue:value];
    [backLayer setNeedsDisplay];
    
    [self performSelector:@selector(changeFrontLayer) withObject:nil afterDelay:0.01];
}

- (void)slideBack
{    
    CATransform3D  topTransform = CATransform3DIdentity;
    topTransform = CATransform3DTranslate(topTransform, 0, -self.frame.size.height, 0);
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath: @"transform"];
    transformAnimation.delegate = self;
    transformAnimation.fillMode = kCAFillModeForwards;
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.toValue = [NSValue valueWithCATransform3D:topTransform];
    transformAnimation.duration = HALF_FLIP_DURATION;
    [transformAnimation setValue:@"BackSlideTop" forKey:@"Slide"];
    [frontLayer addAnimation:transformAnimation forKey:nil];
}

- (void)changeFrontLayer
{
    CATransform3D  topTransform = CATransform3DIdentity;
    topTransform = CATransform3DTranslate(topTransform, 0, -self.frame.size.height, 0);
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath: @"transform"];
    transformAnimation.delegate = self;
    transformAnimation.fillMode = kCAFillModeForwards;
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.toValue = [NSValue valueWithCATransform3D:topTransform];
    transformAnimation.duration = HALF_FLIP_DURATION;
    [transformAnimation setValue:@"FrontSlideTop" forKey:@"Slide"];
    [backLayer addAnimation:transformAnimation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *animationKeyValue = [anim valueForKey:@"Slide"];
    if ([animationKeyValue isEqualToString:@"FrontSlideTop"])
    {
        CATransform3D  rootTransform = CATransform3DIdentity;
        CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath: @"transform"];
        transformAnimation.delegate = nil;
        transformAnimation.fillMode = kCAFillModeForwards;
        transformAnimation.removedOnCompletion = NO;
        transformAnimation.toValue = [NSValue valueWithCATransform3D:rootTransform];
        transformAnimation.duration = HALF_FLIP_DURATION;
        [backLayer addAnimation:transformAnimation forKey:nil];
        
        CATransform3D  backTransform = CATransform3DIdentity;
        backTransform = CATransform3DTranslate(backTransform, 0, 0, -10);
        CABasicAnimation *tran = [CABasicAnimation animationWithKeyPath: @"transform"];
        tran.delegate = self;
        tran.fillMode = kCAFillModeForwards;
        tran.removedOnCompletion = NO;
        [tran setValue:@"Bottom" forKey:@"Slide"];
        tran.toValue = [NSValue valueWithCATransform3D:backTransform];
        tran.duration = HALF_FLIP_DURATION;
        [frontLayer addAnimation:tran forKey:nil];
    }
    
    if ([animationKeyValue isEqualToString:@"BackSlideTop"])
    {
        CATransform3D  rootTransform = CATransform3DIdentity;
        rootTransform = CATransform3DTranslate(rootTransform, 0, 0, 0);
        CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath: @"transform"];
        transformAnimation.delegate = nil;
        transformAnimation.fillMode = kCAFillModeForwards;
        transformAnimation.removedOnCompletion = NO;
        transformAnimation.toValue = [NSValue valueWithCATransform3D:rootTransform];
        transformAnimation.duration = 0.1;
        [backLayer addAnimation:transformAnimation forKey:nil];
        
        CATransform3D  backTransform = CATransform3DIdentity;
        backTransform = CATransform3DTranslate(backTransform, 0, 0, -10);
        CABasicAnimation *tran = [CABasicAnimation animationWithKeyPath: @"transform"];
        tran.delegate = self;
        tran.fillMode = kCAFillModeForwards;
        tran.removedOnCompletion = NO;
        [tran setValue:@"Bottom" forKey:@"Slide"];
        tran.toValue = [NSValue valueWithCATransform3D:backTransform];
        tran.duration = HALF_FLIP_DURATION;
        [frontLayer addAnimation:tran forKey:nil];
    }

    if([animationKeyValue isEqualToString:@"Bottom"])
    {
        //Swape the layers
        CALayer *swapeLayer = frontLayer;
        frontLayer = backLayer;
        backLayer = swapeLayer;
        [frontLayer setHidden:NO];
        [backLayer setHidden:NO];
    }
}

@end
