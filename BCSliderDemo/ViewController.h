//
//  ViewController.h
//  BCSliderDemo
//
//  Created by MaG~2 on 31/07/13.
//  Copyright (c) 2013 Mobs and Geeks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCSliderView.h"

@interface ViewController : UIViewController
{
    CALayer *frontLayer;
    CALayer *backLayer;
    BCSliderView *sliderView;
    BCSliderView *sliderView1;
}

- (IBAction)slide:(id)sender;
- (IBAction)slideToPrevious:(id)sender;

@end
