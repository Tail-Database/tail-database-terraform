declare var R2_BUCKET: R2Bucket;

const searchIndex = async () => {
    const result = await R2_BUCKET.get(`search_index.json`);

    return result ?
        Response.json(
            await result.json(),
            {
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET',
                    'content-type': 'application/json'
                },
                status: 200
            }
        ) :
        Response.json(
            { error: 'Not found' },
            {
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET',
                    'content-type': 'application/json'
                },
                status: 404
            }
        );
};

addEventListener('fetch', event => event.respondWith(searchIndex()));
