Content-Type: multipart/mixed; boundary="===============2748152321813963131=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 02/12] mptcp: set data_ready status bit in
 subflow_check_data_avail()
Date: Fri, 31 Jul 2020 19:39:17 +0200
Message-ID: <e75c80fd5ff91ff1ec763dbe5b2d3374a0a67766.1596216310.git.pabeni@redhat.com>
In-Reply-To: cover.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5409

--===============2748152321813963131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This simplify mptcp_subflow_data_available() and will
made follow-up patches simpler.

Additionally remove the unneeded checks on subflow copied_seq:
we always whole skbs out of subflows.

Signed-off-by Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bd2201d62ae6..54d89f9379e1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -755,6 +755,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 =

 	pr_debug("msk=3D%p ssk=3D%p data_avail=3D%d skb=3D%p", subflow->conn, ssk,
 		 subflow->data_avail, skb_peek(&ssk->sk_receive_queue));
+	if (!skb_peek(&ssk->sk_receive_queue))
+		subflow->data_avail =3D 0;
 	if (subflow->data_avail)
 		return true;
 =

@@ -779,6 +781,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			subflow->map_data_len =3D skb->len;
 			subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq -
 						   subflow->ssn_offset;
+			subflow->data_avail =3D 1;
 			return true;
 		}
 =

@@ -806,8 +809,10 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
 		pr_debug("msk ack_seq=3D%llx subflow ack_seq=3D%llx", old_ack,
 			 ack_seq);
-		if (ack_seq =3D=3D old_ack)
+		if (ack_seq =3D=3D old_ack) {
+			subflow->data_avail =3D 1;
 			break;
+		}
 =

 		/* only accept in-sequence mapping. Old values are spurious
 		 * retransmission; we can hit "future" values on active backup
@@ -852,13 +857,13 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	ssk->sk_error_report(ssk);
 	tcp_set_state(ssk, TCP_CLOSE);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
+	subflow->data_avail =3D 0;
 	return false;
 }
 =

 bool mptcp_subflow_data_available(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	struct sk_buff *skb;
 =

 	/* check if current mapping is still valid */
 	if (subflow->map_valid &&
@@ -871,15 +876,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 			 subflow->map_data_len);
 	}
 =

-	if (!subflow_check_data_avail(sk)) {
-		subflow->data_avail =3D 0;
-		return false;
-	}
-
-	skb =3D skb_peek(&sk->sk_receive_queue);
-	subflow->data_avail =3D skb &&
-		       before(tcp_sk(sk)->copied_seq, TCP_SKB_CB(skb)->end_seq);
-	return subflow->data_avail;
+	return subflow_check_data_avail(sk);
 }
 =

 /* If ssk has an mptcp parent socket, use the mptcp rcvbuf occupancy,
-- =

2.26.2

--===============2748152321813963131==--
