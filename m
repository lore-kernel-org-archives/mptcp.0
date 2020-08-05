Content-Type: multipart/mixed; boundary="===============7728889417156857022=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 02/13] mptcp: set data_ready status bit in
 subflow_check_data_avail()
Date: Wed, 05 Aug 2020 19:57:01 +0200
Message-ID: <fd675d5c4a94dae12138987d5d0e3e0b4ab390c2.1596649926.git.pabeni@redhat.com>
In-Reply-To: cover.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5481

--===============7728889417156857022==
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
index c2f21471659f..22621172f36f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -837,6 +837,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 =

 	pr_debug("msk=3D%p ssk=3D%p data_avail=3D%d skb=3D%p", subflow->conn, ssk,
 		 subflow->data_avail, skb_peek(&ssk->sk_receive_queue));
+	if (!skb_peek(&ssk->sk_receive_queue))
+		subflow->data_avail =3D 0;
 	if (subflow->data_avail)
 		return true;
 =

@@ -861,6 +863,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			subflow->map_data_len =3D skb->len;
 			subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq -
 						   subflow->ssn_offset;
+			subflow->data_avail =3D 1;
 			return true;
 		}
 =

@@ -888,8 +891,10 @@ static bool subflow_check_data_avail(struct sock *ssk)
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
@@ -934,13 +939,13 @@ static bool subflow_check_data_avail(struct sock *ssk)
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
@@ -953,15 +958,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
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

--===============7728889417156857022==--
