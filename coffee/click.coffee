
local =
  token: undefined
  urls: []

apiHost = 'http://topics-api.tiye.me'
# apiHost = 'http://topics-api.tiye.dev'

chrome.cookies.get
  name: 'token'
  url: apiHost
, (token) ->
  if not token?
    alert 'token for topics not found'
    throw new Error 'token not found'
  local.token = token.value

chrome.contextMenus.create
  title: "Topic"
  contexts: ["all"]
  onclick: (event, tab) ->
    if not local.token?
      throw new Error "not logined"

    return if tab.url in local.urls
    local.urls.push tab.url
    local.urls.shift() if local.urls.length > 50

    data =
      title: tab.title
      url: tab.url
      favIconUrl: tab.favIconUrl
      token: local.token

    $.ajax
      url: "#{apiHost}/topic"
      type: 'POST'
      data: data
      xhrFields:
        withCredentials: true
      error: (err) ->
        alert "Failed to send, #{JSON.stringify err}"
        throw err