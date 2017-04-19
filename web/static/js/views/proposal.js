export default class ProposalView {
  filter () {
    this._getTemplate()
    document.getElementById('filter').addEventListener('change', (e) => {
      return this._getTemplate()
    }, false)
  };

  _getTemplate () {
    const tags = this._tags()
    if (tags.length > 0) {
      const selectors = tags.split(',').reduce((acc, slug) => acc + `:not(.${slug})`, '.tag')
      this._makeRequest(`/proposals/filter/${tags}`, () => this._muteInactive(selectors))
    } else {
      this._makeRequest('/proposals/filter/all')
    }
  }

  _tags () {
    const filters = document.getElementsByClassName('filter')
    return [...filters].map(function (select) {
      return [...select.options].filter(option => option.selected).map(option => option.value)
    }).filter(function (option) {
      return option[0].length > 0
    }).join(',')
  }

  _muteInactive (selectors) {
    document.querySelectorAll(selectors).forEach((el) => {
      return el.classList.add('muted')
    })
  }

  _makeRequest (url, callback) {
    const req = new window.XMLHttpRequest()
    req.open('GET', url, true)
    req.onreadystatechange = function () {
      if (req.readyState !== 4 || req.status !== 200) return
      document.getElementById('proposals-container').innerHTML = req.responseText
      if (typeof callback === 'function') callback()
    }
    req.send()
  }
}
