Content-Type: multipart/mixed; boundary="===============2485175931795397589=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 7/8] mptcp: add mptcp_release_cb skeleton
Date: Tue, 25 Feb 2020 13:05:25 +0100
Message-ID: <20200225120526.2866-8-fw@strlen.de>
In-Reply-To: 20200225120526.2866-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3777

--===============2485175931795397589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

It will be used to check if we still have a subflow with pending data.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c28c5cc49d65..de6bd9d28116 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -940,6 +940,25 @@ static int mptcp_getsockopt(struct sock *sk, int level=
, int optname,
 	return -EOPNOTSUPP;
 }
 =

+#define MPTCP_DEFERRED_ALL TCPF_DELACK_TIMER_DEFERRED
+
+/* this is very alike tcp_release_cb() but we must handle differently a
+ * different set of events
+ */
+static void mptcp_release_cb(struct sock *sk)
+{
+	unsigned long flags, nflags;
+
+	do {
+		flags =3D sk->sk_tsq_flags;
+		if (!(flags & MPTCP_DEFERRED_ALL))
+			return;
+		nflags =3D flags & ~MPTCP_DEFERRED_ALL;
+	} while (cmpxchg(&sk->sk_tsq_flags, flags, nflags) !=3D flags);
+
+	sock_release_ownership(sk);
+}
+
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -1015,6 +1034,7 @@ static struct proto mptcp_prot =3D {
 	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
+	.release_cb	=3D mptcp_release_cb,
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
 	.get_port	=3D mptcp_get_port,
-- =

2.24.1

--===============2485175931795397589==--
