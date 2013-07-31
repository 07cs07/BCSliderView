# BCSliderView #
=========

BCSliderView is a animating slider view.

![iOSValidator framework screen](https://github.com/07cs07/BCSliderView/blob/master/ScreenShot.png)

### ARC Support ###
***BCSliderView*** supports ***ARC*** and for non-ARC users just add the `-fobjc-arc` compiler flag to the BCSliderView files.

### Installation ###

### Frameworks :
- **QuartzCore**

### How to use it

1. Drag-and-drop BCSliderView(.h and .m) them into your Xcode project.
2. Tick the **Copy items into destination group's folder** option.
3. Use `#import "BCSliderView.h"` in  your source files.

### Sample Code
	
```objective-c

    BCSliderView *sliderView;

    sliderView = [[BCSliderView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    sliderView.defaultValue = 7;
    [self.view addSubview:sliderView];

	// this will slide to the value given
    [sliderView slideToValue:value]; 

	// this will slide back to the previous value
    [sliderView slideBack]; 
```

*BCSliderView has two methods*

- **- (void)slideToValue:(int)value;** This lets you to update the time in UI for every secs.

- **- (void)slideBack;** This lets you to update the current lap of the timer.

 