declare var R2_BUCKET: R2Bucket;
declare var CACHE: KVNamespace;

const tails = async () => {
    const key = `get-tails`;

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

    const result = await R2_BUCKET.get(`tails.json`);

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

    await CACHE.put(key, JSON.stringify(response), { expirationTtl: 60 * 5 });

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

addEventListener('fetch', event => event.respondWith(tails()));
