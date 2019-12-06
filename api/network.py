from socket import AddressFamily

import psutil


def get_network_address():
    ip = []
    addrs = psutil.net_if_addrs()
    for addr in addrs.values():
        for i in addr:
            if i.family == AddressFamily.AF_INET:
                ip.append(i.address)
    return ip
