#import "AssistiveTouchCore.h"
#import "AssistiveTouchViewController.h"
#import "AssistiveTouchWindow.h"

@interface AssistiveTouchCore : NSObject

@property(strong,nonatomic)NSTimer* timer;
@property(strong,nonatomic) AssistiveTouchWindow* window;

+(instancetype)sharedInstance;

-(BOOL)show:(NSInteger)delay;

-(BOOL)hide;

@end

@implementation AssistiveTouchCore

+(instancetype)sharedInstance{
    static AssistiveTouchCore* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init{
    self = [super init];
    if (self){
        CGRect frame = [UIScreen mainScreen].bounds;
        self.window = [[AssistiveTouchWindow alloc]initWithFrame:frame];
        // self.window.backgroundColor = [UIColor greenColor];
        
        AssistiveTouchViewController* vc = [[AssistiveTouchViewController alloc]init];
        self.window.rootViewController = vc;
    }
    
    return self;
}

- (void) onTimerFired:(NSTimer*)timer{
    self.timer = nil;
    [self showInternal];
}

-(BOOL)show:(NSInteger)delay{
    if (delay > 0){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:delay
                                                      target:self
                                                    selector:@selector(onTimerFired:)
                                                    userInfo:nil repeats:NO];
    }
    else{
        [self showInternal];
    }
    return YES;
}

- (void) showInternal
{

    
    [self.window makeKeyAndVisible];
}

-(BOOL)hide{
    [self.window setHidden:YES];
    return YES;
}


@end

void AssistiveTouchCore_init()
{
    NSLog(@"AssistiveTouch init");
    [[AssistiveTouchCore sharedInstance] show: 0];
}

