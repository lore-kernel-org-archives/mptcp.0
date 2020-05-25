Content-Type: multipart/mixed; boundary="===============0517387958821703009=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 mptcp-next 2/2] mptcp: move recbuf adjustment to
 recvmsg path
Date: Mon, 25 May 2020 18:15:47 +0200
Message-ID: <20200525161547.24591-2-fw@strlen.de>
In-Reply-To: 20200525161547.24591-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4490

--===============0517387958821703009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Place receive window tuning in the recvmsg path.
This makes sure the size is only increased when userspace consumes data.

Previously we would grow the sk receive buffer towards tcp_rmem[2], now we
so only if userspace reads data.

Simply adjust the msk rcvbuf size to the largest receive buffer of any of
the existing subflows.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 changes in v3:
  - xmas tree fmt
  - move SOC_RCVBUF_LOCK test into mptcp_rcv_space_adjust()

 net/mptcp/protocol.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dbb86cbb9e77..89a35c3fc499 100644
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
@@ -933,6 +926,25 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	return moved > 0;
 }
 =

+static void mptcp_rcv_space_adjust(struct mptcp_sock *msk)
+{
+	const struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	const struct sock *ssk;
+	int rcvbuf =3D 0;
+
+	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
+		return;
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
@@ -962,6 +974,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 	__mptcp_flush_join_list(msk);
 =

+	mptcp_rcv_space_adjust(msk);
+
 	while (len > (size_t)copied) {
 		int bytes_read;
 =

@@ -975,8 +989,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
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

--===============0517387958821703009==--
