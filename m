Content-Type: multipart/mixed; boundary="===============3378671019134014461=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/3] add ADD_ADDR IPv6 support
Date: Sat, 10 Oct 2020 18:07:22 +0800
Message-ID: <cover.1602323760.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6278

--===============3378671019134014461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v4:
 - update the patches as Paolo suggested:
 - change the 'add_addr_signal' type
 - set MPTCP_ADD_ADDR_IPV6 in mptcp_pm_announce_addr
 - add a new helper mptcp_send_dedicated_add_addr_packet to sent out a =

new pure ACK packet
 - drop other MPTCP suboptions in mptcp_established_options_add_addr

v3:
 - drop other MPTCP suboptions instead of OPTION_TS

v2:
 - avoid adding new field to tcp_sock, add new field in mptcp_pm_data.
 - drop OPTION_TS in mptcp_established_options_add_addr, not in
tcp_established_options.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/55

Geliang Tang (3):
  mptcp: change add_addr_signal type
  mptcp: send out dedicated ADD_ADDR packet
  selftests: mptcp: add ADD_ADDR IPv6 test cases

 net/mptcp/options.c                           | 23 ++++++-
 net/mptcp/pm.c                                | 21 ++++---
 net/mptcp/pm_netlink.c                        | 37 +++++++++++
 net/mptcp/protocol.h                          | 13 +++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 61 ++++++++++++++++++-
 5 files changed, 140 insertions(+), 15 deletions(-)

-- =

2.26.2

--===============3378671019134014461==--
