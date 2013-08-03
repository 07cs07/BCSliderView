# BCSliderView #

**BCSliderView** is a animating slider view.
**BCSliderView** supports ***ARC*** and for non-ARC users just add the `-fobjc-arc` compiler flag to the BCSliderView files.

![BCSliderView screen](https://raw.github.com/07cs07/BCSliderView/master/ScreenShot.gif)

### How to use it

1. Add **QuartzCore** framework to your project.
2. Drag-and-drop BCSliderView(.h and .m) them into your Xcode project.
3. Tick the **Copy items into destination group's folder** option.
4. Use `#import "BCSliderView.h"` in  your source files.

### Sample Code
	
```objective-c

    BCSliderView *sliderView;

    sliderView = [[BCSliderView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    sliderView.defaultValue = 7;
    [self.view addSubview:sliderView];
```
 **- (void)slideToValue:(int)value;** *This lets you to slide to the desired value given.*
```objective-c
	// this will slide to the value given
    [sliderView slideToValue:value];
```
 **- (void)slideBackToValue:(int)value;** *This lets you to slide back to the value given.*
```objective-c
	// this will slide back to the previous value
    [sliderView slideBackToValue:value];
```
