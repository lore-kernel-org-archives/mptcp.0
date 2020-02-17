Content-Type: multipart/mixed; boundary="===============1033767641317618573=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 3/6] mptcp: add rmem queue accounting
Date: Mon, 17 Feb 2020 16:00:58 +0100
Message-ID: <20200217150101.13603-4-fw@strlen.de>
In-Reply-To: 20200217150101.13603-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3672

--===============1033767641317618573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2: adjust rcvbuf outside of loop.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 28fc28b7e9cf..df8a9dd84b6a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -172,6 +172,10 @@ void mptcp_data_ready(struct sock *sk)
 	if (test_and_set_bit(MPTCP_WORK_DATA_READY, &msk->flags))
 		return;
 =

+	/* don't schedule if mptcp sk is (still) over limit */
+	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
+		return;
+
 	sock_hold(sk);
 	if (!schedule_work(&msk->rtx_work))
 		sock_put(sk);
@@ -699,7 +703,7 @@ static void __mptcp_move_skb(struct mptcp_sock *msk, st=
ruct sock *ssk,
 	struct sock *sk =3D (struct sock *)msk;
 =

 	__skb_unlink(skb, &ssk->sk_receive_queue);
-	skb_orphan(skb);
+	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 =

 	msk->ack_seq +=3D copy_len;
@@ -717,6 +721,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 		struct sock *ssk;
 		bool more_data_avail;
 		struct tcp_sock *tp;
+		int rcvbuf;
 =

 		ssk =3D mptcp_subflow_recv_lookup(msk);
 		if (!ssk)
@@ -726,6 +731,10 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 =

 		lock_sock(ssk);
 =

+		rcvbuf =3D max(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+		if (rcvbuf > sk->sk_rcvbuf)
+			sk->sk_rcvbuf =3D rcvbuf;
+
 		tp =3D tcp_sk(ssk);
 		do {
 			u32 map_remaining, offset;
@@ -741,6 +750,11 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 			if (!skb)
 				break;
 =

+			if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
+				done =3D true;
+				break;
+			}
+
 			offset =3D seq - TCP_SKB_CB(skb)->seq;
 			fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
 			if (fin) {
-- =

2.24.1

--===============1033767641317618573==--
