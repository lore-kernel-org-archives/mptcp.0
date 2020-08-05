Content-Type: multipart/mixed; boundary="===============3142034843467022377=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 07/13] mptcp: cleanup mptcp_subflow_discard_data()
Date: Wed, 05 Aug 2020 19:57:06 +0200
Message-ID: <ccec48f89fb481b9409add1bcc10c2fef8968ee9.1596649926.git.pabeni@redhat.com>
In-Reply-To: cover.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5486

--===============3142034843467022377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no need to use the tcp_read_sock(), we can
simply drop the skb. Additionally try to look at next
buffer for in order data.

This both simplify the code and avoid unneeded indirect
calls.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
RFC -> v1:
  - added changelog, continue looping on drop (Florian)
---
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  | 56 ++++++++++----------------------------------
 2 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e20154a33fa7..26f5f81f3f4c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -355,7 +355,6 @@ int mptcp_is_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-int mptcp_subflow_discard_data(struct sock *sk, unsigned limit);
 void __init mptcp_subflow_init(void);
 =

 /* called with sk socket lock held */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index db7a4c84b6da..0b42e2be44fd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -817,50 +817,20 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
 	return MAPPING_OK;
 }
 =

-static int subflow_read_actor(read_descriptor_t *desc,
-			      struct sk_buff *skb,
-			      unsigned int offset, size_t len)
+static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *s=
kb,
+				       unsigned limit)
 {
-	size_t copy_len =3D min(desc->count, len);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	bool fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
+	u32 incr;
 =

-	desc->count -=3D copy_len;
+	incr =3D limit >=3D skb->len ? skb->len + fin : limit;
 =

-	pr_debug("flushed %zu bytes, %zu left", copy_len, desc->count);
-	return copy_len;
-}
-
-int mptcp_subflow_discard_data(struct sock *ssk, unsigned limit)
-{
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
-	u32 map_remaining;
-	size_t delta;
-
-	map_remaining =3D subflow->map_data_len -
-			mptcp_subflow_get_map_offset(subflow);
-	delta =3D min_t(size_t, limit, map_remaining);
-
-	/* discard mapped data */
-	pr_debug("discarding %zu bytes, current map len=3D%d", delta,
-		 map_remaining);
-	if (delta) {
-		read_descriptor_t desc =3D {
-			.count =3D delta,
-		};
-		int ret;
-
-		ret =3D tcp_read_sock(ssk, &desc, subflow_read_actor);
-		if (ret < 0) {
-			ssk->sk_err =3D -ret;
-			return ret;
-		}
-		if (ret < delta)
-			return 0;
-		if (delta =3D=3D map_remaining) {
-			subflow->data_avail =3D 0;
-			subflow->map_valid =3D 0;
-		}
-	}
-	return 0;
+	pr_debug("discarding=3D%d len=3D%d seq=3D%d", incr, skb->len,
+		 subflow->map_subflow_seq);
+	tcp_sk(ssk)->copied_seq +=3D incr;
+	if (incr >=3D skb->len)
+		sk_eat_skb(ssk, skb);
 }
 =

 static bool subflow_check_data_avail(struct sock *ssk)
@@ -935,9 +905,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		/* only accept in-sequence mapping. Old values are spurious
 		 * retransmission
 		 */
-		if (mptcp_subflow_discard_data(ssk, old_ack - ack_seq))
-			goto fatal;
-		return false;
+		mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
 	}
 	return true;
 =

-- =

2.26.2

--===============3142034843467022377==--
