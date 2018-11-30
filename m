Content-Type: multipart/mixed; boundary="===============6813555950858273990=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v4 13/17] tcp: Prevent coalesce and collapse when
 skb->priv is used
Date: Fri, 30 Nov 2018 12:11:08 -0800
Message-ID: <20181130201112.21806-14-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181130201112.21806-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 866

--===============6813555950858273990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The extended private data attached to an skb needs to be preserved as
it passes through the TCP stack. Make sure that these skbs are not
appended to others during coalesce or collapse, so the private data
remains associated with the payload of the given skb.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/tcp.h     |  6 ++++++
 net/ipv4/tcp_input.c  | 10 ++++++++--
 net/ipv4/tcp_output.c |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 1fc6362fa778..eed2f9c54d0a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -954,6 +954,12 @@ static inline bool tcp_skb_can_collapse_to(const struc=
t sk_buff *skb)
 	return likely(!TCP_SKB_CB(skb)->eor);
 }
 =

+static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
+					const struct sk_buff *from)
+{
+	return likely(tcp_skb_can_collapse_to(to) && !from->priv_used);
+}
+
 /* Events passed to congestion control interface */
 enum tcp_ca_event {
 	CA_EVENT_TX_START,	/* first transmit when no packets in flight */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 00f7a3d88d66..fca76bbaa5c1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1396,7 +1396,7 @@ static struct sk_buff *tcp_shift_skb_data(struct sock=
 *sk, struct sk_buff *skb,
 	if ((TCP_SKB_CB(prev)->sacked & TCPCB_TAGBITS) !=3D TCPCB_SACKED_ACKED)
 		goto fallback;
 =

-	if (!tcp_skb_can_collapse_to(prev))
+	if (!tcp_skb_can_collapse(prev, skb))
 		goto fallback;
 =

 	in_sack =3D !after(start_seq, TCP_SKB_CB(skb)->seq) &&
@@ -4355,6 +4355,9 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (TCP_SKB_CB(from)->seq !=3D TCP_SKB_CB(to)->end_seq)
 		return false;
 =

+	if (from->priv_used)
+		return false;
+
 #ifdef CONFIG_TLS_DEVICE
 	if (from->decrypted !=3D to->decrypted)
 		return false;
@@ -4872,10 +4875,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
 =

 		/* The first skb to collapse is:
 		 * - not SYN/FIN and
+		 * - does not use priv_data
 		 * - bloated or contains data before "start" or
 		 *   overlaps to the next one.
 		 */
 		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
+		    !skb->priv_used &&
 		    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
 		     before(TCP_SKB_CB(skb)->seq, start))) {
 			end_of_skbs =3D false;
@@ -4891,7 +4896,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *li=
st, struct rb_root *root,
 		/* Decided to skip this, advance start seq. */
 		start =3D TCP_SKB_CB(skb)->end_seq;
 	}
-	if (end_of_skbs ||
+	if (end_of_skbs || skb->priv_used ||
 	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
 		return;
 =

@@ -4934,6 +4939,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *li=
st, struct rb_root *root,
 				skb =3D tcp_collapse_one(sk, skb, list, root);
 				if (!skb ||
 				    skb =3D=3D tail ||
+				    skb->priv_used ||
 				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
 					goto end;
 #ifdef CONFIG_TLS_DEVICE
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6f723cdb5c8e..7d838ae40a9c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2883,7 +2883,7 @@ static void tcp_retrans_try_collapse(struct sock *sk,=
 struct sk_buff *to,
 		if (!tcp_can_collapse(sk, skb))
 			break;
 =

-		if (!tcp_skb_can_collapse_to(to))
+		if (!tcp_skb_can_collapse(to, skb))
 			break;
 =

 		space -=3D skb->len;
-- =

2.19.1


--===============6813555950858273990==--
