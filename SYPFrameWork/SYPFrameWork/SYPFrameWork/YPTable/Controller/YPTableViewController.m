//
//  YPTableViewController.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPTableViewController.h"
#import "YPTableViewDataSource.h"
#import "YPSearchDisplayController.h"
#import "YPBaseTableView.h"
#import "YPTableViewCell.h"
#import "YPErrorView.h"
#import "YPTableViewLoadMoreItem.h"
#import "YPTableViewLoadMoreCell.h"
#import "YPSearchDisplayController.h"
#import "SVPullToRefresh.h"
//#import "UIWindow+RscExt.h"

@interface YPTableViewController (delegate);

@end

@interface YPTableViewController (Private);

- (void)loadMoreAction;

@end

@implementation YPTableViewController

@synthesize error = _error;
@synthesize tableView           = _tableView;
@synthesize tableWatermarkView  = _tableWatermarkView;
@synthesize tableOverlayView    = _tableOverlayView;
@synthesize loadingView         = _loadingView;
@synthesize errorView           = _errorView;
@synthesize emptyView           = _emptyView;
@synthesize tableViewStyle      = _tableViewStyle;
@synthesize showTableShadows    = _showTableShadows;
@synthesize dataSource          = _dataSource;
@synthesize loadingData         = _loadingData;
@synthesize searchViewController   = _searchViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
	if (self = [super init]) {
		_tableViewStyle = style;
		_loadingData	= NO;
	}
    
	return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}
- (void)dealloc
{
	_tableView.delegate		= nil;
	_tableView.dataSource	= nil;
    _tableView.pullToRefreshView = nil;
    RELEASE(_error);
	RELEASE(_dataSource);
	RELEASE(_tableView);
	RELEASE(_loadingView);
	RELEASE(_errorView);
	RELEASE(_emptyView);
    RELEASE(_tableWatermarkView);
	RELEASE(_tableOverlayView);
    RELEASE(_searchController);
    RELEASE(_searchViewController);
    
	[super dealloc];
}

#pragma mark -
#pragma mark Private

- (NSString *)defaultTitleForLoading
{
	return NSLocalizedString(@"Loading...", @"");
}

- (void)addToOverlayView:(UIView *)view
{
	if (!_tableOverlayView) {
		CGRect frame = self.view.bounds;
		_tableOverlayView = [[UIView alloc] initWithFrame:frame];
		_tableOverlayView.autoresizesSubviews	= YES;
		_tableOverlayView.autoresizingMask		= UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
		NSInteger tableIndex = [_tableView.superview.subviews indexOfObject:_tableView];
        
		if (tableIndex != NSNotFound) {
			[_tableView.superview addSubview:_tableOverlayView];
		}
	}
    
	view.frame				= _tableOverlayView.bounds;
	view.autoresizingMask	= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[_tableOverlayView addSubview:view];
}
- (void)addToWatermarkView:(UIView *)view
{
	if (!_tableWatermarkView) {
		CGRect frame = self.view.bounds;
		_tableWatermarkView = [[UIView alloc] initWithFrame:frame];
		_tableWatermarkView.autoresizesSubviews	= YES;
		_tableWatermarkView.autoresizingMask		= UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
        // 水印
        /*
		NSInteger tableIndex = [_tableView.superview.subviews indexOfObject:_tableView];
        
		if (tableIndex != NSNotFound) {
			[_tableView.superview insertSubview:_tableWatermarkView belowSubview:_tableView];
		}
         //*/
        // tableview之上
        [_tableView addSubview:_tableWatermarkView];
	}
    UIEdgeInsets edgeInsets = [_dataSource emptyViewEdgeInsets];
    CGRect viewFrame = _tableWatermarkView.bounds;
    viewFrame.origin.x += (edgeInsets.right - edgeInsets.left);
    viewFrame.origin.y += (edgeInsets.top - edgeInsets.bottom);
	view.frame				= viewFrame;
	view.autoresizingMask	= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[_tableWatermarkView addSubview:view];
}
- (void)resetOverlayView
{
	if (_tableOverlayView && !_tableOverlayView.subviews.count) {
		[_tableOverlayView removeFromSuperview];
		RELEASE(_tableOverlayView);
	}
}

