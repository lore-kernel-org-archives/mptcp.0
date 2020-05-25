Content-Type: multipart/mixed; boundary="===============6142773996452903999=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-next 2/2] mptcp: move recbuf adjustment to
 recvmsg path
Date: Mon, 25 May 2020 14:02:43 +0200
Message-ID: <20200525120243.4160-3-fw@strlen.de>
In-Reply-To: 20200525120243.4160-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4485

--===============6142773996452903999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Place receive window tuning in the recvmsg path.
This makes sure the buffer size is only changed when userspace consumes
data.

Previously we would grow sk_rcvbuf towards tcp_rmem[2], now we so only
if userspace reads data.

Furthermore, we simply track the largest receive buffer size of the
subflow, i.e. we will also reduce the size instead of only increasing
it.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 v2: new patch.
 =

 net/mptcp/protocol.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dbb86cbb9e77..2a4792cfe85e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -190,13 +190,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 		return false;
 	}
 =

-	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		int rcvbuf =3D max(ssk->sk_rcvbuf, sk->sk_rcvbuf);
-
-		if (rcvbuf > sk->sk_rcvbuf)
-			sk->sk_rcvbuf =3D rcvbuf;
-	}
-
 	tp =3D tcp_sk(ssk);
 	do {
 		u32 map_remaining, offset;
@@ -933,6 +926,22 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	return moved > 0;
 }
 =

+static void mptcp_rcv_space_adjust(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	const struct mptcp_subflow_context *subflow;
+	const struct sock *ssk;
+	int rcvbuf =3D 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk =3D mptcp_subflow_tcp_sock(subflow);
+		rcvbuf =3D max(ssk->sk_rcvbuf, rcvbuf);
+	}
+
+	if (rcvbuf)
+		sk->sk_rcvbuf =3D rcvbuf;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
@@ -962,6 +971,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 	__mptcp_flush_join_list(msk);
 =

+	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK))
+		mptcp_rcv_space_adjust(msk);
+
 	while (len > (size_t)copied) {
 		int bytes_read;
 =

@@ -975,8 +987,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 		copied +=3D bytes_read;
 =

 		if (skb_queue_empty(&sk->sk_receive_queue) &&
-		    __mptcp_move_skbs(msk))
+		    __mptcp_move_skbs(msk)) {
+			mptcp_rcv_space_adjust(msk);
 			continue;
+		}
 =

 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
-- =

2.26.2

--===============6142773996452903999==--
