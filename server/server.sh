echo 'Server start script initialization'

PORT = 8000

echo 'Cleaning port' $PORT '...'
fuser -k 8000/tcp

cd build/web/

echo 'Starting server on port' $PORT '...'
python3 -m http.server $PORT

echo 'Server exited...'