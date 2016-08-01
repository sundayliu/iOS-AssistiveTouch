///////////////////////////////////////////////////////////////
// AssistiveTouchWindow.m
// author:sundayliu
// date: 2016.07.31
///////////////////////////////////////////////////////////////

#import "AssistiveTouchWindow.h"

@implementation AssistiveTouchWindow

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.windowLevel = UIWindowLevelAlert + 100;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

// Passing touch events through to views below
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView* hitTestView = [super hitTest:point withEvent:event];
    if (hitTestView == self){
        return nil;
    }
    return hitTestView;
}

- (void) addSubview:(UIView *)view{
    printf("***[core-window]addSubView\n");
    [super addSubview:view];
}

@end

