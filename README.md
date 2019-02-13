# gridfw-Uploader

## Installation
This package will be installed automatically with Gridfw framework.
(or use: npm i -S gridfw-downloader)

## Configuration
Inside your config file, add the following:
```javascript
{
    plugins: {
        downloader:{
            require: 'gridfw-downloader',
            // add options here
            // all are optionals
        }
    }
}
```

## Use
```javascript
const Gridfw = require('gridfw');
const app = new Gridfw();

# upload data from user
app.post('/path', function(ctx){
    // upload will starts after calling this line,
    // this will enable you to add pre-processing and post-processing
    // You can too accept or refuse upload, add custom behaviours, ...
    data = await ctx.upload(/** optionalOptions **/);

    ctx.send('Data received.');
});
```

## Options
Optional could be added to config file or to "ctx.upload" method
```javascript
{
    size: 20 * (2**10), // Max body size (20M)
    // multipart/form-data and application/x-www-form-urlencoded options
    fieldNameSize: 1000, // Max field name size (in bytes)
    fieldSize: 2**20, // Max field value size (default 1M)
    fields: 1000, // Max number of non-file fields
    // Additional Multipart/form-data options
    fileSize: 10 * (2**20), // the max file size (in bytes) (default 10M)
    files: 100, // the max number of file fields
    parts: 1000, // the max number of parts (fields + files) 
    headerPairs: 2000 // the max number of header 
}
```


# Supporters
[![coredigix](https://www.coredigix.com/img/logo.png)](https://coredigix.com)