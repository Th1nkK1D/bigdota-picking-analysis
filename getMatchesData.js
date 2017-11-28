const axios = require('axios')
const jsonfile = require('jsonfile')

const output = 'matches.json'

async function fetchMatches(num) {
    let result = []
    let lastMatchId

    for(let i = 1; i <= num; i++) {
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
        
        result = result.concat(res.data)
        lastMatchId = res.data[res.data.length-1].match_id

        console.log(i*100 + '/' + num*100)
    }
    
    return result;
}

if(!process.argv[2]) {
    console.log('Please define an amount of data')
} else {
    console.log('fetching...')

    fetchMatches(Math.floor(process.argv[2]/100)).then(res => {
        console.log('writing...')

        jsonfile.writeFile(output, res,{spaces: 2}, function (err) {
            console.error(err)
        })

        console.log('completed')
    })
}