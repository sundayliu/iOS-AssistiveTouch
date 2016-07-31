///////////////////////////////////////////////////////////////
// AssistiveTouchViewController.m
// author:sundayliu
// date: 2016.07.31
///////////////////////////////////////////////////////////////

#import "AssistiveTouchViewController.h"
#import "AssistiveTouchWindow.h"
#import "AssistiveTouchView.h"


@interface AssistiveTouchViewController()

@property(strong,nonatomic) AssistiveTouchIconView* iconView;
@property(strong,nonatomic) AssistiveTouchContentView* contentView;
@property (nonatomic) UIPanGestureRecognizer* panGestureRecongnizer;

@end

@implementation AssistiveTouchViewController

-(id)init{
    
    printf("=== [ATVC] init\n");
    self = [super init];
    
    if (self.view == nil){
        printf("=== [ATVC] view is nil");
    }
    return self;
}

- (void)viewDidLoad{
    printf("=== [ATVC] viewDidLoad\n");
    
    self.iconView = [[AssistiveTouchIconView alloc]init];
    [self.view addSubview:self.iconView];
    
    [self.iconView addTarget:self action:@selector(onTouchUpInsideForIconView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentView = [[AssistiveTouchContentView alloc] init];
    [self.view addSubview:self.contentView];
    self.contentView.hidden = YES;
    [self.contentView.buttonDump1 addTarget:self action:@selector(onTouchUpInsideForContentView:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.buttonDump2 addTarget:self action:@selector(onTouchUpInsideForContentView:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.buttonCancel addTarget:self action:@selector(onTouchUpInsideForContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupGestures];


}

// 拖动
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

////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

- (void)loadView{
    
    printf("=== [ATVC] loadView\n");
    
    // 这里不能调用self.view 即 getter 否则会导致递归调用 loadView

    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[AssistiveTouchBackgroundView alloc]initWithFrame:frame];
    self.view.backgroundColor = [UIColor greenColor];
    self.view.alpha = 0.5f;
    
}

- (void)viewWillLayoutSubviews{
    printf("=== [ATVC] viewWillLayoutSubviews\n");
    
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews{
    printf("=== [ATVC] viewDidLayoutSubviews\n");
    [super viewDidLayoutSubviews];
    
    // 改变 view 的 frame
//    CGRect frame = [UIScreen mainScreen].bounds;
//    frame = CGRectMake(30, 30, frame.size.width-60, frame.size.height-60);
//    self.view.frame = frame;
    
    // center subview
    // CGRect frame = self.view.bounds;
    // self.iconView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
    
    [self dumpView];
}

- (void)viewWillAppear:(BOOL)animated{
    printf("=== [ATVC] viewWillAppear\n");

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    printf("=== [ATVC] viewDidAppear\n");


    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    printf("=== [ATVC] viewWillDisappear\n");

    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    printf("=== [ATVC] viewDidDisappear\n");

    [super viewDidDisappear:animated];
}

- (void)dumpView{
    printf("=== [ATVC] view frame:(%f,%f,%f,%f)\n", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    printf("=== [ATVC] view bounds:(%f,%f,%f,%f)\n", self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    for (UIView* subview in self.view.subviews){
        if (subview.hidden || subview.alpha <= 0.01f || !subview.userInteractionEnabled){
            continue;
        }
        
        printf("\t [ATVC] view frame:(%f,%f,%f,%f)\n", subview.frame.origin.x, subview.frame.origin.y, subview.frame.size.width, subview.frame.size.height);
        printf("\t [ATVC] view bounds:(%f,%f,%f,%f)\n", subview.bounds.origin.x, subview.bounds.origin.y, subview.bounds.size.width, subview.bounds.size.height);
    }
}

@end