import $ from 'jquery'

export default class MainView {
  mobileMenu () {
    const $body = $('body')
    const $document = $(document)
    const menu = 'main-menu'
    const menuSelect = $('.' + menu)
    const openMenu = 'nav-open'
    const mobileMenu = 'mobile-menu'
    const mobileArrorw = '.mobile-arrow'
    const parentOpened = 'parent-opened'
    const opened = 'opened'
    const actionsMenu = 'actions-menu'
    const actionsSelect = $('.' + actionsMenu)

    if ($body.hasClass('menu-ff') || $body.hasClass('menu-nn')) {
      $('.sec-hero .sec-hs-elements').css('top', '50%')
    }

    if (!menuSelect.length && !actionsSelect.length) return

    $document.on('touchend click', '.ac-btn-mobile-menu', function (event) {
      event.preventDefault()
      menuSelect.detach().prependTo('body').addClass(mobileMenu).addClass('menu-m').removeClass(menu).fadeIn(300)
      $('.' + mobileMenu).find('li.menu-item-has-children > a').after('<a href="#" class="mobile-arrow"></a>')
      $body.toggleClass(openMenu)
    })

    $document.on('touchend click', '.ac-btn-mobile-actions-menu', function (event) {
      event.preventDefault()
      actionsSelect.detach().prependTo('body').addClass(mobileMenu).addClass('menu-a').removeClass(actionsMenu).fadeIn(300)

      $body.toggleClass(openMenu)
    })

    $document.on('touchend click', '.ac-btn-mobile-close, .nav-open .menu-m .gotosection', function (event) {
      event.preventDefault()
      $('.' + mobileMenu).prependTo('.main-menu-wrap').removeClass(mobileMenu).removeClass('menu-m').addClass(menu)
      menuSelect.find(mobileArrorw).remove()
      menuSelect.find('.' + parentOpened).removeClass(parentOpened)
      menuSelect.find('.' + opened).removeClass(opened)
      $body.removeClass(openMenu)
      // if ($(event.currentTarget).hasClass('gotosection')) {
      //   ac_ScrollTo($(event.currentTarget).find('a'))
      // }
    })

    $document.on('touchend click', '.ac-btn-mobile-act-close, .nav-open .menu-a .gotosection', function (event) {
      event.preventDefault()
      $('.' + mobileMenu).prependTo('.main-header-right').addClass(actionsMenu).removeClass('menu-a').removeClass(mobileMenu)
      $body.removeClass(openMenu)
      // if ($(event.currentTarget).hasClass('gotosection')) {
      //   ac_ScrollTo($(event.currentTarget).find('a'));
      // }
    })

    $document.on('touchend click', mobileArrorw, function (event) {
      event.preventDefault()
      $(event.target).parent().toggleClass(parentOpened)
      $(event.target).next('ul').toggleClass(opened)
    })
  };
}
