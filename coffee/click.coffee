
chrome.contextMenus.create
  title: "Topic"
  contexts: ["all"]
  onclick: (event, tab) ->
    data =
      title: tab.title
      url: tab.url
      favIconUrl: tab.favIconUrl

    $.post 'http://localhost:3000/topic', data, (err, res) ->
      console.log(err, res)
