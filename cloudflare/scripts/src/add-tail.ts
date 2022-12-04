declare var ADD_TAIL_ENDPOINT: string;

const addTail = async (req: Request) => {
    // This is a point of centralization which will eventually be replaced by a DAO
    const response = await fetch(ADD_TAIL_ENDPOINT, {
        method: 'POST',
        body: await req.json()
    });

    return Response.json(
        await response.json(),
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'POST',
                'content-type': 'application/json'
            },
            status: 200
        }
    );
};

addEventListener('fetch', event => event.respondWith(addTail(event.request)));