- (void)resetWatermarkView
{
    if (_tableWatermarkView && !_tableWatermarkView.subviews.count) {
		[_tableWatermarkView removeFromSuperview];
		RELEASE(_tableWatermarkView);
	}
}

- (void)addSubviewOverTableView:(UIView *)view
{
	NSInteger tableIndex = [_tableView.superview.subviews
							indexOfObject:_tableView];
    
	if (NSNotFound != tableIndex) {
		[_tableView.superview addSubview:view];
	}
}

- (void)layoutOverlayView
{
	if (_tableOverlayView) {
		_tableOverlayView.frame = [self rectForOverlayView];
	}
}

- (void)layoutWatermarkView
{
    if (_tableWatermarkView) {
        _tableWatermarkView.frame = [self rectForWatermarkView];
    }
}
- (void)fadeOutView:(UIView *)view
{
	[view retain];
	[UIView beginAnimations:nil context:view];
	[UIView setAnimationDuration:.3f];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(fadingOutViewDidStop:finished:context:)];
	view.alpha = 0;
	[UIView commitAnimations];
}

- (void)fadingOutViewDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	UIView *view = (UIView *)context;
    
	[view removeFromSuperview];
	[view release];
}

- (void)setSearchViewController:(YPTableViewController *)searchViewController
{
	if (_searchViewController == searchViewController) {
		return;
	}
    
    RELEASE(_searchViewController);
    _searchViewController = [searchViewController retain];
    
	if (searchViewController) {
		if (nil == _searchController) {
			UISearchBar *searchBar = [[[UISearchBar alloc] init] autorelease];
			[searchBar sizeToFit];
			_searchController = [[YPSearchDisplayController alloc] initWithSearchBar	:searchBar
                                                                   contentsController	:self];
		}
        
		_searchController.searchResultsViewController = searchViewController;
	} else {
		_searchController.searchResultsViewController = nil;
		RELEASE(_searchController);
	}
}

#pragma mark -
#pragma mark UIViewController


- (void)loadView {
    [super loadView];

    _shouldLoadTableView = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    self.tableView.showsPullToRefresh = NO;     // default is NO
    self.tableView.showsInfiniteScrolling = NO; // default is NO
}
- (void)viewDidLoad
{
	[super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = RGBCOLOR(242,241,236);
}

- (void)unLoadViews {
    [super unLoadViews];
    
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    RELEASE(_tableView);
    [_tableOverlayView removeFromSuperview];
    RELEASE(_tableOverlayView);
    [_tableWatermarkView removeFromSuperview];
    RELEASE(_tableWatermarkView);
    [_loadingView removeFromSuperview];
    RELEASE(_loadingView);
    [_errorView removeFromSuperview];
    RELEASE(_errorView);
    [_emptyView removeFromSuperview];
    RELEASE(_emptyView);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_lastInterfaceOrientation != self.interfaceOrientation) {
        _lastInterfaceOrientation = self.interfaceOrientation;
        [_tableView reloadData];
        
    } else if ([_tableView isKindOfClass:[YPBaseTableView class]]) {
        YPBaseTableView* tableView = (YPBaseTableView*)_tableView;
        tableView.showShadows = _showTableShadows;
    }
    
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:animated];
    
    if ( _shouldLoadTableView ) {
        _shouldLoadTableView = NO;

        __block YPTableViewController *tableViewController = self;
        // 添加下拉刷新功能
        if (self.tableView.showsPullToRefresh) {
            [self.tableView addPullToRefreshWithActionHandler:^{
                [tableViewController performSelectorOnMainThread:@selector(pullToRefreshAction) withObject:nil waitUntilDone:YES];
            }];
        }
        // 添加无限下翻功能
        if (self.tableView.showsInfiniteScrolling) {
            
            [self.tableView addInfiniteScrollingWithActionHandler:^{
                [tableViewController performSelectorOnMainThread:@selector(infiniteScrollingAction) withObject:nil waitUntilDone:YES];
            }];
        }
    }
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}



