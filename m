Content-Type: multipart/mixed; boundary="===============3700208305269095828=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 4/7] mptcp: add rmem queue accounting
Date: Tue, 25 Feb 2020 18:16:56 +0100
Message-ID: <20200225171659.4807-5-fw@strlen.de>
In-Reply-To: 20200225171659.4807-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3796

--===============3700208305269095828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If userspace never drains the receive buffers we must stop draining
the subflow socket(s) at some point.

This adds the needed rmem accouting for this.
If the threshold is reached, we stop draining the subflows.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b4a8517d8eac..381d5647a95b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -124,7 +124,7 @@ static void __mptcp_move_skb(struct mptcp_sock *msk, st=
ruct sock *ssk,
 	struct sock *sk =3D (struct sock *)msk;
 =

 	__skb_unlink(skb, &ssk->sk_receive_queue);
-	skb_orphan(skb);
+	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 =

 	msk->ack_seq +=3D copy_len;
@@ -136,10 +136,16 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
 					   unsigned int *bytes)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	struct sock *sk =3D (struct sock *)msk;
 	unsigned int moved =3D 0;
 	bool more_data_avail;
 	struct tcp_sock *tp;
 	bool done =3D false;
+	int rcvbuf;
+
+	rcvbuf =3D max(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+	if (rcvbuf > sk->sk_rcvbuf)
+		sk->sk_rcvbuf =3D rcvbuf;
 =

 	tp =3D tcp_sk(ssk);
 	do {
@@ -183,6 +189,11 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 =

 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail =3D mptcp_subflow_data_available(ssk);
+
+		if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf)) {
+			done =3D true;
+			break;
+		}
 	} while (more_data_avail);
 =

 	*bytes =3D moved;
@@ -196,9 +207,14 @@ void mptcp_data_ready(struct sock *sk)
 =

 	set_bit(MPTCP_DATA_READY, &msk->flags);
 =

+	/* don't schedule if mptcp sk is (still) over limit */
+	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
+		goto wake;
+
 	if (schedule_work(&msk->work))
 		sock_hold((struct sock *)msk);
 =

+wake:
 	sk->sk_data_ready(sk);
 }
 =

-- =

2.24.1

--===============3700208305269095828==--
