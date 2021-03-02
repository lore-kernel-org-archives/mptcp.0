Content-Type: multipart/mixed; boundary="===============4507289590110488667=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/2] mptcp: forbit mcast-related sockopt on MPTCP
 sockets
Date: Tue, 02 Mar 2021 18:47:11 +0100
Message-ID: <17ba5d5c8367fdd4d3dd8beb0e9334647688908d.1614706783.git.pabeni@redhat.com>
In-Reply-To: cover.1614706783.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7980

--===============4507289590110488667==
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
 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6b3112fac299..f62912d91d81c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2877,6 +2877,48 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *ms=
k, int optname,
 	return ret;
 }
 =

+static bool mptcp_unsupported(int level, int optname)
+{
+	if (level =3D=3D SOL_IP) {
+		switch (optname) {
+		case IP_ADD_MEMBERSHIP:
+		case IP_ADD_SOURCE_MEMBERSHIP:
+		case IP_DROP_MEMBERSHIP:
+		case IP_DROP_SOURCE_MEMBERSHIP:
+		case IP_BLOCK_SOURCE:
+		case IP_UNBLOCK_SOURCE:
+		case MCAST_JOIN_GROUP:
+		case MCAST_LEAVE_GROUP:
+		case MCAST_JOIN_SOURCE_GROUP:
+		case MCAST_LEAVE_SOURCE_GROUP:
+		case MCAST_BLOCK_SOURCE:
+		case MCAST_UNBLOCK_SOURCE:
+		case MCAST_MSFILTER:
+			return true;
+		}
+		return false;
+	}
+	if (level =3D=3D SOL_IPV6) {
+		switch (optname) {
+		case IPV6_ADDRFORM:
+		case IPV6_ADD_MEMBERSHIP:
+		case IPV6_DROP_MEMBERSHIP:
+		case IPV6_JOIN_ANYCAST:
+		case IPV6_LEAVE_ANYCAST:
+		case MCAST_JOIN_GROUP:
+		case MCAST_LEAVE_GROUP:
+		case MCAST_JOIN_SOURCE_GROUP:
+		case MCAST_LEAVE_SOURCE_GROUP:
+		case MCAST_BLOCK_SOURCE:
+		case MCAST_UNBLOCK_SOURCE:
+		case MCAST_MSFILTER:
+			return true;
+		}
+		return false;
+	}
+	return false;
+}
+
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
@@ -2885,6 +2927,9 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 =

 	pr_debug("msk=3D%p", msk);
 =

+	if (mptcp_unsupported(level, optname))
+		return -ENOPROTOOPT;
+
 	if (level =3D=3D SOL_SOCKET)
 		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
 =

-- =

2.26.2

--===============4507289590110488667==--
