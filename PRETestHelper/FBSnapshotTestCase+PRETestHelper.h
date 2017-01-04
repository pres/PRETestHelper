//
//  FBSnapshotTestCase+PRETestHelper.h
//  PRETestHelper
//
//  Copyright (c) 2016-17 Paul Steinhilber
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

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface FBSnapshotTestCase (PRETestHelper)

- (UITableViewCell*)loadTableCellFromNibNamed:(NSString*)nibName;
- (UICollectionViewCell*)loadCollectionCellFromNibNamed:(NSString*)nibName;

- (void)snapshotController:(UIViewController*)controller wrappedInNavigationController:(BOOL)wrap;
- (void)snapshotController:(UIViewController*)controller wrappedInNavigationController:(BOOL)wrap withIdentifier:(NSString*)identifier;
- (void)snapshotController:(UIViewController*)controller wrappedInNavigationController:(BOOL)wrap delay:(NSTimeInterval)delay withIdentifier:(NSString*)identifier;
- (void)snapshotController:(UIViewController*)controller wrappedInNavigationController:(BOOL)wrap delay:(NSTimeInterval)delay withIdentifier:(NSString*)identifier afterActions:(void (^)())actions;
- (void)snapshotController:(UIViewController*)controller wrappedInNavigationController:(BOOL)wrap showBack:(BOOL)back delay:(NSTimeInterval)delay withIdentifier:(NSString*)identifier afterActions:(void (^)())actions;

- (void)snapshotTableCell:(UITableViewCell*)cell withIdentifier:(NSString*)identifier;
- (void)snapshotCollectionCell:(UICollectionViewCell*)cell withIdentifier:(NSString*)identifier;

@end
