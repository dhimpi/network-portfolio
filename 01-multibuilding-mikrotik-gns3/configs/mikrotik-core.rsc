# 2026-08-21 09:09:34 by RouterOS 7.15.2
# software id =
#
/disk
set slot1 media-interface=none media-sharing=no slot=slot1
set slot2 media-interface=none media-sharing=no slot=slot2
/interface ethernet
set [ find default-name=ether4 ] name=ether1
set [ find default-name=ether1 ] name=ether2
set [ find default-name=ether2 ] name=ether3
set [ find default-name=ether3 ] name=ether4
/ip pool
add name=dhcp_pool0 ranges=10.10.10.2-10.10.10.254
add name=dhcp_pool1 ranges=10.10.20.2-10.10.20.254
add name=dhcp_pool2 ranges=10.10.30.2-10.10.30.254
add name=dhcp_pool3 ranges=10.10.40.2-10.10.40.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether2 lease-time=3h name=dhcp1
add address-pool=dhcp_pool1 interface=ether3 lease-time=3h name=dhcp2
add address-pool=dhcp_pool2 interface=ether4 lease-time=3h name=dhcp3
add address-pool=dhcp_pool3 interface=ether5 lease-time=3h name=dhcp4
/port
set 0 name=serial0
/ip address
add address=10.10.10.1/24 comment="Gedung 1" interface=ether2 network=\
    10.10.10.0
add address=10.10.20.1/24 comment="Gedung 2" interface=ether3 network=\
    10.10.20.0
add address=10.10.30.1/24 comment="Gedung 3" interface=ether4 network=\
    10.10.30.0
add address=10.10.40.1/24 comment="Gedung 4" interface=ether5 network=\
    10.10.40.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=10.10.10.0/24 dns-server=8.8.8.8 gateway=10.10.10.1
add address=10.10.20.0/24 dns-server=8.8.8.8 gateway=10.10.20.1
add address=10.10.30.0/24 dns-server=8.8.8.8 gateway=10.10.30.1
add address=10.10.40.0/24 dns-server=8.8.8.8 gateway=10.10.40.1
/ip firewall filter
add action=accept chain=input comment="Izinkan koneksi lama" \
    connection-state=established,related
add action=drop chain=input comment=\
    "Blok akses langsung dari internet ke router" in-interface=ether1
add action=drop chain=forward comment="Blokir Gedung 1 ke Gedung 2" \
    dst-address=10.10.20.0/24 src-address=10.10.10.0/24
/ip firewall nat
add action=masquerade chain=srcnat comment="NAT Internet" out-interface=\
    ether1
/system note
set show-at-login=no
