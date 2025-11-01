#!/usr/bin/env python3
"""
Simple HTTP server to serve the built Quarto book.
This is needed because pyodide/WASM requires serving over HTTP, not file:// protocol.

Usage:
    python serve-book.py [port]

Default port is 8000. If the port is in use, it will automatically try the next available port.
"""

import http.server
import socketserver
import webbrowser
import os
import sys
import socket
from pathlib import Path

def find_available_port(start_port=8000, max_attempts=10):
    """Find an available port starting from start_port."""
    for port in range(start_port, start_port + max_attempts):
        try:
            # Try to bind to the port
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.bind(('', port))
                return port
        except OSError:
            continue
    raise RuntimeError(f"Could not find an available port in range {start_port}-{start_port + max_attempts}")

# Get port from command line or use default
requested_port = int(sys.argv[1]) if len(sys.argv) > 1 else 8000

# Find the _build/book directory
build_dir = Path(__file__).parent / "_build" / "book"

if not build_dir.exists():
    print(f"Error: Build directory not found at {build_dir}")
    print("Please run 'quarto render' first to build the book.")
    sys.exit(1)

# Change to the build directory
os.chdir(build_dir)

# Find an available port
PORT = find_available_port(requested_port)
if PORT != requested_port:
    print(f"Port {requested_port} is in use, using port {PORT} instead")

# Create server
Handler = http.server.SimpleHTTPRequestHandler
Handler.extensions_map.update({
    '.wasm': 'application/wasm',
})

print(f"Serving book at http://localhost:{PORT}")
print(f"Directory: {build_dir}")
print("Press Ctrl+C to stop the server")

# Open browser
webbrowser.open(f'http://localhost:{PORT}')

# Start server
try:
    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        httpd.serve_forever()
except KeyboardInterrupt:
    print("\nServer stopped.")
    sys.exit(0)
