Content-Type: multipart/mixed; boundary="===============1404746517311285243=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 03/20] mptcp: Use correct tcp_queue when calling
 mptcp_fragment
Date: Fri, 14 Sep 2018 10:25:07 -0700
Message-ID: <20180914172524.67961-6-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 736

--===============1404746517311285243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The skb may come from the write-queue, the rtx-queue or the reinject
queue.

When it comes from the rtx-queue, we need to give mptcp_fragment the
right tcp_queue.

To handle the case when it comes from the reinject-queue, I will post a
follow-up patch as this seems to be a bug in the stable release as well.

Fixes: 8a1051d977cf ("Merge tag 'v4.15' into mptcp_trunk")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit edf4b8133e304238b1812c147455f65b2c15c436)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_output.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 293999037f4c..d50e49278e0d 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -578,6 +578,11 @@ static bool mptcp_skb_entail(struct sock *sk, struct s=
k_buff *skb, int reinject)
 =

 /* Fragment an skb and update the mptcp meta-data. Due to reinject, we
  * might need to undo some operations done by tcp_fragment.
+ *
+ * Be careful, the skb may come from 3 different places:
+ * - The send-queue (tcp_queue =3D=3D TCP_FRAG_IN_WRITE_QUEUE)
+ * - The retransmit-queue (tcp_queue =3D=3D TCP_FRAG_IN_RTX_QUEUE)
+ * - The reinject-queue (reinject =3D=3D -1)
  */
 static int mptcp_fragment(struct sock *meta_sk, enum tcp_queue tcp_queue,
 			  struct sk_buff *skb, u32 len,
@@ -602,7 +607,10 @@ static int mptcp_fragment(struct sock *meta_sk, enum t=
cp_queue tcp_queue,
 	if (ret)
 		return ret;
 =

-	buff =3D skb->next;
+	if (tcp_queue =3D=3D TCP_FRAG_IN_WRITE_QUEUE)
+		buff =3D skb->next;
+	else
+		buff =3D skb_rb_next(skb);
 =

 	flags =3D TCP_SKB_CB(skb)->mptcp_flags;
 	TCP_SKB_CB(skb)->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
@@ -735,6 +743,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 =

 	while ((skb =3D mpcb->sched_ops->next_segment(meta_sk, &reinject, &subsk,
 						    &sublimit))) {
+		enum tcp_queue tcp_queue =3D TCP_FRAG_IN_WRITE_QUEUE;
 		unsigned int limit;
 =

 		WARN(TCP_SKB_CB(skb)->sacked, "sacked: %u reinject: %u",
@@ -750,6 +759,8 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 				__kfree_skb(skb);
 				continue;
 			}
+		} else if (reinject =3D=3D -1) {
+			tcp_queue =3D TCP_FRAG_IN_RTX_QUEUE;
 		}
 =

 		/* If the segment was cloned (e.g. a meta retransmission),
@@ -812,7 +823,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 			limit =3D min(limit, sublimit);
 =

 		if (skb->len > limit &&
-		    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE,
+		    unlikely(mptcp_fragment(meta_sk, tcp_queue,
 					    skb, limit, gfp, reinject)))
 			break;
 =

@@ -1540,7 +1551,7 @@ int mptcp_retransmit_skb(struct sock *meta_sk, struct=
 sk_buff *skb)
 					    TCP_NAGLE_OFF);
 =

 	if (skb->len > limit &&
-	    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE, skb,
+	    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_RTX_QUEUE, skb,
 				    limit, GFP_ATOMIC, 0)))
 		goto failed;
 =

-- =

2.16.2


--===============1404746517311285243==--