- (void)showLoading:(BOOL)show {
    if (show) {
        
		[self showEmpty:NO];
		[self showError:NO];
        if (self.dataSource.empty) {
//            [RSAPPCONTEXT.hudHelper showHudOnView:self.view
//                                          caption:NSLocalizedStringFromTable(@"载入中...",RS_CURRENT_LANGUAGE_TABLE,nil)
//                                            image:nil
//                                        acitivity:YES
//                                     autoHideTime:0.0f];
        }
    } else {
//        [RSAPPCONTEXT.hudHelper hideHud];
    }
    
}


- (void)showError:(BOOL)show
{
	if (show) {
		NSString	*title		= [_dataSource titleForError:self.error];
		NSString	*subtitle	= [_dataSource subtitleForError:self.error];
		UIImage		*image		= [_dataSource imageForError:self.error];
        
		if (title.length || subtitle.length || image) {
			YPErrorView *errorView = [[[YPErrorView alloc]	initWithTitle	:title
                                                               subtitle		:subtitle
                                                                 image		:image] autorelease];
			errorView.backgroundColor	= self.view.backgroundColor;
			self.errorView				= errorView;
            [self.view addSubview:self.errorView];
		} else {
            if ([[self.view subviews] containsObject:self.errorView]) {
                [self.errorView removeFromSuperview];
                self.errorView = nil;
            }
		}
	} else {
        if ([[self.view subviews] containsObject:self.errorView]) {
            [self.errorView removeFromSuperview];
            self.errorView = nil;
        }
	}
}

- (void)showEmpty:(BOOL)show
{
    if (show) {
        NSString	*title		= [_dataSource titleForEmpty];
        NSString	*subtitle	= [_dataSource subtitleForEmpty];
        UIImage		*image		= [_dataSource imageForEmpty];
        UIImage     *titleImage = [_dataSource titleImageForEmpty];
        BOOL        executable  = [_dataSource buttonExecutable];

        if (title.length || subtitle.length || image) {
            YPErrorView *errorView = [[[YPErrorView alloc]	initWithTitle:title
                                                                subtitle:subtitle
                                                              titleImage:titleImage
                                                          watermarkImage:image] autorelease];
            if (executable && title) {
                [errorView addTarget:self action:@selector(emptyViewButtonAction)];
            }
            self.emptyView				= errorView;
        } else {
            if ([[self.view subviews] containsObject:self.emptyView]) {
                self.emptyView = nil;
            }
        }
    }else{
        self.emptyView = nil;
    }
    
}



- (void)search:(NSString*)kw
{
    
}

- (void)cancelSearch
{
    
}

