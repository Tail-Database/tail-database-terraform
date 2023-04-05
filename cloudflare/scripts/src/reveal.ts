declare var REVEAL_ENDPOINT: string;

const reveal = async (req: Request) => {
    if (req.method === 'OPTIONS') {
        return new Response(
            null,
            {
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Headers': '*',
                    'Access-Control-Allow-Methods': 'OPTIONS,GET',
                },
                status: 204
            }
        );
    }

    const url = new URL(req.url);
    const coin_id = url.pathname.split('/')[2];

    // This is a point of centralization which will eventually be replaced by a DAO
    const response = await fetch(`${REVEAL_ENDPOINT}/${coin_id}`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        }
    });

    return Response.json(
        await response.json(),
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET',
                'Content-Type': 'application/json'
            },
            status: response.status
        }
    );
};

addEventListener('fetch', event => event.respondWith(reveal(event.request)));
