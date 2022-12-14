declare var ADD_TAIL_ENDPOINT: string;

const addTail = async (req: Request) => {
    if (req.method === 'OPTIONS') {
        return new Response(
            null,
            {
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Headers': '*',
                    'Access-Control-Allow-Methods': 'OPTIONS,POST,PATCH',
                },
                status: 204
            }
        );
    }

    const body = await req.json();

    // This is a point of centralization which will eventually be replaced by a DAO
    const response = await fetch(ADD_TAIL_ENDPOINT, {
        // POST adds a new CAT, PATCH edits an existing CAT
        method: req.method === 'POST' ? 'POST' : 'PATCH',
        headers: {
            'Content-Type': 'application/json',
            'x-chia-signature': req.headers.get('x-chia-signature') || ''
        },
        body: JSON.stringify(body)
    });

    return Response.json(
        await response.json(),
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'POST',
                'Content-Type': 'application/json'
            },
            status: response.status
        }
    );
};

addEventListener('fetch', event => event.respondWith(addTail(event.request)));
