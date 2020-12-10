Content-Type: multipart/mixed; boundary="===============0054871458021717850=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 9/9] mptcp: let MPTCP create max size skbs
Date: Thu, 10 Dec 2020 14:25:06 -0800
Message-ID: <20201210222506.222251-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201210222506.222251-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7135

--===============0054871458021717850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Currently the xmit path of the MPTCP protocol creates smaller-
than-max-size skbs, which is suboptimal for the performances.

There are a few things to improve:
- when coalescing to an existing skb, must clear the PUSH flag
- tcp_build_frag() expect the available space as an argument.
  When coalescing is enable MPTCP already subtracted the
  to-be-coalesced skb len. We must increment said argument
  accordingly.

Before:
./use_mptcp.sh netperf -H 127.0.0.1 -t TCP_STREAM
[...]
131072  16384  16384    30.00    24414.86

After:
./use_mptcp.sh netperf -H 127.0.0.1 -t TCP_STREAM
[...]
131072  16384  16384    30.05    28357.69

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cb8b7adf218a..b812aaae8044 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1256,6 +1256,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	struct mptcp_ext *mpext =3D NULL;
 	struct sk_buff *skb, *tail;
 	bool can_collapse =3D false;
+	int size_bias =3D 0;
 	int avail_size;
 	size_t ret =3D 0;
 =

@@ -1277,10 +1278,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
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
@@ -1300,8 +1303,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
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
@@ -1310,8 +1313,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
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

2.29.2

--===============0054871458021717850==--
