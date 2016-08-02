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

@end


///////////////////////////////////////////////////////
//// AssistiveTouchBackgroundView
///////////////////////////////////////////////////////
@implementation AssistiveTouchBackgroundView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
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
        self.label.text = @"O";
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
        self.frame = CGRectMake(60, 60, ATAlertViewWidth, ATAlertViewHeight);
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
        WIDTH = WIDTH >= 320 ? 320 : WIDTH;
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