#pragma mark -
#pragma mark Public
- (void)createModel
{
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableView*)tableView {
    if (nil == _tableView) {
        _tableView = [[YPBaseTableView alloc] initWithFrame:CGRectZero style:_tableViewStyle];
        _tableView.frame = self.view.bounds;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)setTableView:(UITableView*)tableView {
    if (tableView != _tableView) {
        
		if (_tableView) {
			[_tableView removeFromSuperview];
			[_tableView release];
		}
        
        if (tableView == nil) {
            _tableView = nil;
            self.tableOverlayView = nil;
        }else {
            _tableView = [tableView retain];
            _tableView.delegate = nil;
            _tableView.delegate = self;
            _tableView.dataSource = self.dataSource;
            
			if (!_tableView.superview) {
				[self.view addSubview:_tableView];
			}
        }
    }
}

- (void)setTableOverlayView:(UIView*)tableOverlayView animated:(BOOL)animated {
    if (tableOverlayView != _tableOverlayView) {
        if (_tableOverlayView) {
            if (animated) {
                [self fadeOutView:_tableOverlayView];
                
            } else {
                [_tableOverlayView removeFromSuperview];
            }
        }
        
        [_tableOverlayView release];
        _tableOverlayView = [tableOverlayView retain];
        
        if (_tableOverlayView) {
            _tableOverlayView.frame = [self rectForOverlayView];
            [self addToOverlayView:_tableOverlayView];
        }
        
        // XXXjoe There seem to be cases where this gets left disable - must investigate
        //_tableView.scrollEnabled = !_tableOverlayView;
    }
}

- (void)setTableWatermarkView:(UIView *)tableWatermarkView animated:(BOOL)animated{
    if (tableWatermarkView != _tableWatermarkView) {
        if (_tableWatermarkView) {
            if (animated) {
                [self fadeOutView:_tableWatermarkView];
                
            } else {
                [_tableWatermarkView removeFromSuperview];
            }
        }
        
        [_tableWatermarkView release];
        _tableWatermarkView = [tableWatermarkView retain];
        
        if (_tableWatermarkView) {
            _tableWatermarkView.frame = [self rectForWatermarkView];
            [self addToWatermarkView:_tableWatermarkView];
        }
        
        // XXXjoe There seem to be cases where this gets left disable - must investigate
        //_tableView.scrollEnabled = !_tableOverlayView;
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDataSource:(id<YPTableViewDataSource>)dataSource {
    if (dataSource != _dataSource) {
        [_dataSource release];
        _dataSource = [dataSource retain];
        _tableView.dataSource = _dataSource;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLoadingView:(UIView*)view {
    if (view != _loadingView) {
        if (_loadingView) {
            [_loadingView removeFromSuperview];
            RELEASE(_loadingView);
        }
        _loadingView = [view retain];
        if (_loadingView) {
            [self addToOverlayView:_loadingView];
            
        } else {
            [self resetOverlayView];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setErrorView:(UIView*)view {
    if (view != _errorView) {
        if (_errorView) {
            [_errorView removeFromSuperview];
            RELEASE(_errorView);
        }
        _errorView = [view retain];
        
        if (_errorView) {
            [self addToOverlayView:_errorView];
            
        } else {
            [self resetOverlayView];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setEmptyView:(UIView*)view {
    if (view != _emptyView) {
        if (_emptyView) {
            [_emptyView removeFromSuperview];
            RELEASE(_emptyView);
        }
        _emptyView = [view retain];
        if (_emptyView) {
            [self addToWatermarkView:_emptyView];
            
        } else {
            [self resetWatermarkView];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    
    
	if ([object isKindOfClass:[YPTableViewLoadMoreItem class]] && !self.loadingData) {
		YPTableViewLoadMoreItem *moreItem = (YPTableViewLoadMoreItem *)object;
		moreItem.isLoading = YES;
		YPTableViewLoadMoreCell *cell = (YPTableViewLoadMoreCell *)[self.tableView cellForRowAtIndexPath:indexPath];
		cell.animating = YES;
		[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self loadMoreAction];
	}
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didBeginDragging {
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didEndDragging {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)rectForOverlayView {
    CGRect frame = self.view.frame;
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if ([window findFirstResponder]) {
        frame.size.height -= 216.0f;
    }
    
    return frame;
}
- (CGRect)rectForWatermarkView {
    CGRect frame = self.view.frame;
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if ([window findFirstResponder]) {
        frame.size.height -= 216.0f;
    }
    
    return frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)pullToRefreshAction
{
    [self showLoading:YES];
}
- (void)infiniteScrollingAction
{
    [self showLoading:YES];
}
- (void)loadMoreAction
{}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)stopRefreshAction{
    self.tableView.pullToRefreshView.lastUpdatedDate = [NSDate date];
    [self.tableView.pullToRefreshView stopAnimating];
}

- (void)refreshTable
{
    if (![self isViewLoaded]) {
        return;
    }
	[self.tableView reloadData];
    
    [self showLoading:NO];
    [self showError:NO];
    [self showEmpty:[self.dataSource empty]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)emptyViewButtonAction{
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////
@end

@implementation YPTableViewController (delegate)

#pragma mark - UIScrollViewDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self didBeginDragging];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self didEndDragging];
}

#pragma mark - UITableViewDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    id<YPTableViewDataSource> dataSource = (id<YPTableViewDataSource>)tableView.dataSource;
    
    id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];
    
    return [cls tableView:tableView rowHeightForObject:object];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if ([tableView.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        NSString *title = [tableView.dataSource tableView:tableView
                                  titleForHeaderInSection:section];
        if (!title.length) {
            return 0;
        }
        return 22.0;
    }
    return 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// 自定义sectionView在继承的controller中自己实现
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * When the user taps a cell item, we check whether the tapped item has an attached URL and, if
 * it has one, we navigate to it. This also handles the logic for "Load more" buttons.
 */
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    id<YPTableViewDataSource> dataSource = (id<YPTableViewDataSource>)tableView.dataSource;
    id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    [self didSelectObject:object atIndexPath:indexPath];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Similar logic to the above. If the user taps an accessory item and there is an associated URL,
 * we navigate to that URL.
 */
- (void)tableView:(UITableView*)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath {
    id<YPTableViewDataSource> dataSource = (id<YPTableViewDataSource>)tableView.dataSource;
    id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    NSLog(@" object:%@",object);
    //    if ([object isKindOfClass:[TTTableLinkedItem class]]) {
    //        TTTableLinkedItem* item = object;
    //        if (item.accessoryURL && [_controller shouldOpenURL:item.accessoryURL]) {
    //            TTOpenURLFromView(item.accessoryURL, tableView);
    //        }
    //    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if (self.loadingData) {
		return;
	}
    
    CGFloat offsetY = scrollView.contentOffset.y;
	CGFloat contentFoot = scrollView.contentSize.height - offsetY;
	CGFloat viewHeight	= scrollView.frame.size.height;
    
	if (contentFoot <= viewHeight) {
        // 最后一项为加载更多
		int lastSectionIndex = 0;
        
		if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
			int sectionNumber = [self.dataSource numberOfSectionsInTableView:self.tableView];
            
			if (sectionNumber > 0) {
				lastSectionIndex = sectionNumber - 1;
			}
		}
        
		int lastRowIndex = 0;
        
		if ([self.dataSource tableView:self.tableView numberOfRowsInSection:lastSectionIndex] > 0) {
			lastRowIndex = [self.dataSource tableView:self.tableView numberOfRowsInSection:lastSectionIndex] - 1;
		}
        
		NSIndexPath *lastRowIndexPath	= [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
		id			object				= [self.dataSource tableView:self.tableView objectForRowAtIndexPath:lastRowIndexPath];
        
		if ([object isKindOfClass:[YPTableViewLoadMoreItem class]]) {
			[self didSelectObject:object atIndexPath:lastRowIndexPath];
		}
	}
    if (offsetY <= 40.0f) {
        // 第一项为加载更多
		NSIndexPath *lastRowIndexPath	= [NSIndexPath indexPathForRow:0 inSection:0];
		id			object				= [self.dataSource tableView:self.tableView objectForRowAtIndexPath:lastRowIndexPath];
        
		if ([object isKindOfClass:[YPTableViewLoadMoreItem class]]) {
			[self didSelectObject:object atIndexPath:lastRowIndexPath];
		}
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    // 第一项为加载更多
    NSIndexPath *lastRowIndexPath	= [NSIndexPath indexPathForRow:0 inSection:0];
    id			object				= [self.dataSource tableView:self.tableView objectForRowAtIndexPath:lastRowIndexPath];
    
    if ([object isKindOfClass:[YPTableViewLoadMoreItem class]]) {
        [self didSelectObject:object atIndexPath:lastRowIndexPath];
    }
}


@end