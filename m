Content-Type: multipart/mixed; boundary="===============8917349901388174199=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 03/12] mptcp: Use correct tcp_queue when calling
 mptcp_fragment
Date: Mon, 26 Mar 2018 09:32:06 +0200
Message-ID: <20180326073215.83607-4-cpaasch@apple.com>
In-Reply-To: 20180326073215.83607-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 410

--===============8917349901388174199==
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
---
 net/mptcp/mptcp_output.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 43a21f66ac34..fc950a98ce31 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -607,7 +607,10 @@ static int mptcp_fragment(struct sock *meta_sk, enum t=
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
@@ -740,6 +743,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 =

 	while ((skb =3D mpcb->sched_ops->next_segment(meta_sk, &reinject, &subsk,
 						    &sublimit))) {
+		enum tcp_queue tcp_queue =3D TCP_FRAG_IN_WRITE_QUEUE;
 		unsigned int limit;
 =

 		WARN(TCP_SKB_CB(skb)->sacked, "sacked: %u reinject: %u",
@@ -755,6 +759,8 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 				__kfree_skb(skb);
 				continue;
 			}
+		} else if (reinject =3D=3D -1) {
+			tcp_queue =3D TCP_FRAG_IN_RTX_QUEUE;
 		}
 =

 		/* If the segment was cloned (e.g. a meta retransmission),
@@ -817,7 +823,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 			limit =3D min(limit, sublimit);
 =

 		if (skb->len > limit &&
-		    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE,
+		    unlikely(mptcp_fragment(meta_sk, tcp_queue,
 					    skb, limit, gfp, reinject)))
 			break;
 =

@@ -1545,7 +1551,7 @@ int mptcp_retransmit_skb(struct sock *meta_sk, struct=
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


--===============8917349901388174199==--
