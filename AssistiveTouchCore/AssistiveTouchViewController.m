///////////////////////////////////////////////////////////////
// AssistiveTouchViewController.m
// author:sundayliu
// date: 2016.07.31
///////////////////////////////////////////////////////////////

#import "AssistiveTouchViewController.h"
#import "AssistiveTouchWindow.h"
#import "AssistiveTouchView.h"

// #define __ENABLE_DEBUG_LOG__
#ifdef __ENABLE_DEBUG_LOG__
#define DEBUG_LOG(...) printf(__VA_ARGS__)
#define INFO_LOG(...) printf(__VA_ARGS__)
#define WARN_LOG(...) printf(__VA_ARGS__)
#define ERROR_LOG(...) printf(__VA_ARGS__)
#else
#define DEBUG_LOG(...)
#define INFO_LOG(...) printf(__VA_ARGS__)
#define WARN_LOG(...)
#define ERROR_LOG(...)
#endif


@interface AssistiveTouchViewController()

@property(strong,nonatomic) AssistiveTouchIconView* iconView;
@property(strong,nonatomic) AssistiveTouchContentView* contentView;
@property (nonatomic) UIPanGestureRecognizer* panGestureRecongnizer;
@property CGRect iconSuperViewBounds;

@end

@implementation AssistiveTouchViewController

-(id)init{
    
    DEBUG_LOG("=== [ATVC] init\n");
    self = [super init];
    
    return self;
}

- (void)viewDidLoad{
    DEBUG_LOG("=== [ATVC] viewDidLoad\n");
    
    self.iconView = [[AssistiveTouchIconView alloc]init];
    [self.view addSubview:self.iconView];
    
    // center
    // self.iconView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    [self.iconView addTarget:self action:@selector(onTouchUpInsideForIconView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentView = [[AssistiveTouchContentView alloc] init];
    [self.view addSubview:self.contentView];
    self.contentView.hidden = YES;
    [self.contentView.buttonDump1 addTarget:self action:@selector(onTouchUpInsideForContentView:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.buttonDump2 addTarget:self action:@selector(onTouchUpInsideForContentView:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.buttonCancel addTarget:self action:@selector(onTouchUpInsideForContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupGestures];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HandleOrientation:) name: UIApplicationDidChangeStatusBarOrientationNotification object: nil];
    
    _iconSuperViewBounds = self.iconView.superview.bounds;
}

-(void)HandleOrientation:(NSNotification *)notification
{
    INFO_LOG("=== [ATVC] HandleOrientation\n");
    
    CGRect currentBounds = self.iconView.superview.bounds;
    INFO_LOG("\t[vc](%f,%f)\n", currentBounds.size.width, currentBounds.size.height);
}

///////////////////////////////////////////////////
///////////////////////////////////////////////////
//
// Drag & Touch Action
//
///////////////////////////////////////////////////
///////////////////////////////////////////////////

- (void)setupGestures
{
    self.panGestureRecongnizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGestureRecongnizer:)];
    self.panGestureRecongnizer.maximumNumberOfTouches = 1;
    self.panGestureRecongnizer.minimumNumberOfTouches = 1;
    [self.iconView addGestureRecognizer:self.panGestureRecongnizer];
}

- (void) handlePanGestureRecongnizer:(UIPanGestureRecognizer*)recognizer{
    if (!(recognizer.state == UIGestureRecognizerStateChanged || recognizer.state == UIGestureRecognizerStateEnded)){
        return;
    }
    CGPoint translation = [recognizer translationInView:self.view];
    CGFloat width = self.iconView.frame.size.width;
    CGFloat height = self.iconView.frame.size.height;
    CGFloat parentWidth = self.view.frame.size.width;
    CGFloat parentHeight = self.view.frame.size.height;
    
    CGFloat x = translation.x + self.iconView.center.x;
    CGFloat y = translation.y + self.iconView.center.y;
    if (x < width / 2){
        x = width / 2;
    }
    
    if (x > parentWidth - width / 2){
        x = parentWidth - width / 2;
    }
    
    if (y < height / 2){
        y = height / 2;
    }
    
    if (y > parentHeight - height / 2){
        y = parentHeight - height / 2;
    }
    
    self.iconView.center = CGPointMake(x,y);
    
    
    
    [self.panGestureRecongnizer setTranslation:CGPointMake(0,0) inView:self.view];
}


