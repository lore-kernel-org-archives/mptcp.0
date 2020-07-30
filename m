Content-Type: multipart/mixed; boundary="===============8494364776518426406=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC v3 01/10] tcp: remove cookie_ts bit from
 request_sock
Date: Thu, 30 Jul 2020 02:12:32 +0200
Message-ID: <20200730001241.3037-2-fw@strlen.de>
In-Reply-To: 20200730001241.3037-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5373

--===============8494364776518426406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No need for this anymore; nowadays output function has a 'synack_type'
argument that tells us when the syn/ack is emitted via syncookies.

The request already tells us when timestamps are supported, so check
both to detect special timestamp for tcp option encoding is needed.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 drivers/crypto/chelsio/chtls/chtls_cm.c | 1 -
 include/net/request_sock.h              | 3 +--
 net/ipv4/tcp_input.c                    | 2 --
 net/ipv4/tcp_output.c                   | 2 +-
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_cm.c b/drivers/crypto/chels=
io/chtls/chtls_cm.c
index f924c335a195..030f20148007 100644
--- a/drivers/crypto/chelsio/chtls/chtls_cm.c
+++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
@@ -1348,7 +1348,6 @@ static void chtls_pass_accept_request(struct sock *sk,
 =

 	oreq->rsk_rcv_wnd =3D 0;
 	oreq->rsk_window_clamp =3D 0;
-	oreq->cookie_ts =3D 0;
 	oreq->mss =3D 0;
 	oreq->ts_recent =3D 0;
 =

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index cf8b33213bbc..2f717d4dafc5 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -54,8 +54,7 @@ struct request_sock {
 	struct request_sock		*dl_next;
 	u16				mss;
 	u8				num_retrans; /* number of retransmits */
-	u8				cookie_ts:1; /* syncookie: encode tcpopts in timestamp */
-	u8				num_timeout:7; /* number of timeouts */
+	u8				num_timeout; /* number of timeouts */
 	u32				ts_recent;
 	struct timer_list		rsk_timer;
 	const struct request_sock_ops	*rsk_ops;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a018bafd7bdf..fcca58476678 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6519,7 +6519,6 @@ static void tcp_openreq_init(struct request_sock *req,
 	struct inet_request_sock *ireq =3D inet_rsk(req);
 =

 	req->rsk_rcv_wnd =3D 0;		/* So that tcp_send_synack() knows! */
-	req->cookie_ts =3D 0;
 	tcp_rsk(req)->rcv_isn =3D TCP_SKB_CB(skb)->seq;
 	tcp_rsk(req)->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
 	tcp_rsk(req)->snt_synack =3D 0;
@@ -6739,7 +6738,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 =

 	if (want_cookie) {
 		isn =3D cookie_init_sequence(af_ops, sk, skb, &req->mss);
-		req->cookie_ts =3D tmp_opt.tstamp_ok;
 		if (!tmp_opt.tstamp_ok)
 			inet_rsk(req)->ecn_ok =3D 0;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d8f16f6a9b02..bd0e5a7cd072 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3393,7 +3393,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 	memset(&opts, 0, sizeof(opts));
 	now =3D tcp_clock_ns();
 #ifdef CONFIG_SYN_COOKIES
-	if (unlikely(req->cookie_ts))
+	if (unlikely(synack_type =3D=3D TCP_SYNACK_COOKIE && inet_rsk(req)->tstam=
p_ok))
 		skb->skb_mstamp_ns =3D cookie_init_timestamp(req, now);
 	else
 #endif
-- =

2.26.2

--===============8494364776518426406==--
