Content-Type: multipart/mixed; boundary="===============7917378970434925647=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 07/12] mptcp: cleanup mptcp_subflow_discard_data()
Date: Fri, 31 Jul 2020 19:39:22 +0200
Message-ID: <915cf19849b12e6bd8deabbb406be51eff92c764.1596216310.git.pabeni@redhat.com>
In-Reply-To: cover.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5413

--===============7917378970434925647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  | 53 ++++++++++----------------------------------
 2 files changed, 12 insertions(+), 42 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2b93c2c56316..dfcd7eab35ad 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -352,7 +352,6 @@ int mptcp_is_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-int mptcp_subflow_discard_data(struct sock *sk, unsigned limit);
 void __init mptcp_subflow_init(void);
 =

 /* called with sk socket lock held */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b926f4f4fb9f..b2bde12b5933 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -735,49 +735,20 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
 	return MAPPING_OK;
 }
 =

-static int subflow_read_actor(read_descriptor_t *desc,
-			      struct sk_buff *skb,
-			      unsigned int offset, size_t len)
+static int mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *sk=
b,
+				      unsigned limit)
 {
-	size_t copy_len =3D min(desc->count, len);
-
-	desc->count -=3D copy_len;
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	bool fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
+	u32 incr;
 =

-	pr_debug("flushed %zu bytes, %zu left", copy_len, desc->count);
-	return copy_len;
-}
+	incr =3D limit >=3D skb->len ? skb->len + fin : limit;
 =

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
+	pr_debug("discarding=3D%d len=3D%d seq=3D%d", incr, skb->len,
+		 subflow->map_subflow_seq);
+	tcp_sk(ssk)->copied_seq +=3D incr;
+	if (incr >=3D skb->len)
+		sk_eat_skb(ssk, skb);
 	return 0;
 }
 =

@@ -853,7 +824,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		/* only accept in-sequence mapping. Old values are spurious
 		 * retransmission
 		 */
-		if (mptcp_subflow_discard_data(ssk, old_ack - ack_seq))
+		if (mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq))
 			goto fatal;
 		return false;
 	}
-- =

2.26.2

--===============7917378970434925647==--