- (void) onTouchUpInsideForIconView:(id) sender{
    if ([sender isKindOfClass:[AssistiveTouchIconView class]]){
        self.contentView.hidden = !self.contentView.hidden;
        self.contentView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    }
}

- (void) onTouchUpInsideForContentView:(id)sender{
    if ([sender isKindOfClass:[UIButton class]]){
        UIButton* button = (UIButton*)sender;
        switch(button.tag){
            case BUTTON_TAG_CANCEL:
                NSLog(@"ContentView Cancel");
                break;
            case BUTTON_TAG_1:
                NSLog(@"ContentView Button One");
                break;
            case BUTTON_TAG_2:
                NSLog(@"ContentView Button Two");
                break;
            default:
                break;
        }
    }
}

///////////////////////////////////////////////////
///////////////////////////////////////////////////
//
// Rotate
//
///////////////////////////////////////////////////
///////////////////////////////////////////////////

- (UIWindow*) windowWithLevel:(UIWindowLevel)windowLevel
{
    NSArray* windows = [[UIApplication sharedApplication]windows];
    for (UIWindow* window in windows){
        if (window.windowLevel == windowLevel){
            return window;
        }
    }
    
    return nil;
}

// iOS 6 and above

//  1. Current viewcontroller is UIWindow's rootViewController
//  2. Current viewcontroller is modal  - presentModalViewController
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    // INFO_LOG("[vc]supportedInterfaceOrientations\n");
    UIWindow* window = [self windowWithLevel:UIWindowLevelNormal];
    if (window){
        return [window.rootViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown | UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
}

// 当前 ViewController的初始显示方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    // INFO_LOG("[vc]preferredInterfaceOrientationForPresentation\n");
    UIWindow* window = [self windowWithLevel:UIWindowLevelNormal];
    if (window){
        return [window.rootViewController preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait;
}

// 是否支持自动旋转
- (BOOL)shouldAutorotate{
    // INFO_LOG("[vc]shouldAutorotate\n");
    UIWindow* window = [self windowWithLevel:UIWindowLevelNormal];
    if (window){
        return [window.rootViewController shouldAutorotate];
    }
    return YES;
}

// iOS 5 and before
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    INFO_LOG("[vc]shouldAutorotateToInterfaceOrientation\n");
    
    UIWindow* window = [self windowWithLevel:UIWindowLevelNormal];
    if (window){
        return [window.rootViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait
        || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
        || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft
        || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        return YES;
    }
    return NO;
}

// Rotation callbacks
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    INFO_LOG("[vc]willRotateToInterfaceOrientation\n");
    
    CGRect currentBounds = self.iconView.superview.bounds;
    INFO_LOG("\t[vc](%f,%f)\n", currentBounds.size.width, currentBounds.size.height);
    
    // 记录旋转前的尺寸
    _iconSuperViewBounds = currentBounds;
    
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    INFO_LOG("[vc]willAnimateRotationToInterfaceOrientation\n");
    
    CGRect originBounds = _iconSuperViewBounds;
    CGRect currentBounds = self.iconView.superview.bounds;
    INFO_LOG("\t[vc](%f,%f)\n", currentBounds.size.width, currentBounds.size.height);
    
    CGFloat x = 0, y = 0;
    CGFloat w = self.iconView.bounds.size.width / 2;
    CGFloat h = self.iconView.bounds.size.height / 2;

    if (self.iconView.center.x > originBounds.size.width / 2)
    {
        x = (self.iconView.center.x + w) * (currentBounds.size.width / originBounds.size.width) - w;
    }
    else if (self.iconView.center.x == originBounds.size.width / 2)
    {
        x = (self.iconView.center.x) * (currentBounds.size.width / originBounds.size.width);
    }
    else
    {
        x = (self.iconView.center.x - w) * (currentBounds.size.width / originBounds.size.width ) + w;
    }
    
    if (self.iconView.center.y > originBounds.size.height / 2)
    {
        y = (self.iconView.center.y + h) * (currentBounds.size.height / originBounds.size.height) - h;
    }
    else if (self.iconView.center.y == originBounds.size.height / 2)
    {
        y = (self.iconView.center.y) * (currentBounds.size.height / originBounds.size.height);
    }
    else
    {
        y = (self.iconView.center.y - h) * (currentBounds.size.height / originBounds.size.height) + h;
    }
    
    
    INFO_LOG("\t[vc](%f,%f),(%f,%f)\n", x,y,self.iconView.center.x, self.iconView.center.y);
    self.iconView.center = CGPointMake(x, y);

    // 记录旋转后的尺寸
    _iconSuperViewBounds = currentBounds;


    // contentView center
    if (!self.contentView.hidden){
        self.contentView.center = CGPointMake(currentBounds.size.width/2, currentBounds.size.height/2);
    }
    
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    UIInterfaceOrientation toInterfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    INFO_LOG("[vc]didRotateFromInterfaceOrientation:%d-%d\n", (int)fromInterfaceOrientation, (int)toInterfaceOrientation );
    
    CGRect currentBounds = self.iconView.superview.bounds;
    INFO_LOG("\t[vc](%f,%f)\n", currentBounds.size.width, currentBounds.size.height);
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    
}

////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

- (void)loadView{
    
    DEBUG_LOG("=== [ATVC] loadView\n");
    
    // 这里不能调用self.view 即 getter 否则会导致递归调用 loadView

    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[AssistiveTouchBackgroundView alloc]initWithFrame:frame];
    self.view.backgroundColor = [UIColor greenColor];
    self.view.alpha = 0.5f;
    
}

