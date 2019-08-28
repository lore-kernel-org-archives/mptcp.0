Content-Type: multipart/mixed; boundary="===============3052453466071245451=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] tcp: fix hooking for mptcp_incoming_options()
Date: Wed, 28 Aug 2019 09:55:00 +0200
Message-ID: <742d71b4208c8252c434fe0e34d4429b77c3da70.1566923129.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1732

--===============3052453466071245451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we don't process mptcp options for half-open sockets, e.g.
for packet with payload delivered to the rx queue via
tcp_rcv_state_process(), and for pure ack landing in the same code path.

We can deal with the first code path moving the existing
mptcp_incoming_options() hook inside tcp_data_queue(), but we need
to add an additional hook to deal with the specified pure acks

Fixes: d2d58ff48665 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
I'm ok with squashing this one into the fixed patch
Any other option not needing an additional hook more than welcome
The reported issue does not affect the existing code base,
but as soon as we start tracking the MPTCP level unacked sequence
number it become apparent, as we can't track it for
half-open sockets
---
 net/ipv4/tcp_input.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1c06cfb06374..cf2cf09d7d3d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4763,6 +4763,9 @@ static void tcp_data_queue(struct sock *sk, struct sk=
_buff *skb)
 	bool fragstolen;
 	int eaten;
 =

+	if (sk_is_mptcp(sk))
+		mptcp_incoming_options(sk, skb, &tp->rx_opt);
+
 	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
 		__kfree_skb(skb);
 		return;
@@ -5711,10 +5714,6 @@ void tcp_rcv_established(struct sock *sk, struct sk_=
buff *skb)
 	/* Process urgent data. */
 	tcp_urg(sk, skb, th);
 =

-	/* Process MPTCP options */
-	if (sk_is_mptcp(sk))
-		mptcp_incoming_options(sk, skb, &tp->rx_opt);
-
 	/* step 7: process the segment text */
 	tcp_data_queue(sk, skb);
 =

@@ -6335,8 +6334,11 @@ int tcp_rcv_state_process(struct sock *sk, struct sk=
_buff *skb)
 	case TCP_CLOSE_WAIT:
 	case TCP_CLOSING:
 	case TCP_LAST_ACK:
-		if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt))
+		if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
+			if (sk_is_mptcp(sk))
+				mptcp_incoming_options(sk, skb, &tp->rx_opt);
 			break;
+		}
 		/* fall through */
 	case TCP_FIN_WAIT1:
 	case TCP_FIN_WAIT2:
-- =

2.21.0


--===============3052453466071245451==--
