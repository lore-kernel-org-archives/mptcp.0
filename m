Content-Type: multipart/mixed; boundary="===============8502714107985093182=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v5 13/17] tcp: Prevent coalesce and collapse when
 skb->priv is used
Date: Fri, 14 Dec 2018 14:27:11 -0800
Message-ID: <20181214222715.23766-14-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181214222715.23766-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 914

--===============8502714107985093182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The extended private data attached to an skb needs to be preserved as
it passes through the TCP stack. Make sure that these skbs are not
appended to others during coalesce or collapse, so the private data
remains associated with the payload of the given skb.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/mptcp.h   | 12 ++++++++++--
 include/net/tcp.h     |  8 ++++++++
 net/ipv4/tcp_input.c  | 10 ++++++++--
 net/ipv4/tcp_output.c |  2 +-
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index cd041f409841..3e6d9ddd5356 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -16,8 +16,6 @@
 #ifndef __NET_MPTCP_H
 #define __NET_MPTCP_H
 =

-#include <linux/tcp.h>
-
 /* MPTCP option subtypes */
 =

 #define MPTCPOPT_MP_CAPABLE	0
@@ -125,6 +123,11 @@ void mptcp_subflow_exit(void);
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *options);
 =

+static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
+{
+	return skb_ext_exist(skb, SKB_EXT_MPTCP);
+}
+
 extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
 =

 void token_init(void);
@@ -180,5 +183,10 @@ static inline unsigned int mptcp_established_options(s=
truct sock *sk,
 	return 0;
 }
 =

+static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
+{
+	return false;
+}
+
 #endif /* CONFIG_MPTCP */
 #endif /* __NET_MPTCP_H */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6122e8e36f01..7aff29916f2b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -43,6 +43,7 @@
 #include <net/tcp_states.h>
 #include <net/inet_ecn.h>
 #include <net/dst.h>
+#include <net/mptcp.h>
 =

 #include <linux/seq_file.h>
 #include <linux/memcontrol.h>
@@ -954,6 +955,13 @@ static inline bool tcp_skb_can_collapse_to(const struc=
t sk_buff *skb)
 	return likely(!TCP_SKB_CB(skb)->eor);
 }
 =

+static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
+					const struct sk_buff *from)
+{
+	return likely(tcp_skb_can_collapse_to(to) &&
+		      !mptcp_skb_ext_exist(from));
+}
+
 /* Events passed to congestion control interface */
 enum tcp_ca_event {
 	CA_EVENT_TX_START,	/* first transmit when no packets in flight */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9f0a759cff2a..4124c6b96f2b 100644
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
@@ -4363,6 +4363,9 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (TCP_SKB_CB(from)->seq !=3D TCP_SKB_CB(to)->end_seq)
 		return false;
 =

+	if (mptcp_skb_ext_exist(from))
+		return false;
+
 #ifdef CONFIG_TLS_DEVICE
 	if (from->decrypted !=3D to->decrypted)
 		return false;
@@ -4880,10 +4883,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
 =

 		/* The first skb to collapse is:
 		 * - not SYN/FIN and
+		 * - does not use priv_data
 		 * - bloated or contains data before "start" or
 		 *   overlaps to the next one.
 		 */
 		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
+		    !mptcp_skb_ext_exist(skb) &&
 		    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
 		     before(TCP_SKB_CB(skb)->seq, start))) {
 			end_of_skbs =3D false;
@@ -4899,7 +4904,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *li=
st, struct rb_root *root,
 		/* Decided to skip this, advance start seq. */
 		start =3D TCP_SKB_CB(skb)->end_seq;
 	}
-	if (end_of_skbs ||
+	if (end_of_skbs || mptcp_skb_ext_exist(skb) ||
 	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
 		return;
 =

@@ -4942,6 +4947,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *li=
st, struct rb_root *root,
 				skb =3D tcp_collapse_one(sk, skb, list, root);
 				if (!skb ||
 				    skb =3D=3D tail ||
+				    mptcp_skb_ext_exist(skb) ||
 				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
 					goto end;
 #ifdef CONFIG_TLS_DEVICE
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 89b339c26f7b..48b03106231d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2901,7 +2901,7 @@ static void tcp_retrans_try_collapse(struct sock *sk,=
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

2.20.0


--===============8502714107985093182==--
