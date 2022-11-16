declare var R2_BUCKET: R2Bucket;

const NOT_FOUND = { error: 'Not found' };
const responseHeaders = { headers: { 'content-type': 'application/json' } };

const handler = async (req: Request) => {
    const url = new URL(req.url);
    const hash = url.pathname.split('/')[1];
    const result = await R2_BUCKET.get(`${hash}.json`);

    return result ?
        Response.json(
            await result.json(),
            {
                ...responseHeaders,
                status: 200
            }
        ) :
        Response.json(
            NOT_FOUND,
            {
                ...responseHeaders,
                status: 404
            }
        );
};

addEventListener('fetch', event => event.respondWith(handler(event.request)));
