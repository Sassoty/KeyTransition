#import <Preferences/PSListController.h>
#import <Twitter/Twitter.h>
#import "global.h"

@interface KTExtrasListController: PSListController {
}
@end

@implementation KTExtrasListController

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Extras" target:self];
	}
	// Color stuff
	[UISwitch appearanceWhenContainedIn:self.class, nil].tintColor = KTColor;
	[UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = KTColor;
	[UISegmentedControl appearanceWhenContainedIn:self.class, nil].tintColor = KTColor;
	[UINavigationBar appearanceWhenContainedIn:self.class, nil].tintColor = [UIColor whiteColor];
	[UINavigationBar appearanceWhenContainedIn:self.class, nil].barTintColor = KTColor;
	[UISlider appearanceWhenContainedIn:self.class, nil].tintColor = KTColor;
	return _specifiers;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[self bundle].bundlePath stringByAppendingPathComponent:@"Extras"]]];
}

@end

// vim:ft=objc
