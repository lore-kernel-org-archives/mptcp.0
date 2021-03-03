Content-Type: multipart/mixed; boundary="===============1922349417303779718=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 PATCH 1/2] mptcp: only admit explicitly supported
 sockopt
Date: Wed, 03 Mar 2021 19:43:38 +0100
Message-ID: <65ee09253b5e42cb100f914f059bdb0bb61dc0c9.1614796802.git.pabeni@redhat.com>
In-Reply-To: cover.1614796802.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8002

--===============1922349417303779718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unrolling mcast state at msk dismantel time is bug prone, as
syzkaller reported:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
5.11.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor905/8822 is trying to acquire lock:
ffffffff8d678fe8 (rtnl_mutex){+.+.}-{3:3}, at: ipv6_sock_mc_close+0xd7/0x11=
0 net/ipv6/mcast.c:323

but task is already holding lock:
ffff888024390120 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/=
sock.h:1600 [inline]
ffff888024390120 (sk_lock-AF_INET6){+.+.}-{0:0}, at: mptcp6_release+0x57/0x=
130 net/mptcp/protocol.c:3507

which lock already depends on the new lock.

Instead we can simply forbit any mcast-related setsockopt

Fixes: 717e79c867ca5 ("mptcp: Add setsockopt()/getsockopt() socket operatio=
ns")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - switch from blacklist to whitelist

A note on optname order. For each sol level, I tried to follow the
order used by the corresponding relevant setsockopt(), with the
following additional contraint:
[1] opt which should currently work correctly with no changes come first
[2] than opt that need some impl effort, but should not cause bugs/splat
  ATM
[3] then opt that are really a no-op - and currently work as intended
[4] (commented out) unsupported opt come last, with related reasoning.

Note that [2] is likely too wide. This is intended as to start discussion.
Looks like fixing issue/170 will require a bit of time :(
---
 net/mptcp/protocol.c | 215 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6b3112fac299..6a8c3f46f30a4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2877,6 +2877,218 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *m=
sk, int optname,
 	return ret;
 }
 =

+static bool mptcp_supported_sockopt(int level, int optname)
+{
+	if (level =3D=3D SOL_SOCKET) {
+		switch (optname) {
+		case SO_DEBUG:
+		case SO_REUSEPORT:
+		case SO_REUSEADDR:
+
+		/* the following 23 need a better implementation,
+		 * but are quite common we want to preserve them
+		 */
+		case SO_BINDTODEVICE:
+		case SO_SNDBUF:
+		case SO_SNDBUFFORCE:
+		case SO_RCVBUF:
+		case SO_RCVBUFFORCE:
+		case SO_KEEPALIVE:
+		case SO_PRIORITY:
+		case SO_LINGER:
+		case SO_TIMESTAMP_OLD:
+		case SO_TIMESTAMP_NEW:
+		case SO_TIMESTAMPNS_OLD:
+		case SO_TIMESTAMPNS_NEW:
+		case SO_TIMESTAMPING_OLD:
+		case SO_TIMESTAMPING_NEW:
+		case SO_RCVLOWAT:
+		case SO_RCVTIMEO_OLD:
+		case SO_RCVTIMEO_NEW:
+		case SO_MARK:
+		case SO_INCOMING_CPU:
+		case SO_BINDTOIFINDEX:
+#ifdef CONFIG_NET_RX_BUSY_POLL
+		case SO_BUSY_POLL:
+		case SO_PREFER_BUSY_POLL:
+		case SO_BUSY_POLL_BUDGET:
+#endif
+
+		/* next ten are no-op for plain TCP */
+		case SO_NO_CHECK:
+		case SO_DONTROUTE:
+		case SO_BROADCAST:
+		case SO_BSDCOMPAT:
+		case SO_PASSCRED:
+		case SO_PASSSEC:
+		case SO_RXQ_OVFL:
+		case SO_WIFI_STATUS:
+		case SO_NOFCS:
+		case SO_SELECT_ERR_QUEUE:
+
+		/* SO_OOBINLINE is not supported, let's avoid the related mess */
+		/* SO_ATTACH_FILTER, SO_ATTACH_BPF, SO_ATTACH_REUSEPORT_CBPF,
+		 * SO_DETACH_REUSEPORT_BPF, SO_DETACH_FILTER, SO_LOCK_FILTER,
+		 * we must be careful with subflows
+		 */
+		/* SO_ATTACH_REUSEPORT_EBPF is not supported, at it checks
+		 * explicitly the sk_protocol field
+		 */
+		/* SO_PEEK_OFF is unsupported, as it is for plain TCP */
+		/* SO_MAX_PACING_RATE is unsupported, we must be careful with subflows */
+		/* SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
+		 * but likely needs careful design
+		 */
+		/* SO_ZEROCOPY is currently unsupported, TODO in sndmsg */
+		/* SO_TXTIME is currently unsupported */
+			return true;
+		}
+		return false;
+	}
+	if (level =3D=3D SOL_IP) {
+		switch (optname) {
+		/* should work fine */
+		case IP_FREEBIND:
+		case IP_TRANSPARENT:
+
+		/* the following nine control cmsg */
+		case IP_PKTINFO:
+		case IP_RECVTTL:
+		case IP_RECVTOS:
+		case IP_RECVOPTS:
+		case IP_RETOPTS:
+		case IP_PASSSEC:
+		case IP_RECVORIGDSTADDR:
+		case IP_CHECKSUM:
+		case IP_RECVFRAGSIZE:
+
+		/* common stuff that need some love */
+		case IP_TOS:
+		case IP_TTL:
+		case IP_BIND_ADDRESS_NO_PORT:
+		case IP_MTU_DISCOVER:
+		case IP_RECVERR:
+
+		/* possibly less common may deserve some love */
+		case IP_MINTTL:
+
+		/* the following is apparently a no-op for plain TCP */
+		case IP_RECVERR_RFC4884:
+
+		/* IP_OPTIONS is not supported, needs subflow care */
+		/* IP_HDRINCL, IP_NODEFRAG are not supported, RAW specific */
+		/* IP_MULTICAST_TTL, IP_MULTICAST_LOOP, IP_UNICAST_IF,
+		 * IP_ADD_MEMBERSHIP, IP_ADD_SOURCE_MEMBERSHIP, IP_DROP_MEMBERSHIP,
+		 * IP_DROP_SOURCE_MEMBERSHIP, IP_BLOCK_SOURCE, IP_UNBLOCK_SOURCE,
+		 * MCAST_JOIN_GROUP, MCAST_LEAVE_GROUP MCAST_JOIN_SOURCE_GROUP,
+		 * MCAST_LEAVE_SOURCE_GROUP, MCAST_BLOCK_SOURCE, MCAST_UNBLOCK_SOURCE,
+		 * MCAST_MSFILTER, IP_MULTICAST_ALL are not supported, better not deal w=
ith mcast stuff
+		 */
+		/* IP_IPSEC_POLICY, IP_XFRM_POLICY are nut supported, unrelated here */
+			return true;
+		}
+		return false;
+	}
+	if (level =3D=3D SOL_IPV6) {
+		switch (optname) {
+		case IPV6_V6ONLY:
+
+		/* the following 14 control cmsg */
+		case IPV6_RECVPKTINFO:
+		case IPV6_2292PKTINFO:
+		case IPV6_RECVHOPLIMIT:
+		case IPV6_2292HOPLIMIT:
+		case IPV6_RECVRTHDR:
+		case IPV6_2292RTHDR:
+		case IPV6_RECVHOPOPTS:
+		case IPV6_2292HOPOPTS:
+		case IPV6_RECVDSTOPTS:
+		case IPV6_2292DSTOPTS:
+		case IPV6_RECVTCLASS:
+		case IPV6_FLOWINFO:
+		case IPV6_RECVPATHMTU:
+		case IPV6_RECVORIGDSTADDR:
+		case IPV6_RECVFRAGSIZE:
+
+		/* the following 14 need some love but are quite common */
+		case IPV6_TCLASS:
+		case IPV6_TRANSPARENT:
+		case IPV6_FREEBIND:
+		case IPV6_PKTINFO:
+		case IPV6_2292PKTOPTIONS:
+		case IPV6_UNICAST_HOPS:
+		case IPV6_MTU_DISCOVER:
+		case IPV6_MTU:
+		case IPV6_RECVERR:
+		case IPV6_FLOWINFO_SEND:
+		case IPV6_FLOWLABEL_MGR:
+		case IPV6_MINHOPCOUNT:
+		case IPV6_DONTFRAG:
+		case IPV6_AUTOFLOWLABEL:
+
+		/* the following one is a no-op for plain TCP */
+		case IPV6_RECVERR_RFC4884:
+
+		/* IPV6_HOPOPTS, IPV6_RTHDRDSTOPTS, IPV6_RTHDR, IPV6_DSTOPTS are
+		 * not supported
+		 */
+		/* IPV6_MULTICAST_HOPS, IPV6_MULTICAST_LOOP, IPV6_UNICAST_IF, =

+ * 		 * IPV6_MULTICAST_IF, IPV6_ADDRFORM,
+		 * IPV6_ADD_MEMBERSHIP, IPV6_DROP_MEMBERSHIP, IPV6_JOIN_ANYCAST,
+		 * IPV6_LEAVE_ANYCAST, IPV6_MULTICAST_ALL, MCAST_JOIN_GROUP, MCAST_LEAVE=
_GROUP,
+		 * MCAST_JOIN_SOURCE_GROUP, MCAST_LEAVE_SOURCE_GROUP,
+		 * MCAST_BLOCK_SOURCE, MCAST_UNBLOCK_SOURCE, MCAST_MSFILTER =

+		 * are not supported better not deal with mcast
+		 */
+		/* IPV6_ROUTER_ALERT, IPV6_ROUTER_ALERT_ISOLATE are not supported, since=
 are evil */
+
+		/* IPV6_IPSEC_POLICY, IPV6_XFRM_POLICY are nut supported */
+		/* IPV6_ADDR_PREFERENCES is not supported, we must be careful with subfl=
ows */
+			return true;
+		}
+		return false;
+	}
+	if (level =3D=3D SOL_TCP) {
+		switch (optname) {
+		/* the following 2 are no-op or should work just fine */
+		case TCP_THIN_DUPACK:
+		case TCP_DEFER_ACCEPT:
+
+		/* the following 18 need some love */
+		case TCP_MAXSEG:
+		case TCP_NODELAY:
+		case TCP_THIN_LINEAR_TIMEOUTS:
+		case TCP_CONGESTION:
+		case TCP_ULP:
+		case TCP_CORK:
+		case TCP_KEEPIDLE:
+		case TCP_KEEPINTVL:
+		case TCP_KEEPCNT:
+		case TCP_SYNCNT:
+		case TCP_SAVE_SYN:
+		case TCP_LINGER2:
+		case TCP_WINDOW_CLAMP:
+		case TCP_QUICKACK:
+		case TCP_USER_TIMEOUT:
+		case TCP_TIMESTAMP:
+		case TCP_NOTSENT_LOWAT:
+		case TCP_TX_DELAY:
+
+		/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not compatible w=
ith MPTCP */
+
+		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
+		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
+		 */
+		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN TCP_FASTOPEN_CONNECT, TCP_FASTOPEN_NO_=
COOKIE,
+		 * are not supported fastopen is currently unsupported
+		 */
+		/* TCP_INQ is currently unsupported, needs some recvmsg work */
+			return true;
+		}
+	}
+	return false;
+}
+
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
@@ -2885,6 +3097,9 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 =

 	pr_debug("msk=3D%p", msk);
 =

+	if (!mptcp_supported_sockopt(level, optname))
+		return -ENOPROTOOPT;
+
 	if (level =3D=3D SOL_SOCKET)
 		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
 =

-- =

2.26.2

--===============1922349417303779718==--
