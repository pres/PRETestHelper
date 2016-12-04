//
//  XCTestCase+PRETestHelper.m
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

#import "XCTestCase+PRETestHelper.h"

@implementation XCTestCase (PRETestHelper)

// helper is based on the following awesome blog posts
// see: https://pspdfkit.com/blog/2016/running-ui-tests-with-ludicrous-speed/
// see: http://bou.io/CTTRunLoopRunUntil.html

Boolean CTTRunLoopRunUntil(Boolean(^fulfilled_)(), Boolean polling_, CFTimeInterval timeout_) {
    // loop observer callback
    __block Boolean fulfilled = NO;
    void (^beforeWaiting) (CFRunLoopObserverRef observer, CFRunLoopActivity activity) =
    ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        assert(!fulfilled); // RunLoop should be stopped after condition is fulfilled
        // check condition
        fulfilled = fulfilled_();
        if(fulfilled) {
            // condition fulfilled: stop RunLoop now
            CFRunLoopStop(CFRunLoopGetCurrent());
        } else if(polling_) {
            // condition not fulfilled, and we are polling: prevent RunLoop from waiting and continue looping
            CFRunLoopWakeUp(CFRunLoopGetCurrent());
        }
    };
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeWaiting, true, 0, beforeWaiting);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // run
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, timeout_, false);
    
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
    
    return fulfilled;
}

@implementation XCTestCase (LXTestCase)

- (void)waitForCondition:(Boolean (^)())condition {
    CTTRunLoopRunUntil(condition, YES, 10.);
}

@end
