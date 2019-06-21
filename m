Content-Type: multipart/mixed; boundary="===============7531630243857879791=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/3] Change sock->sk_protocol to a 16-bit value
Date: Fri, 21 Jun 2019 16:55:31 -0700
Message-ID: <20190621235534.19690-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1439

--===============7531630243857879791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While debugging socket state transitions in MPTCP sockets, I found that
MPTCP sockets were listing IPPROTO_TCP as their protocol in
/sys/kernel/debug/tracing/trace. sock->sk_protocol was only 8 bits wide,
truncating the new value of IPPROTO_MPTCP (0x0106) to IPPROTO_TCP
(0x06).

The networking code has varying integer widths for 'protocol' at
different layers:

 * POSIX socket API: 32 bits
 * sk_buff->protocol: 16 bits
 * IP header (on the wire): 8 bits

MPTCP shows a use for protocol values outside those that fit in an IP
header. The change to struct sock fills an 8-bit hole, so there is no
change in the size of the structure.

Given that we are currently discussing the appropriate value for
IPPROTO_MPTCP, I'm sending this as an RFC to inform those discussions. I
had previously thought that the 16-bit value for IPPROTO_MPTCP was
compatible with the existing code base.

Mat Martineau (3):
  net: Make sock protocol value checks more specific
  sock: Make sk_protocol a 16-bit value
  net: Add IPPROTO_MPTCP to inet_sock_set_state tracepoint output

 include/net/sock.h          | 5 ++---
 include/trace/events/sock.h | 5 +++--
 net/ax25/af_ax25.c          | 2 +-
 net/decnet/af_decnet.c      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

-- =

2.22.0


--===============7531630243857879791==--
