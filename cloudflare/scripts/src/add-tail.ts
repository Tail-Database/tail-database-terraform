declare var ADD_TAIL_ENDPOINT: string;

const addTail = async (req: Request) => {
    // This is a point of centralization which will eventually be replaced by a DAO
    const body = await req.json();

    const response = await fetch(ADD_TAIL_ENDPOINT, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body)
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
