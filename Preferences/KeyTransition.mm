#import <Preferences/PSListController.h>
#import <Twitter/Twitter.h>
#import "global.h"

@interface KeyTransitionListController: PSListController {
}
- (UIViewController *)rootController;
@end

@implementation KeyTransitionListController

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"KeyTransition" target:self];
	}
	return _specifiers;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Get the banner image
	UITableView* tableView = [self table];
	UIImageView* headerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Banner" inBundle:[self bundle]]];
	// Resize header image
	CGFloat paneWidth = [[UIScreen mainScreen] bounds].size.width;
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		paneWidth = [self rootController].view.frame.size.width;
	// Resize frame to fit
	CGRect newFrame = headerImage.frame;
	CGFloat ratio = paneWidth / newFrame.size.width;
	newFrame.size.width = paneWidth;
	newFrame.size.height *= ratio;
	headerImage.frame = newFrame;
	// Add header container
	UIView* headerContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, newFrame.size.height)];
	headerContainer.backgroundColor = [UIColor clearColor];
	[headerContainer addSubview:headerImage];
	[tableView setTableHeaderView:headerContainer];
	// Color stuff
	[UISwitch appearanceWhenContainedIn:self.class, nil].tintColor = KTColor;
	[UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = KTColor;
	[UINavigationBar appearanceWhenContainedIn:self.class, nil].tintColor = [UIColor whiteColor];
	[UINavigationBar appearanceWhenContainedIn:self.class, nil].barTintColor = KTColor;
	// Title stuff
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KeyTransition" inBundle:[self bundle]]];
	self.navigationItem.titleView.alpha = 0;
	UIButton* twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[twitterButton setImage:[UIImage imageNamed:@"Twitter" inBundle:[self bundle]] forState:UIControlStateNormal];
	[twitterButton addTarget:self action:@selector(tweet) forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:twitterButton];
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    [UIView animateWithDuration:0.55 animations:^{
	    	self.navigationItem.titleView.alpha = 1;
	    }];
	});
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture {
	if(gesture.state == UIGestureRecognizerStateEnded) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/watch?v=dQw4w9WgXcQ"]];
	}
}

- (void)tweet {
	if([TWTweetComposeViewController canSendTweet]) {
		TWTweetComposeViewController* vc = [[TWTweetComposeViewController alloc] init];
		[vc setInitialText:@"Loving #KeyTransition by @Sassoty and @AOkhtenberg! :)"];
		[vc setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
			[self dismissModalViewControllerAnimated:YES];
		}];
		[self presentViewController:vc animated:YES completion:nil];
	}else {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"KeyTransition" message:@"Please make sure you have Twitter accounts signed in on your device." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
	}
}

- (void)openBugReport {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://bit.ly/AOkhtenbergBugReporter"]];
}

@end

// vim:ft=objc
