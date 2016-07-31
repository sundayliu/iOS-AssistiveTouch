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
    //NSLog(@"[core-view]event:%@", event);
    printf("[core-view]pointInside:bounds(%f,%f,%f,%f)\n", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    printf("[core-view]pointInside:frame(%f,%f,%f,%f)\n", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);

    return [super pointInside:point withEvent:event];
    
//    if (CGRectContainsPoint(self.frame, point)){
//        printf("***[core-view]pointInside:YES\n");
//        return YES;
//    }
    
//    for (UIView* subview in self.subviews) {
//        CGRect frame = subview.frame;
//        CGRect bounds = subview.bounds;
//        
//        printf("\t[core-view]pointInside:bounds(%f,%f,%f,%f)\n", bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
//        printf("\t[core-view]pointInside:frame(%f,%f,%f,%f)\n", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
//        if (subview.hidden){
//            continue;
//        }
//        if (CGRectContainsPoint(subview.frame, point)) {
//            printf("***[core-view]pointInside:YES\n");
//            return YES;
//        }
//    }
//
//
//    
//    printf("***[core-view]pointInside:NO\n");
//    return NO;
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
    //NSLog(@"[core-background]event:%@", event);
    printf("[core-background]pointInside:bounds(%f,%f,%f,%f)\n", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    printf("[core-background]pointInside:frame(%f,%f,%f,%f)\n", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    
    for (UIView* subview in self.subviews){
        CGRect frame = subview.frame;
        CGRect bounds = subview.bounds;
        
        printf("\t[core-background]pointInside:bounds(%f,%f,%f,%f)\n", bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
        printf("\t[core-background]pointInside:frame(%f,%f,%f,%f)\n", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        
        if (subview.hidden || subview.alpha <= 0.01 || !self.userInteractionEnabled){
            continue;
        }
        
        // CGPoint pt = [subview.layer convertPoint:point toLayer:self.layer];
        // printf("[core-background]pointInside:(%f,%f)-(%f,%f)\n", point.x,point.y, pt.x, pt.y);
        
        if (CGRectContainsPoint(subview.frame, point)){
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
static const CGFloat ATAlertViewOffsetX = 5.0;
static const CGFloat ATAlertViewOffsetY = 5.0;
static const CGFloat ATAlertViewWidth = 60.0;
static const CGFloat ATAlertViewHeight = 60.0;

@interface AssistiveTouchIconView()

@property(strong, nonatomic)UILabel* label;

@end

@implementation AssistiveTouchIconView

-(id)init{
    self = [super init];
    if (self){
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(ATAlertViewOffsetX,
                                                      ATAlertViewOffsetY,
                                                      ATAlertViewWidth - ATAlertViewOffsetX*2,
                                                      ATAlertViewHeight - ATAlertViewOffsetY*2)];
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
        self.frame = CGRectMake(30, 30, ATAlertViewWidth, ATAlertViewHeight);
    }
    
    return self;
}

@end


///////////////////////////////////////////////////////
//// AssistiveTouchContentView
///////////////////////////////////////////////////////

static const CGFloat ATAlertContentViewPerHeight = 50;



@implementation AssistiveTouchContentView

- (void) setButtonAttribute:(UIButton*) button content:(NSString*)title{
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font =[UIFont boldSystemFontOfSize:25];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.layer setBorderWidth:0.5];
}

-(id) init{
    self = [super init];
    if (self){
        
        CGFloat WIDTH = MIN([[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)* 0.75;
        CGFloat offsetX = 0;
        CGFloat offsetY = 0;
        self.buttonDump1 = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, offsetY, WIDTH, ATAlertContentViewPerHeight)];
        [self setButtonAttribute:self.buttonDump1 content:@"BUTTON 1"];
        self.buttonDump1.tag = BUTTON_TAG_1;
        [self addSubview:self.buttonDump1];
        
        offsetX = 0;
        offsetY += ATAlertContentViewPerHeight;
        self.buttonDump2 = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, offsetY, WIDTH, ATAlertContentViewPerHeight)];
        [self setButtonAttribute:self.buttonDump2 content:@"BUTTON 2"];
        self.buttonDump2.tag = BUTTON_TAG_2;
        [self addSubview:self.buttonDump2];
        
        
        
        offsetX = 0;
        offsetY += ATAlertContentViewPerHeight;
        self.buttonCancel = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, offsetY, WIDTH, ATAlertContentViewPerHeight)];
        [self setButtonAttribute:self.buttonCancel content:@"CANCEL"];
        self.buttonCancel.tag = BUTTON_TAG_CANCEL;
        [self addSubview:self.buttonCancel];
        
        self.backgroundColor = [UIColor colorWithWhite:0.25 alpha:1];
        self.layer.cornerRadius = 3.0;
        self.layer.opacity = .95;
        self.clipsToBounds = YES;
        self.frame = CGRectMake(100, 100, WIDTH, ATAlertContentViewPerHeight*3);
        
    }
    
    return self;
}


@end