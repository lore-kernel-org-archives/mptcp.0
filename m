Content-Type: multipart/mixed; boundary="===============1946348242171147682=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1] Squash-to: "tcp: Prevent coalesce/collapse when
 skb has MPTCP extensions"
Date: Thu, 19 Dec 2019 11:40:51 +0100
Message-ID: <8d1032ab5f4006cf6554eac229596d6d4d95896f.1576752025.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3174

--===============1946348242171147682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow coalescing when mptcp extensions are equal or 'from' lacks such exten=
sions.

Note: we could be a little less restrictive allowing coalescing with
different data_ack, but this simplify the code a bit, we can improve
later and at least mptcp_net-next do not generate almost identical
DSS with different data_ack.

With the above assumption, we don't need any special action when
moving bits from skb1 to skb2, as the mapping in skb2 will already
fit, and mapping in skb1 will be dropped as/if needed.

When coalescing to a newly allocated skb, we transfer the relevant
extension to. An MPTCP specific helper is added for that goal,
possibly we could use/create a generic one.

RFC -> v1:
 - changed helpers checks as per Florian && Mat feedback
 - added comments (Florian)
 - fixed check in tcp_try_coalesce() (Mat)
 - fixed memcpy (Mat && Florian)
 - dropped now unused mptcp_skb_ext_exist()
 - move the mptcp_skb_can_collapse() into the 2nd group of checks in
   tcp_coalese()

This latter point is somewhat relevant. An unpatched kernel allows
collapsing a single skb with 'old' bits (seq lower than 'start'). Than
really means shrink a bit the current skb, possibly without any fourther
action. This change preserve this behavior, but add the restriction to
respect MPTCP coalescing test when trying to collapsing to the next one.
Overall consequences are not 110% clear to me!

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/mptcp.h  | 45 ++++++++++++++++++++++++++++++++++++++++----
 include/net/tcp.h    |  2 +-
 net/ipv4/tcp_input.c | 13 ++++++-------
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 43ddfdf9e4a3..f0b8ee40fe5a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -27,16 +27,53 @@ struct mptcp_ext {
 =

 #ifdef CONFIG_MPTCP
 =

-static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
+/* move the skb extension owership, with the assumption that 'to' is
+ * newly allocated and 'from' carries only MPTCP ext
+ */
+static inline void mptcp_skb_ext_move(struct sk_buff *to,
+				      struct sk_buff *from)
+{
+	if (WARN_ON_ONCE(to->active_extensions))
+		skb_ext_put(to);
+	WARN_ON_ONCE(from->active_extensions & ~(1 << SKB_EXT_MPTCP));
+
+	to->active_extensions =3D from->active_extensions;
+	to->extensions =3D from->extensions;
+	from->extensions =3D NULL;
+	from->active_extensions =3D 0;
+}
+
+static inline bool mptcp_ext_matches(const struct mptcp_ext *to_ext,
+				     const struct mptcp_ext *from_ext)
+{
+	return to_ext =3D=3D from_ext ||
+	       (to_ext && from_ext &&
+	        !memcmp(from_ext, to_ext, sizeof(struct mptcp_ext)));
+}
+
+/* check if skbs can be collapsed.
+ * MPTCP collapse is allowed if neither @to or @from carry an mptcp data
+ * mapping, or if the extension of @to is the same as @from.
+ * Collapsing is not possible if @to lacks an extension, but @from carries=
 one.
+ */
+static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
+					  const struct sk_buff *from)
 {
-	return skb_ext_exist(skb, SKB_EXT_MPTCP);
+	return mptcp_ext_matches(skb_ext_find(to, SKB_EXT_MPTCP),
+				 skb_ext_find(from, SKB_EXT_MPTCP));
 }
 =

 #else
 =

-static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
+static inline void mptcp_skb_ext_move(struct sk_buff *to,
+				      const struct sk_buff *from)
+{
+}
+
+static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
+					  const struct sk_buff *from)
 {
-	return false;
+	return true;
 }
 =

 #endif /* CONFIG_MPTCP */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index c483c73b8d41..f4cddd42d52a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -983,7 +983,7 @@ static inline bool tcp_skb_can_collapse(const struct sk=
_buff *to,
 					const struct sk_buff *from)
 {
 	return likely(tcp_skb_can_collapse_to(to) &&
-		      !mptcp_skb_ext_exist(from));
+		      mptcp_skb_can_collapse(to, from));
 }
 =

 /* Events passed to congestion control interface */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 55b460a2ece2..a16d9f2a0529 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4420,7 +4420,7 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (TCP_SKB_CB(from)->seq !=3D TCP_SKB_CB(to)->end_seq)
 		return false;
 =

-	if (mptcp_skb_ext_exist(from))
+	if (!mptcp_skb_can_collapse(to, from))
 		return false;
 =

 #ifdef CONFIG_TLS_DEVICE
@@ -4931,19 +4931,17 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
 =

 		/* The first skb to collapse is:
 		 * - not SYN/FIN and
-		 * - does not include a MPTCP skb extension
 		 * - bloated or contains data before "start" or
-		 *   overlaps to the next one.
+		 *   overlaps to the next one and mptcp allow collapsing.
 		 */
 		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
-		    !mptcp_skb_ext_exist(skb) &&
 		    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
 		     before(TCP_SKB_CB(skb)->seq, start))) {
 			end_of_skbs =3D false;
 			break;
 		}
 =

-		if (n && n !=3D tail &&
+		if (n && n !=3D tail && mptcp_skb_can_collapse(skb, n) &&
 		    TCP_SKB_CB(skb)->end_seq !=3D TCP_SKB_CB(n)->seq) {
 			end_of_skbs =3D false;
 			break;
@@ -4952,7 +4950,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *li=
st, struct rb_root *root,
 		/* Decided to skip this, advance start seq. */
 		start =3D TCP_SKB_CB(skb)->end_seq;
 	}
-	if (end_of_skbs || mptcp_skb_ext_exist(skb) ||
+	if (end_of_skbs ||
 	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
 		return;
 =

@@ -4976,6 +4974,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *li=
st, struct rb_root *root,
 		else
 			__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
 		skb_set_owner_r(nskb, sk);
+		mptcp_skb_ext_move(nskb, skb);
 =

 		/* Copy data, releasing collapsed skbs. */
 		while (copy > 0) {
@@ -4995,7 +4994,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *li=
st, struct rb_root *root,
 				skb =3D tcp_collapse_one(sk, skb, list, root);
 				if (!skb ||
 				    skb =3D=3D tail ||
-				    mptcp_skb_ext_exist(skb) ||
+				    !mptcp_skb_can_collapse(nskb, skb) ||
 				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
 					goto end;
 #ifdef CONFIG_TLS_DEVICE
-- =

2.21.0

--===============1946348242171147682==--
