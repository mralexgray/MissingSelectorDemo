
I recently shipped a version of [PicStroom](http://www.picstroom/com) with a dreaded "unrecognized selector" bug. It was caused by a sloppy mistake and not enough testing of the app on the iOS4 platform. In my case, not realizing that an `animated` argument on a method had just been introduced in iOS5 – its a rarely used section of the codebase, but of course users found it quickly.

This problem got me thinking about the whole area of bugs that only appear at runtime. 

To recap, the "unrecognized selector" exception is thrown when you call (usually dynamically) a method on an object that does not exist. But interestingly, Objective-C doesn't actually crash when you call the non-existent method – that is just the default behavior that is inherited from NSObject.

A simplified outline of the process when objective-c calls a method is:
- A method is called on the object.
- The object tells the objective-c runtime that it does not implement the method.
- The runtime, offers the object a **second chance**, by calling the "forwardInvocation" method on the object.
- Usually, the object does not implement this method so the implementation in NSObject is called.
- Its within NSObject's `forwardInvocation` implementation that the  `NSInvalidArgumentException` unrecognized selector sent to instance exception is actually generated and thrown from.

Its this second chance offered by the `forwardInvocation` that was interesting. By implementing it and redirecting the bad method call to a harmless `doNothing` method I was able to trap calls to the non-existing method and prevent the runtime crash.

The `methodSignatureForSelector` is just some plumbing[^1] that allows me to redirect the method selector away from the non-existing method and towards the new existing `doNothing` method.

	- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    	SEL nothingSEL = @selector(doNothing);
    	NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:nothingSEL];
    	return sig;
	}

	- (void)forwardInvocation:(NSInvocation *)inv {
	}

	- (void)doNothing {
	}

This is all very well supported by the objective-c runtime[^2]. No exception is raised as all that is ever called now is an existing `doNothing` method which harmlessly runs and – well – does nothing.

I've put together a quick XCode project to demonstrate this technique, which you can grab from GitHub at [https://github.com/dglancy/MissingSelectorDemo](https://github.com/dglancy/MissingSelectorDemo) and here is a quick screenshot of the demo running:

![](images/missingselectordemo.png)

I haven't tried this approach in any production applications yet, but it is certainly an interesting tool to consider for the future – albeit, its no substitute for proper testing of an app.

Extracting it out to an objective-c category is an exercise for the reader.

[^1]: Use of `methodSignatureForSelector` explained at [http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/nsobject_Class/Reference/Reference.html](http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/nsobject_Class/Reference/Reference.html)
[^2]: Full documentation from Apple is available [http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtForwarding.html](http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtForwarding.html).