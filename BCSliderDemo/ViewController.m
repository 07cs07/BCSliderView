//
//  ViewController.m
//  BCSliderDemo
//
//  Created by MaG~2 on 31/07/13.
//  Copyright (c) 2013 Mobs and Geeks. All rights reserved.
//

static int val = 0;

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    sliderView = [[BCSliderView alloc] initWithFrame:CGRectMake(110, 150, 100, 100)];
    sliderView.defaultValue = val;
    [self.view addSubview:sliderView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BCSlideView

- (IBAction)slideToNext:(id)sender
{
    val++;
    val = val < 10 ? val:0;
    [sliderView slideToValue:val];
}

- (IBAction)slideToPrevious:(id)sender
{
    val--;
    val = val < 0 ? 9 : val;
    [sliderView slideBackToValue:val];
}

@end
