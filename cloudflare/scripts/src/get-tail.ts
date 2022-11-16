const handler = async () => {
	return Response.json({ message: 'hello world' });
};

addEventListener('fetch', event => event.respondWith(handler()));
