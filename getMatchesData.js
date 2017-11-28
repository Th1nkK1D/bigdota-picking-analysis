const axios = require('axios')

async function fetchMatches(num) {
    let result = []
    let lastMatchId

    for(let i = 0; i < num; i++) {
        let res

        try {
            res = await axios.get('https://api.opendota.com/api/publicMatches',{
                params: {
                    'less_than_match_id': lastMatchId
                }
            })
        } catch (error) {
            console.log(error)
        }

        // console.log(res.data)
        
        result = result.concat(res.data)
        lastMatchId = res.data[res.data.length-1].match_id
        console.log(lastMatchId)
    }
    
    return result;
}

fetchMatches(2).then(res => {
    console.log(res.length)
})