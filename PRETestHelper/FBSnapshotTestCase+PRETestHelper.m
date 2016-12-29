//
//  FBSnapshotTestCase+PRETestHelper.m
//  PRETestHelper
//
//  Copyright (c) 2016 Paul Steinhilber
//  http://paulsteinhilber.de
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "FBSnapshotTestCase+PRETestHelper.h"
#import "XCTestCase+PRETestHelper.h"

@implementation FBSnapshotTestCase (PRETestHelper)

- (UITableViewCell*)loadTableCellFromNibNamed:(NSString*)nibName {
    NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    UITableViewCell* cell = topLevelObjects.firstObject;
    if ([cell isKindOfClass:UITableViewCell.class]) {
        return cell;
    }
    
    return nil;
}

- (UICollectionViewCell*)loadCollectionCellFromNibNamed:(NSString*)nibName {
    NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    UICollectionViewCell* cell = topLevelObjects.firstObject;
    if ([cell isKindOfClass:UICollectionViewCell.class]) {
        return cell;
    }
    
    return nil;
}

- (void)snapshotController:(UIViewController*)controller wrappedInNavigationController:(BOOL)wrap {
    [self snapshotController:controller wrappedInNavigationController:wrap withIdentifier:@""];
}

- (void)snapshotController:(UIViewController*)controller wrappedInNavigationController:(BOOL)wrap withIdentifier:(NSString*)identifier {
    [self snapshotController:controller wrappedInNavigationController:wrap delay:0 withIdentifier:identifier];
}

- (void)snapshotController:(UIViewController *)controller wrappedInNavigationController:(BOOL)wrap delay:(NSTimeInterval)delay withIdentifier:(NSString *)identifier {
    [self snapshotController:controller wrappedInNavigationController:wrap delay:delay withIdentifier:identifier afterActions:nil];
}

- (void)snapshotController:(UIViewController *)controller wrappedInNavigationController:(BOOL)wrap delay:(NSTimeInterval)delay withIdentifier:(NSString *)identifier afterActions:(void (^)())actions {
    [self snapshotController:controller wrappedInNavigationController:wrap showBack:NO delay:delay withIdentifier:identifier afterActions:actions];
}

- (void)snapshotController:(UIViewController*)controller wrappedInNavigationController:(BOOL)wrap showBack:(BOOL)back delay:(NSTimeInterval)delay withIdentifier:(NSString*)identifier afterActions:(void (^)())actions {
    
    UINavigationController* navigation;
    if (wrap) {
        if (back) {
            UIViewController* root = [UIViewController new];
            root.navigationItem.title = @"Back";
            navigation = [[UINavigationController alloc] initWithRootViewController:root];
            [navigation pushViewController:controller animated:NO];
        } else {
            navigation = [[UINavigationController alloc] initWithRootViewController:controller];
        }
    } else {
        controller.view.frame = [UIScreen mainScreen].bounds;
    }
    
    [controller beginAppearanceTransition:YES animated:NO];
    [controller endAppearanceTransition];
    
    // make blinking cursor invisible
    [[UITextField appearance] setTintColor:[UIColor clearColor]];
    
    if (actions) {
        actions();
    }
    
    if (delay > 0) {
        [self waitForTimeInterval:delay];
    }
    
    if (navigation) {
        FBSnapshotVerifyView(navigation.view, identifier);
    } else {
        FBSnapshotVerifyView(controller.view, identifier);
    }
}

- (void)snapshotCollectionCell:(UICollectionViewCell*)cell withIdentifier:(NSString*)identifier {
    cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    UIView* cview = cell.contentView;
    [view addSubview:cview];
    [view.leftAnchor constraintEqualToAnchor:cview.leftAnchor].active = YES;
    [view.topAnchor constraintEqualToAnchor:cview.topAnchor].active = YES;
    [view.bottomAnchor constraintEqualToAnchor:cview.bottomAnchor].active = YES;
    [view.rightAnchor constraintEqualToAnchor:cview.rightAnchor].active = YES;
    [view.widthAnchor constraintEqualToConstant:320].active = YES;
    
    [view layoutIfNeeded];
    
    FBSnapshotVerifyView(view, identifier);
}

- (void)snapshotTableCell:(UITableViewCell*)cell withIdentifier:(NSString*)identifier {
    cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    UIView* cview = cell.contentView;
    [view addSubview:cview];
    [view.leftAnchor constraintEqualToAnchor:cview.leftAnchor].active = YES;
    [view.topAnchor constraintEqualToAnchor:cview.topAnchor].active = YES;
    [view.bottomAnchor constraintEqualToAnchor:cview.bottomAnchor].active = YES;
    [view.rightAnchor constraintEqualToAnchor:cview.rightAnchor].active = YES;
    [view.widthAnchor constraintEqualToConstant:320].active = YES;
    
    [view layoutIfNeeded];
    
    FBSnapshotVerifyView(view, identifier);
}

@end
