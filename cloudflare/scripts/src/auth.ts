declare var AUTH_ENDPOINT: string;

const auth = async (req: Request) => {
    if (req.method === 'OPTIONS') {
        return new Response(
            null,
            {
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Headers': '*',
                    'Access-Control-Allow-Methods': 'OPTIONS,POST',
                },
                status: 204
            }
        );
    }

    const url = new URL(req.url);
    const hash = url.pathname.split('/')[2];

    const body: { coinId: string; } = await req.json();

    // This is a point of centralization which will eventually be replaced by a DAO
    const response = await fetch(`${AUTH_ENDPOINT}/${hash}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ coinId: body.coinId })
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

addEventListener('fetch', event => event.respondWith(auth(event.request)));
