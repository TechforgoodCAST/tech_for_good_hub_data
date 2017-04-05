import $ from 'jquery';

export default class MainView {
	mobileMenu () {
		var $window			   = $( window ),
			  $body			     = $( 'body' ),
			  $document		   = $( document ),
        menu           = 'main-menu',
			  menu_select    = $('.' + menu),
			  opened_menu    = 'nav-open',
			  mobile_menu    = 'mobile-menu',
			  mobile_arrow   = '.mobile-arrow',
			  parent_opened  = 'parent-opened',
			  opened         = 'opened',
			  actions_menu   = 'actions-menu',
			  actions_select = $('.' + actions_menu );

		if( $body.hasClass('menu-ff') || $body.hasClass('menu-nn') ) {
			$('.sec-hero .sec-hs-elements').css('top','50%');
		}

		if( ! menu_select.length &&  ! actions_select.length )
			return;

		$document.on('touchend click', '.ac-btn-mobile-menu', function( event ) {
			event.preventDefault();
			menu_select.detach().prependTo('body').addClass(mobile_menu).addClass('menu-m').removeClass(menu).fadeIn(300);
			$('.'+mobile_menu).find('li.menu-item-has-children > a').after('<a href="#" class="mobile-arrow"></a>');
			$body.toggleClass(opened_menu);
		});

		$document.on('touchend click', '.ac-btn-mobile-actions-menu', function( event ) {
			event.preventDefault();
			actions_select.detach().prependTo('body').addClass(mobile_menu).addClass('menu-a').removeClass(actions_menu).fadeIn(300);

			$body.toggleClass(opened_menu);
		});

		$document.on('touchend click', '.ac-btn-mobile-close, .nav-open .menu-m .gotosection', function( event ){
			event.preventDefault();
			$('.'+mobile_menu).prependTo('.main-menu-wrap').removeClass(mobile_menu).removeClass('menu-m').addClass(menu);
			menu_select.find(mobile_arrow).remove();
			menu_select.find('.'+parent_opened).removeClass(parent_opened);
			menu_select.find('.'+opened).removeClass(opened);
			$body.removeClass(opened_menu);
			if( $( event.currentTarget ).hasClass('gotosection') ) {
				ac_ScrollTo( $( event.currentTarget ).find('a') );
			}
		});

		$document.on('touchend click', '.ac-btn-mobile-act-close, .nav-open .menu-a .gotosection', function( event ){
			event.preventDefault();
			$('.'+mobile_menu).prependTo('.main-header-right').addClass(actions_menu).removeClass('menu-a').removeClass(mobile_menu);
			$body.removeClass(opened_menu);
			if( $( event.currentTarget ).hasClass('gotosection') ) {
				ac_ScrollTo( $( event.currentTarget ).find('a') );
			}
		});

		$document.on('touchend click', mobile_arrow, function( event ){
			event.preventDefault();
			$( event.target ).parent().toggleClass(parent_opened);
			$( event.target ).next('ul').toggleClass(opened);
		});
  };
}