- (void)viewWillLayoutSubviews{
    DEBUG_LOG("=== [ATVC] viewWillLayoutSubviews\n");
    
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews{
    INFO_LOG("=== [ATVC] viewDidLayoutSubviews\n");
    [super viewDidLayoutSubviews];
    
    [self dumpView];
}

- (void)viewWillAppear:(BOOL)animated{
    DEBUG_LOG("=== [ATVC] viewWillAppear\n");

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    INFO_LOG("=== [ATVC] viewDidAppear\n");

    _iconSuperViewBounds = self.iconView.superview.bounds;
    INFO_LOG("\t[vc](%f,%f)\n", _iconSuperViewBounds.size.width, _iconSuperViewBounds.size.height);
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    DEBUG_LOG("=== [ATVC] viewWillDisappear\n");

    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    DEBUG_LOG("=== [ATVC] viewDidDisappear\n");

    [super viewDidDisappear:animated];
}

- (void)dumpView{
    DEBUG_LOG("=== [ATVC] view frame:(%f,%f,%f,%f)\n", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    DEBUG_LOG("=== [ATVC] view bounds:(%f,%f,%f,%f)\n", self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    for (UIView* subview in self.view.subviews){
        if (subview.hidden || subview.alpha <= 0.01f || !subview.userInteractionEnabled){
            continue;
        }
        
        DEBUG_LOG("\t [ATVC] view frame:(%f,%f,%f,%f)\n", subview.frame.origin.x, subview.frame.origin.y, subview.frame.size.width, subview.frame.size.height);
        DEBUG_LOG("\t [ATVC] view bounds:(%f,%f,%f,%f)\n", subview.bounds.origin.x, subview.bounds.origin.y, subview.bounds.size.width, subview.bounds.size.height);
    }
}

@end