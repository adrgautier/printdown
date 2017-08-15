var retext = require('retext');
var emoji = require('retext-emoji');
var fs = require('fs');
var input = require('optimist').argv.input;
var spell = require('retext-spell');
var dictionary = require('dictionary-fr');
var report = require('vfile-reporter');

fs.readFile('input/'+input, (err, data) => {
    //if (err) throw err;
    retext()
        .use(emoji, {convert: 'encode'})
        //.use(spell, dictionary)
        .process(data, (err, data) => {
            console.error(report(err || data));

            fs.writeFile('tmp/'+input, String(data), (err, data) => {
                if (err) throw err;
            });
        });
});

