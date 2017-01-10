var retext = require('retext');
var emoji = require('retext-emoji');
var fs = require('fs');
var input = require('optimist').argv.input;

fs.readFile('input/'+input, (err, data) => {
    //if (err) throw err;
    retext()
        .use(emoji, {convert: 'encode'})
        .process(data, (err, data) => {
            if (err) throw err;
            console.log('coucou', String(data));

            fs.writeFile('tmp/'+input, String(data), (err, data) => {
                if (err) throw err;
            });
        });
});

