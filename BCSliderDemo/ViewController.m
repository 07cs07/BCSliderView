//
//  ViewController.m
//  BCSliderDemo
//
//  Created by MaG~2 on 31/07/13.
//  Copyright (c) 2013 Mobs and Geeks. All rights reserved.
//

static int val = 1;

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    sliderView = [[BCSliderView alloc] initWithFrame:CGRectMake(10, 150, 100, 100)];
    sliderView.defaultValue = 7;
    [self.view addSubview:sliderView];
    
    sliderView1 = [[BCSliderView alloc] initWithFrame:CGRectMake(230, 180, 30, 30)];
    sliderView1.defaultValue = 5;
    [self.view addSubview:sliderView1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BCSlideView

- (IBAction)slide:(id)sender
{
    [sliderView slideToValue:val];
    [sliderView1 slideToValue:val];
    val++;
    val = val < 10 ? val:0;
}

- (IBAction)slideToPrevious:(id)sender
{
    [sliderView slideToValue:val-2];
    [sliderView1 slideToValue:val-2];
}

@end
