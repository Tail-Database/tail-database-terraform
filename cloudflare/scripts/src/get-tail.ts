declare var R2_BUCKET: R2Bucket;
declare var CACHE: KVNamespace;

const getTail = async (req: Request) => {
    const url = new URL(req.url);
    const hash = url.pathname.split('/')[1];
    const key = `get-tail-${hash}`;

    const cachedResponse = await CACHE.get(key);

    if (cachedResponse) {
        return Response.json(
            JSON.parse(cachedResponse),
            {
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET',
                    'content-type': 'application/json'
                },
                status: 200
            }
        )
    }

    const result = await R2_BUCKET.get(`${hash}.json`);

    if (!result) {
        return Response.json(
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
    }

    const response = await result.json<string>();

    await CACHE.put(key, JSON.stringify(response));

    return Response.json(
        response,
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET',
                'content-type': 'application/json'
            },
            status: 200
        }
    );
};

addEventListener('fetch', event => event.respondWith(getTail(event.request)));
