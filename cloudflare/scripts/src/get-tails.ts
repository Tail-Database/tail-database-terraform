declare var R2_BUCKET: R2Bucket;

const tails = async () => {
    const result = await R2_BUCKET.get(`tails.json`);

    return result ?
        Response.json(
            await result.json(),
            {
                headers: { 'content-type': 'application/json' },
                status: 200
            }
        ) :
        Response.json(
            { error: 'Not found' },
            {
                headers: { 'content-type': 'application/json' },
                status: 404
            }
        );
};

addEventListener('fetch', event => event.respondWith(tails()));