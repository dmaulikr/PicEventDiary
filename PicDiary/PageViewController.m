//
//  PageViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-09.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "PageViewController.h"
#import "FullScreenViewController.h"
#import "AppDelegate.h"

@interface PageViewController () <UIPageViewControllerDataSource>

//@property (nonatomic, strong) NSArray *contentPhotos;

@property (nonatomic, strong) UIPageViewController *pageViewController;


@end

@implementation PageViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    
//    self.managedObjectContext = appDelegate.managedObjectContext;
//    
//    NSError *errR = nil;
//    NSFetchRequest *fetchRequestR = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entityR = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequestR setEntity:entityR];
//    
//    self.photo = [self.managedObjectContext executeFetchRequest:fetchRequestR error:&errR];
   
    [self createPageViewController];
    
//    [self setupPageControl];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark View Lifecycle

- (void) createPageViewController
{
//    contentImages = @[@"nature_pic_1.png",@"nature_pic_2.png",@"nature_pic_3.png",@"nature_pic_4.png"];
    
    UIPageViewController *pageController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"PageController"];
    pageController.dataSource = self;
    
//    if([contentImages count])
    if([self.photo count])
    {
        NSArray *startingViewControllers = @[[self itemControllerForIndex: self.itemIndex]];
        [pageController setViewControllers: startingViewControllers
                                 direction: UIPageViewControllerNavigationDirectionForward
                                  animated: NO
                                completion: nil];
    }
    
    self.pageViewController = pageController;
    [self addChildViewController: self.pageViewController];
    [self.view addSubview: self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController: self];
}

//- (void) setupPageControl
//{
//    [[UIPageControl appearance] setPageIndicatorTintColor: [UIColor grayColor]];
//    [[UIPageControl appearance] setCurrentPageIndicatorTintColor: [UIColor whiteColor]];
//    [[UIPageControl appearance] setBackgroundColor: [UIColor darkGrayColor]];
//}

#pragma mark UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *) viewController
{
    FullScreenViewController *itemController = (FullScreenViewController *) viewController;
    if (itemController.itemIndex > 0)
    {
        return [self itemControllerForIndex: itemController.itemIndex-1];
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *) viewController
{
    FullScreenViewController *itemController = (FullScreenViewController *) viewController;
    if (itemController.itemIndex+1 < [self.photo count])
    {
        return [self itemControllerForIndex: itemController.itemIndex+1];
    }
    return nil;
}

- (FullScreenViewController *)itemControllerForIndex:(NSUInteger)itemIndex
{
    if (itemIndex < [self.photo count])
    {
        FullScreenViewController *pageItemController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"ItemController"];
        
        pageItemController.photo = self.photo;
        pageItemController.itemIndex = itemIndex;
        pageItemController.managedObjectContext = self.managedObjectContext;
        NSLog(@"itemIndex: %d", itemIndex);
        
        return pageItemController;
    }
    
    return nil;
}

//#pragma mark Page Indicator
//
//- (NSInteger)presentationCountForPageViewController: (UIPageViewController *)pageViewController
//{
//    return [self.photo count];
//}
//
//- (NSInteger)presentationIndexForPageViewController: (UIPageViewController *)pageViewController
//{
//    return 0;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
