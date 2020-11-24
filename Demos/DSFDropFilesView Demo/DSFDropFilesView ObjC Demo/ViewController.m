//
//  ViewController.m
//  DSFDropFilesView ObjC Demo
//
//  Created by Darren Ford on 24/11/20.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	// Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
	[super setRepresentedObject:representedObject];

	// Update the view, if already loaded.
}

- (NSDragOperation)dropFilesView:(DSFDropFilesView *)sender validateFiles:(NSArray<NSURL *> * _Nonnull)validateFiles {
	return NSDragOperationCopy;
}

- (BOOL)dropFilesView:(DSFDropFilesView *)sender didDropFiles:(NSArray<NSURL *> *)files {
	NSLog(@"User dropped files %@", files);
	return true;
}

- (void)dropFilesViewWantsSelectFiles:(DSFDropFilesView *)sender {
	NSLog(@"User clicked select files");

	__weak typeof(self) bself = self;
	dispatch_async(dispatch_get_main_queue(), ^(void){
		[bself selectFiles];
	});
}

- (void)selectFiles {
	NSOpenPanel* openPanel = [NSOpenPanel openPanel];

	[openPanel setAllowsMultipleSelection: YES];
	[openPanel setCanChooseDirectories:YES];
	[openPanel setCanCreateDirectories:YES];
	[openPanel setCanChooseFiles:YES];

	[openPanel beginWithCompletionHandler:^(NSInteger result)  {
		if (result == NSModalResponseOK) {
			NSLog(@"User dropped files %@", [openPanel URLs]);
		}
	}];
}

@end
