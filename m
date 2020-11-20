Content-Type: multipart/mixed; boundary="===============1191395109793047925=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: let MPTCP create max size skbs
Date: Fri, 20 Nov 2020 18:41:59 +0100
Message-ID: <9306e757475c64266b17c45b71a6dcac43d09ec2.1605894104.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6883

--===============1191395109793047925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the xmit path of the MPTCP protocol creates smaller-
than-max-size skbs, which is suboptimal for the performances.

There are a few things to improve:
- when coalescing to an existing skb, must clear the PUSH flag
- tcp_build_frag() expect the available space as an argument.
  When coalescing is enable MPTCP already subtracted the
  to-be-coalesced skb len. We must increment said argument
  accordingly.
- when a skb is split by the TCP stack we froze the MPTCP map,
  to avoid changing an already transmitted DSS due to skb
  collapsing on xmit. We actually need to froze only the first
  half of the map, and can keep collapsing on the 2nd half

Before:
./use_mptcp.sh netperf -H 127.0.0.1 -t TCP_STREAM
[...]
131072  16384  16384    30.00    24414.86

After:
./use_mptcp.sh netperf -H 127.0.0.1 -t TCP_STREAM
[...]
131072  16384  16384    30.05    28357.69

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
use_mptcp.sh forces exiting app to create MPTCP instead of TCP
ones via LD_PRELOAD of crafter socket() implementation.

https://github.com/pabeni/mptcp-tools/tree/master/use_mptcp
---
 include/net/mptcp.h   | 25 +++++++++++++++++++++++++
 net/ipv4/tcp_output.c |  4 ++--
 net/mptcp/protocol.c  | 14 +++++++++-----
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 5694370be3d4..ead867e008d2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -122,6 +122,31 @@ static inline void mptcp_skb_ext_copy(struct sk_buff *=
to,
 	skb_ext_copy(to, from);
 }
 =

+static inline void mptcp_skb_split(struct sk_buff *from,
+				   struct sk_buff *to)
+{
+	struct mptcp_ext *from_ext, *to_ext;
+
+	from_ext =3D skb_ext_find(from, SKB_EXT_MPTCP);
+	if (!from_ext)
+		return;
+
+	/* if we can't allocate new ext for the 2nd half no action is needed:
+	 * 2nd hald will be covered by the existing mapping and coalescing
+	 * will be prevented
+	 */
+	to_ext =3D skb_ext_add(to, SKB_EXT_MPTCP);
+	if (!to_ext)
+		return;
+
+	memcpy(to_ext, from_ext, sizeof(struct mptcp_ext));
+	from_ext->frozen =3D 1;
+	from_ext->data_len -=3D to->len;
+	to_ext->data_len =3D to->len;
+	to_ext->data_seq +=3D from->len;
+	to_ext->subflow_seq +=3D from->len;
+}
+
 static inline bool mptcp_ext_matches(const struct mptcp_ext *to_ext,
 				     const struct mptcp_ext *from_ext)
 {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 41880d3521ed..7e6441921848 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1570,7 +1570,6 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_=
queue,
 	if (!buff)
 		return -ENOMEM; /* We'll just try again later. */
 	skb_copy_decrypted(buff, skb);
-	mptcp_skb_ext_copy(buff, skb);
 =

 	sk_wmem_queued_add(sk, buff->truesize);
 	sk_mem_charge(sk, buff->truesize);
@@ -1591,6 +1590,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_=
queue,
 	tcp_skb_fragment_eor(skb, buff);
 =

 	skb_split(skb, buff, len);
+	mptcp_skb_split(skb, buff);
 =

 	buff->ip_summed =3D CHECKSUM_PARTIAL;
 =

@@ -2125,7 +2125,6 @@ static int tso_fragment(struct sock *sk, struct sk_bu=
ff *skb, unsigned int len,
 	if (unlikely(!buff))
 		return -ENOMEM;
 	skb_copy_decrypted(buff, skb);
-	mptcp_skb_ext_copy(buff, skb);
 =

 	sk_wmem_queued_add(sk, buff->truesize);
 	sk_mem_charge(sk, buff->truesize);
@@ -2149,6 +2148,7 @@ static int tso_fragment(struct sock *sk, struct sk_bu=
ff *skb, unsigned int len,
 =

 	buff->ip_summed =3D CHECKSUM_PARTIAL;
 	skb_split(skb, buff, len);
+	mptcp_skb_split(skb, buff);
 	tcp_fragment_tstamp(skb, buff);
 =

 	/* Fix up tso_factor for both original and new SKB.  */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 69441ea71411..2a2986141422 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1223,6 +1223,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	struct mptcp_ext *mpext =3D NULL;
 	struct sk_buff *skb, *tail;
 	bool can_collapse =3D false;
+	int size_bias =3D 0;
 	int avail_size;
 	size_t ret =3D 0;
 =

@@ -1244,10 +1245,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
 		mpext =3D skb_ext_find(skb, SKB_EXT_MPTCP);
 		can_collapse =3D (info->size_goal - skb->len > 0) &&
 			 mptcp_skb_can_collapse_to(data_seq, skb, mpext);
-		if (!can_collapse)
+		if (!can_collapse) {
 			TCP_SKB_CB(skb)->eor =3D 1;
-		else
+		} else {
+			size_bias =3D skb->len;
 			avail_size =3D info->size_goal - skb->len;
+		}
 	}
 =

 	/* Zero window and all data acked? Probe. */
@@ -1267,8 +1270,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		return 0;
 =

 	ret =3D info->limit - info->sent;
-	tail =3D tcp_build_frag(ssk, avail_size, info->flags, dfrag->page,
-			      dfrag->offset + info->sent, &ret);
+	tail =3D tcp_build_frag(ssk, avail_size + size_bias, info->flags,
+			      dfrag->page, dfrag->offset + info->sent, &ret);
 	if (!tail) {
 		tcp_remove_empty_skb(sk, tcp_write_queue_tail(ssk));
 		return -ENOMEM;
@@ -1277,8 +1280,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	/* if the tail skb is still the cached one, collapsing really happened.
 	 */
 	if (skb =3D=3D tail) {
-		WARN_ON_ONCE(!can_collapse);
+		TCP_SKB_CB(tail)->tcp_flags &=3D ~TCPHDR_PSH;
 		mpext->data_len +=3D ret;
+		WARN_ON_ONCE(!can_collapse);
 		WARN_ON_ONCE(zero_window_probe);
 		goto out;
 	}
-- =

2.26.2

--===============1191395109793047925==--
