const getJSON = require('get-json')


getJSON('https://api.opendota.com/api/publicMatches', function(error, response){
    if(error) {
        console.log(error)
    } else {    
        console.log(response.length)
    }
})