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
    
    CGRect frame = self.view.bounds;

    self.iconView.center = CGPointMake(frame.size.width/2, frame.size.height/2);


}

- (void)loadView{
    
    printf("=== [ATVC] loadView\n");
    
    // 这里不能调用self.view 即 getter 否则会导致递归调用 loadView

    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[AssistiveTouchBackgroundView alloc]initWithFrame:frame];
    self.view.backgroundColor = [UIColor redColor];
    self.view.alpha = 0.4f;
    
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