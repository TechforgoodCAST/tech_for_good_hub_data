export default class ProposalView {
  filter () {
    this.getTemplate()
    document.getElementById('filter').addEventListener('change', (e) => {
      return this.getTemplate()
    }, false)
  };

  getTemplate () {
    const tags = this.tags()
    if (tags.length > 0) {
      this.makeRequest(`/proposals/filter/${tags}`)
    } else {
      this.makeRequest('/proposals/filter/all')
    }
  }

  tags () {
    const filters = document.getElementsByClassName('filter')
    return [...filters].map(function (select) {
      return [...select.options].filter(option => option.selected).map(option => option.value)
    }).filter(function (option) {
      return option[0].length > 0
    }).join(',')
  }

  makeRequest (url) {
    var r = new window.XMLHttpRequest()
    r.open('GET', url, true)
    r.onreadystatechange = function () {
      if (r.readyState !== 4 || r.status !== 200) return
      document.getElementById('proposals').innerHTML = r.responseText
    }
    r.send()
  }
}
