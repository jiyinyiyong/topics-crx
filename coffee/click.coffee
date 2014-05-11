
local = {}

chrome.cookies.get
  name: 'token'
  url:'http://local.tiye.me'
, (token) ->
  local.token = token.value

chrome.contextMenus.create
  title: "Topic"
  contexts: ["all"]
  onclick: (event, tab) ->
    if not local.token?
      throw new Error "not logined"

    data =
      title: tab.title
      url: tab.url
      favIconUrl: tab.favIconUrl
      token: local.token

    $.ajax
      url: 'http://local.tiye.me/topic'
      type: 'POST'
      data: data
      xhrFields:
        withCredentials: true
      error: (err) ->
        throw err