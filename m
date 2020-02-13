Content-Type: multipart/mixed; boundary="===============7867086733051701033=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 5/5] mptcp: add rmem queue accounting
Date: Thu, 13 Feb 2020 11:27:42 +0100
Message-ID: <20200213102742.18937-6-fw@strlen.de>
In-Reply-To: 20200213102742.18937-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3648

--===============7867086733051701033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e9e87e62a184..0583429b36ac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -172,6 +172,10 @@ void mptcp_data_ready(struct sock *sk)
 	if (test_and_set_bit(MPTCP_WORK_DATA_READY, &msk->flags))
 		return;
 =

+	/* don't schedule if mptcp sk is (still) over limit */
+	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+		return;
+
 	sock_hold(sk);
 	if (!schedule_work(&msk->rtx_work))
 		sock_put(sk);
@@ -993,12 +997,20 @@ static int mptcp_steal_actor(read_descriptor_t *desc,=
 struct sk_buff *skb,
 	sk =3D (struct sock *)arg->msk;
 	ssk =3D arg->ssk;
 =

+	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
+	    !sk_rmem_schedule(sk, skb, skb->truesize)) {
+		if (ssk->sk_rcvbuf <=3D sk->sk_rcvbuf)
+			return 0;
+
+		sk->sk_rcvbuf =3D ssk->sk_rcvbuf;
+	}
+
 	/* skb_orphan is not good (should keep skb charged to subflow).
 	 * Removing it causes WARN at ssk close time, as tcp_done() call
 	 * path may see ssk->sk_forward_alloc > 0.
 	 */
 	__skb_unlink(skb, &ssk->sk_receive_queue);
-	skb_orphan(skb);
+	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 =

 	arg->msk->ack_seq +=3D copy_len;
-- =

2.24.1

--===============7867086733051701033==--
