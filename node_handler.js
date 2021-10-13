'use strict';

module.exports.node_handler = (event, context, callback) => {
    const response = {
        statusCode: 200,
        headers: {
            'Content-Type': 'text/plain',
        },
        body: "Hello world",
    };

    callback(null, response);
};