Content-Type: multipart/mixed; boundary="===============5029713993514806155=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] tcp: propagate MPTCP skb extensions on xmit
 splits
Date: Mon, 31 Aug 2020 16:36:06 +0200
Message-ID: <4154a08c6bc2267475916ae189a396793e1e74f8.1598877921.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5674

--===============5029713993514806155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the TCP stack splits a packet on the write queue, the tail
half currently lose the associated skb extensions, and will not
carry the DSM on the wire.

The above does not cause functional problems and is allowed by
the RFC, but interact badly with GRO and RX coalescing, as possible
candidates for aggregation will carry different TCP options.

This change tries to improve the MPTCP behavior, propagating the
skb estensions on split.

Additionally, we must prevent the MPTCP stack from updating the
mapping after the split occour: that will both violate the RFC and
fool the reader.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/mptcp.h   | 21 ++++++++++++++++++++-
 net/ipv4/tcp_output.c |  3 +++
 net/mptcp/protocol.c  |  7 +++++--
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3525d2822abe..fbf0849632cb 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -29,7 +29,8 @@ struct mptcp_ext {
 			use_ack:1,
 			ack64:1,
 			mpc_map:1,
-			__unused:2;
+			frozen:1,
+			__unused:1;
 	/* one byte hole */
 };
 =

@@ -107,6 +108,19 @@ static inline void mptcp_skb_ext_move(struct sk_buff *=
to,
 	from->active_extensions =3D 0;
 }
 =

+static inline void mptcp_skb_ext_copy(struct sk_buff *to,
+				      struct sk_buff *from)
+{
+	struct mptcp_ext *from_ext;
+
+	from_ext =3D skb_ext_find(from, SKB_EXT_MPTCP);
+	if (!from_ext)
+		return;
+
+	skb_ext_copy(to, from);
+	from_ext->frozen =3D 1;
+}
+
 static inline bool mptcp_ext_matches(const struct mptcp_ext *to_ext,
 				     const struct mptcp_ext *from_ext)
 {
@@ -195,6 +209,11 @@ static inline void mptcp_skb_ext_move(struct sk_buff *=
to,
 {
 }
 =

+static inline void mptcp_skb_ext_copy(struct sk_buff *to,
+				      struct sk_buff *from)
+{
+}
+
 static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
 					  const struct sk_buff *from)
 {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 85ff417bda7f..c66f5bd5f64f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1411,6 +1411,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_=
queue,
 	if (!buff)
 		return -ENOMEM; /* We'll just try again later. */
 	skb_copy_decrypted(buff, skb);
+	mptcp_skb_ext_copy(buff, skb);
 =

 	sk_wmem_queued_add(sk, buff->truesize);
 	sk_mem_charge(sk, buff->truesize);
@@ -1966,6 +1967,7 @@ static int tso_fragment(struct sock *sk, struct sk_bu=
ff *skb, unsigned int len,
 	if (unlikely(!buff))
 		return -ENOMEM;
 	skb_copy_decrypted(buff, skb);
+	mptcp_skb_ext_copy(buff, skb);
 =

 	sk_wmem_queued_add(sk, buff->truesize);
 	sk_mem_charge(sk, buff->truesize);
@@ -2236,6 +2238,7 @@ static int tcp_mtu_probe(struct sock *sk)
 =

 	skb =3D tcp_send_head(sk);
 	skb_copy_decrypted(nskb, skb);
+	mptcp_skb_ext_copy(nskb, skb);
 =

 	TCP_SKB_CB(nskb)->seq =3D TCP_SKB_CB(skb)->seq;
 	TCP_SKB_CB(nskb)->end_seq =3D TCP_SKB_CB(skb)->seq + probe_size;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1fd80f8c7baa..198dcd7b2bd6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -752,8 +752,11 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
 	if (!tcp_skb_can_collapse_to(skb))
 		return false;
 =

-	/* can collapse only if MPTCP level sequence is in order */
-	return mpext && mpext->data_seq + mpext->data_len =3D=3D write_seq;
+	/* can collapse only if MPTCP level sequence is in order and this
+	 * mapping has not been xmitted yet
+	 */
+	return mpext && mpext->data_seq + mpext->data_len =3D=3D write_seq &&
+	       !mpext->frozen;
 }
 =

 static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
-- =

2.26.2

--===============5029713993514806155==--
