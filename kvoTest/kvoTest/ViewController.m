//
//  ViewController.m
//  kvoTest
//
//  Created by 田立彬 on 13-6-15.
//  Copyright (c) 2013年 bluevt. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"


@interface ViewController ()

@property (nonatomic, strong) TestView* testView;
@property (nonatomic, strong) UILabel* label;

@end

@implementation ViewController

- (void)dealloc
{
    [self.testView removeObserver:self forKeyPath:@"test"];
}

/*
// KVO 涉及到的主要方法有下面三个：
- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;

 // 用法：
 1.
 - (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
 第一个参数：监听器对象，它需要实现- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context方法
 第二个参数：被监听对象的属性名，这个属性在类型无所谓，但是这里要用NSString对象来表示属性名称
 第三个参数：监听选项，可选项为：NSKeyValueObservingOptionNew，NSKeyValueObservingOptionOld，NSKeyValueObservingOptionInitial，NSKeyValueObservingOptionPrior。可以用或运算，表示需要监听哪些选项。这些选项体现在- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;方法的change参数里面。
 第四个参数：用来传递一些参数，一般为nil即可
 2.
 - (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
 删除监听器，与上面的add方法需要一一对应
 3.
 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
 监听器类需要实现这个方法。当被监听的属性值发生变化时，会触发此方法。
 第一个参数：表示发生变化的属性名称，与addObserver...方法中第二个参数相对应。
 第二个参数：发生变化的对象，即被监听的对象，即是发送addObserver...方法的对象
 第三个参数：发生变化的内容，与addObserver...方法中第三个参数相对应，可以通过获取以下key的值来取得内容:NSKeyValueChangeNewKey,NSKeyValueChangeOldKey,NSKeyValueChangeKindKey,NSKeyValueChangeIndexesKey,NSKeyValueChangeNotificationIsPriorKey。
 
 // 注意事项：
 我最近工作中遇到的几次崩溃问题都是下面的原因引起的:(
 1. addObserver之后，在不需要监听的时候，要及时remove，否则被监听对象释放后，再触发监听器会引起崩溃
 2. addObserver方法与removeObserver方法要一一对应。不要重复添加监听，也不要试图删除没有添加过的监听。重复添国监听，在被监听对象属性改变时，会多次调用监听方法。试图删除没有添加过的监听器会引起崩溃
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect rc = CGRectMake(10.0f, 10.0f, 200.0f, 100.0f);
    self.testView = [[TestView alloc] initWithFrame:rc];
    [self.view addSubview:self.testView];
    
    rc.origin.y += 150.0f;
    self.label = [[UILabel alloc] initWithFrame:rc];
    self.label.text = @"ready";
    [self.view addSubview:self.label];
    
    // 关键方法
    [self.testView addObserver:self
                    forKeyPath:@"test"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
}

// 关键方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object != self.testView) {
        // 容错
        [object removeObserver:self forKeyPath:keyPath];
    }
    else {
        NSInteger i = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        self.label.text = [NSString stringWithFormat:@"changed:%d", i];
        NSLog(@"changed!!!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
