///////////////////////////////////////////////////////////////
// AssistiveTouchView.m
// author:sundayliu
// date: 2016.07.31
///////////////////////////////////////////////////////////////

#import "AssistiveTouchView.h"

///////////////////////////////////////////////////////
//// AssistiveTouchView
///////////////////////////////////////////////////////

@implementation AssistiveTouchView

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    printf("***[core-view]pointInside:(%f,%f)\n", point.x,point.y);
    NSLog(@"[core-view]event:%@", event);
    printf("[core-view]pointInside:bounds(%f,%f,%f,%f)\n", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    printf("[core-view]pointInside:frame(%f,%f,%f,%f)\n", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);

    
    if (CGRectContainsPoint(self.frame, point)){
        printf("***[core-view]pointInside:YES\n");
        return YES;
    }

    
    printf("***[core-view]pointInside:NO\n");
    return NO;
}


@end


///////////////////////////////////////////////////////
//// AssistiveTouchBackgroundView
///////////////////////////////////////////////////////
@implementation AssistiveTouchBackgroundView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        // self.alpha = 0.5f;
    }
    
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    printf("***[core-background]pointInside:(%f,%f)\n", point.x,point.y);
    NSLog(@"[core-background]event:%@", event);
    printf("[core-background]pointInside:bounds(%f,%f,%f,%f)\n", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    printf("[core-background]pointInside:frame(%f,%f,%f,%f)\n", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    
    for (UIView* subview in self.subviews){
        if (subview.hidden || subview.alpha <= 0.01 || !self.userInteractionEnabled){
            continue;
        }
        CGPoint pt = [subview.layer convertPoint:point toLayer:self.layer];
        
        printf("[core-background]pointInside:(%f,%f)-(%f,%f)\n", point.x,point.y, pt.x, pt.y);
        
        if ([subview pointInside:point withEvent:event]){
            printf("***[core-background]pointInside:YES\n");
            return YES;
        }
    }
    
    printf("***[core-background]pointInside:NO\n");
    return NO;
}


@end


///////////////////////////////////////////////////////
//// AssistiveTouchIconView
///////////////////////////////////////////////////////
static const CGFloat TXAlertViewOffsetX = 5.0;
static const CGFloat TXAlertViewOffsetY = 5.0;
static const CGFloat TXAlertViewWidth = 60.0;
static const CGFloat TXAlertViewHeight = 60.0;

@interface AssistiveTouchIconView()

@property(strong, nonatomic)UILabel* label;

@end

@implementation AssistiveTouchIconView

-(id)init{
    self = [super init];
    if (self){
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(
                                                               TXAlertViewOffsetX,
                                                               TXAlertViewOffsetY,
                                                               TXAlertViewWidth - TXAlertViewOffsetX*2,
                                                               TXAlertViewHeight - TXAlertViewOffsetY*2)];
        self.label.text = @"X";
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:50];
        self.label.lineBreakMode = NSLineBreakByWordWrapping;
        self.label.numberOfLines = 0;
        [self addSubview:self.label];
        
        self.backgroundColor = [UIColor colorWithWhite:0.25 alpha:1];
        self.layer.cornerRadius = 30.0;
        self.layer.opacity = .95;
        self.clipsToBounds = YES;
        self.frame = CGRectMake(30, 30, TXAlertViewWidth, TXAlertViewHeight);
    }
    
    return self;
}

@end


///////////////////////////////////////////////////////
//// AssistiveTouchContentView
///////////////////////////////////////////////////////
@implementation AssistiveTouchContentView



@end