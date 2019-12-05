import os
import random
import sys
import threading
import webbrowser

from flask import Flask, render_template

# Distinguish the root directory of web UI
# in development or production environments
root_path = "../web/dist"
if getattr(sys, "frozen", False):
    root_path = os.path.join(sys._MEIPASS, "www")
    print(root_path)

# Define APP
app = Flask(
    import_name = __name__, 
    root_path = root_path, 
    static_folder = ""
)

def get_network_address():
    import psutil
    from socket import AddressFamily

    ip = []
    addrs = psutil.net_if_addrs()
    for addr in addrs.values():
        for i in addr:
            if i.family == AddressFamily.AF_INET:
                ip.append(i.address)
    return ip


@app.route("/")
def root():
    return app.send_static_file('index.html')


if __name__ == "__main__":
    # Define Port
    port = 5000 + random.randint(0, 999)
    url = "http://0.0.0.0:{0}".format(port)

    # Print IPAG IP Address
    print("Starting IPAG... ")
    ip = get_network_address()
    for i in ip:
        print(f"Running on http://{i}:{port}/")

    # Open Browser
    threading.Timer(1.25, lambda: webbrowser.open(url)).start()

    # Run APP
    # app.run(host="0.0.0.0", port=port, debug=True, use_reloader=False)
    app.run(host="0.0.0.0", port=port, debug=False)
