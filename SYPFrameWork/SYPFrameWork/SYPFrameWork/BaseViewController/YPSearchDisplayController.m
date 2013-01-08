//
//  YPSearchDisplayController.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPSearchDisplayController.h"
#import "YPTableViewController.h"

@implementation YPSearchDisplayController

@synthesize searchResultsViewController = _searchResultsViewController;

- (id)initWithSearchBar:(UISearchBar*)searchBar contentsController:(UIViewController*)controller {
    if (self = [super initWithSearchBar:searchBar contentsController:controller]) {
        self.delegate = self;
        
        // 去 search bar 黑线
        CGRect rect = self.searchBar.frame;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, rect.size.height-1,rect.size.width, 1)];
        lineView.backgroundColor = [UIColor shadowColorForKey:@"CommonModule-searchBar"];
        [self.searchBar addSubview:lineView];
        [lineView release];
    }
    
    return self;
}

- (void)dealloc {
    
    RELEASE(_searchResultsViewController);
    [super dealloc];
}

#pragma mark -
#pragma mark Private

- (void)resetResults
{
	[_searchResultsViewController cancelSearch];
	[_searchResultsViewController search:nil];
	[_searchResultsViewController viewWillDisappear:NO];
	[_searchResultsViewController viewDidDisappear:NO];
	_searchResultsViewController.tableView = nil;
}


#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController*)controller
{
    // 为了UI效果
    [controller.searchBar setShowsCancelButton:YES animated:NO];
    for (UIView *view in controller.searchBar.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *cancelBtn = (UIButton *)view;
            cancelBtn.backgroundColor = [UIColor clearColor];
            [cancelBtn setBackgroundImage:[UIImage imageForKey:@"searchBar_cancel_btn"]
                                 forState:UIControlStateNormal];
            [cancelBtn setBackgroundImage:[UIImage imageForKey:@"searchBar_cancel_btn_hl"]
                                 forState:UIControlStateHighlighted];
            [cancelBtn setTitle:NSLocalizedStringFromTable(@"取消", RS_CURRENT_LANGUAGE_TABLE, nil)
                       forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor colorForKey:@"CommonModule-searchBarCancelBtn"]
                            forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateHighlighted];
            [cancelBtn.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0f)];
            [cancelBtn setTitleShadowColor:[UIColor whiteColor]
                                  forState:UIControlStateNormal];
            [cancelBtn setTitleShadowColor:[UIColor clearColor]
                                  forState:UIControlStateHighlighted];
            
        }
    }
    
    id contenstController = controller.searchContentsController;
    [_searchResultsViewController viewWillAppear:NO];
    if ([contenstController respondsToSelector:@selector(willBeginSearch)]) {
        [contenstController performSelector:@selector(willBeginSearch)];
    }
}


- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    [_searchResultsViewController viewDidAppear:NO];
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
	id contenstController = controller.searchContentsController;
    
	if ([contenstController respondsToSelector:@selector(willEndSearch)]) {
		[contenstController performSelector:@selector(willEndSearch)];
	}
}
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController*)controller {
    [self resetResults];
}


- (void)searchDisplayController:(UISearchDisplayController *)controller
  didLoadSearchResultsTableView:(UITableView *)tableView {
    
}


- (void)searchDisplayController:(UISearchDisplayController *)controller
willUnloadSearchResultsTableView:(UITableView *)tableView {
}


- (void)searchDisplayController:(UISearchDisplayController *)controller
  didShowSearchResultsTableView:(UITableView *)tableView {
    _searchResultsViewController.tableView = tableView;
    [_searchResultsViewController viewWillAppear:NO];
    [_searchResultsViewController viewDidAppear:NO];
    
}


- (void)searchDisplayController:(UISearchDisplayController*)controller
 willHideSearchResultsTableView:(UITableView*)tableView {
    [self resetResults];
    
    id contenstController = controller.searchContentsController;
    if ([contenstController respondsToSelector:@selector(willHideSearchResult)]) {
        [contenstController performSelector:@selector(willHideSearchResult)];
    }
}


- (BOOL)searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchString:(NSString*)searchString {
    [_searchResultsViewController search:searchString];
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [_searchResultsViewController search:self.searchBar.text];
    return YES;
}

#pragma mark -
#pragma mark UISearchBarDelegate
/*
 - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
 {
 NSLog(@"%@", searchText);
 }
 
 - (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
 NSLog(@"%@", searchBar);
 }
 
 - (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
 NSLog(@"%@", searchBar);
 }
 */
#pragma mark -
#pragma mark Public




@end