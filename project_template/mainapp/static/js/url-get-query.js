/**
    @return parsed GET query object
**/
function parseParameters() {
    var get = {}
    var query = window.location.search.substring(1)
    var couples = query.split('&')
    for (var i = 0; i < couples.length; i++) {
        var pair = couples[i].split('=')
        get[pair[0]] = pair[1]
    }
    return get
}

/**
    Set URL GET parameters
    @param get - parsed GET query object(see parseParameters)
**/
function setParameters(get) {
    var url = window.location.search.substring
    for (param in get) {
        var value = get[param]
        // Using a positive lookahead (?=\=) to find the
        // given parameter, preceded by a ? or &, and followed
        // by a = with a value after than (using a non-greedy selector)
        // and then followed by a & or the end of the string
        var val = new RegExp('(\\?|\\&)' + param + '=.*?(?=(&|$))'),
            qstring = /\?.+$/;
        // Check if the parameter exists
        if (val.test(url))
        {
            // if it does, replace it, using the captured group
            // to determine & or ? at the beginning
            url = url.replace(val, '$1' + param + '=' + value);
        }
        else if (qstring.test(url))
        {
            // otherwise, if there is a query string at all
            // add the param to the end of it
            url = url + '&' + param + '=' + value;
        }
        else
        {
            // if there's no query string, add one
            url = url + '?' + param + '=' + value;
        }
    }
    window.location.search = url
}