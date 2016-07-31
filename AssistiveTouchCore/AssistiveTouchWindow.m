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
        self.windowLevel = UIWindowLevelAlert + 10;
        self.backgroundColor = [UIColor clearColor];
        // self.alpha = 0.4f;
    }
    
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    printf("***[core-window]pointInside:(%f,%f)\n", point.x,point.y);
    NSLog(@"[core-window]event:%@", event);
    printf("[core-window]pointInside:bounds(%f,%f,%f,%f)\n", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    printf("[core-window]pointInside:frame(%f,%f,%f,%f)\n", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    
    for (UIView* subview in self.subviews){
        if (subview.hidden || subview.alpha <= 0.01 || !self.userInteractionEnabled){
            continue;
        }
        CGPoint pt = [subview.layer convertPoint:point toLayer:self.layer];
        
        printf("[core-window]pointInside:(%f,%f)-(%f,%f)\n", point.x,point.y, pt.x, pt.y);
        
        if ([subview pointInside:pt withEvent:event]){
            printf("***[core-window]pointInside:YES\n");
            return YES;
        }
    }
    
    printf("***[core-window]pointInside:NO\n");
    return NO;
}

- (void) addSubview:(UIView *)view{
    printf("***[core-window]addSubView\n");
    [super addSubview:view];
}

@end

