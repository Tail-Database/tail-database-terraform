declare var R2_BUCKET: R2Bucket;

const getTail = async (req: Request) => {
    const url = new URL(req.url);
    const hash = url.pathname.split('/')[1];
    const result = await R2_BUCKET.get(`${hash}.json`);

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

addEventListener('fetch', event => event.respondWith(getTail(event.request)));
