Content-Type: multipart/mixed; boundary="===============5820716080685618851=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 17/25] tcp_extra_options: Add check-callback right
 after parsing the option
Date: Mon, 27 Nov 2017 21:57:18 -0800
Message-ID: <20171128055726.430-18-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 191

--===============5820716080685618851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

TCP-options like MD5 can trigger an early drop of the packet. Thus, we
need to add a check-callback right after the parsing to implement this
drop.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/tcp.h        |  8 ++++++++
 net/ipv4/syncookies.c    |  4 ++++
 net/ipv4/tcp.c           | 24 ++++++++++++++++++++++++
 net/ipv4/tcp_input.c     | 11 ++++++++++-
 net/ipv4/tcp_minisocks.c | 12 ++++++++++--
 net/ipv6/syncookies.c    |  4 ++++
 6 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 55f6e6b39539..63fe6e02a963 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2076,6 +2076,10 @@ struct tcp_extra_option_ops {
 		      struct tcp_options_received *opt_rx,
 		      struct sock *sk,
 		      struct tcp_extra_option_store *store);
+	bool (*check)(struct sock *sk,
+		      const struct sk_buff *skb,
+		      struct tcp_options_received *opt_rx,
+		      struct tcp_extra_option_store *store);
 	/* Return the number of bytes consumed */
 	unsigned int (*prepare)(struct sk_buff *skb, u8 flags,
 				unsigned int remaining,
@@ -2126,6 +2130,10 @@ void tcp_extra_options_parse(int opcode, int opsize,=
 const unsigned char *opptr,
 			     struct tcp_options_received *opt_rx,
 			     struct sock *sk);
 =

+bool tcp_extra_options_check(struct sock *sk,
+			     const struct sk_buff *skb,
+			     struct tcp_options_received *opt_rx);
+
 unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
 				       unsigned int remaining,
 				       struct tcp_out_options *opts,
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index fc4f91d92b8a..77ddae746b25 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -325,6 +325,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct s=
k_buff *skb)
 	if (!cookie_timestamp_decode(sock_net(sk), &tcp_opt))
 		goto out;
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled) &&
+	    tcp_extra_options_check(sk, skb, &tcp_opt))
+		goto out;
+
 	ret =3D NULL;
 	req =3D inet_reqsk_alloc(&tcp_request_sock_ops, sk, false); /* for safety=
 */
 	if (!req)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 81b98a33530f..bc7f471bcf96 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3520,6 +3520,30 @@ void tcp_extra_options_parse(int opcode, int opsize,=
 const unsigned char *opptr,
 		entry->ops->parse(opsize, opptr, skb, opt_rx, sk, entry);
 }
 =

+bool tcp_extra_options_check(struct sock *sk,
+			     const struct sk_buff *skb,
+			     struct tcp_options_received *opt_rx)
+{
+	struct tcp_extra_option_store *entry;
+	struct list_head *lhead;
+	bool drop =3D false;
+
+	lhead =3D tcp_extra_options_get_list(sk);
+
+	list_for_each_entry(entry, lhead, list) {
+		bool ret =3D false;
+
+		if (entry->ops->check)
+			ret =3D entry->ops->check(sk, skb, opt_rx, entry);
+
+		if (ret)
+			drop =3D true;
+	}
+
+	return drop;
+}
+EXPORT_SYMBOL_GPL(tcp_extra_options_check);
+
 unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
 				       unsigned int remaining,
 				       struct tcp_out_options *opts,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 07a43518affa..23c62d8e4e06 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3858,7 +3858,8 @@ static bool tcp_fast_parse_options(const struct net *=
net,
 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
 =

 extra_opt_check:
-	/* ToDo - will be added here */
+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		return tcp_extra_options_check(tcp_to_sk(tp), skb, &tp->rx_opt);
 	return false;
 }
 =

@@ -5590,6 +5591,10 @@ static int tcp_rcv_synsent_state_process(struct sock=
 *sk, struct sk_buff *skb,
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled) &&
+	    tcp_extra_options_check(sk, skb, &tp->rx_opt))
+		goto discard;
+
 	if (th->ack) {
 		/* rfc793:
 		 * "If the state is SYN-SENT then
@@ -6256,6 +6261,10 @@ int tcp_conn_request(struct request_sock_ops *rsk_op=
s,
 	tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0,
 			  want_cookie ? NULL : &foc, sk);
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled) &&
+	    tcp_extra_options_check(sk, skb, &tmp_opt))
+		goto drop_and_free;
+
 	if (want_cookie && !tmp_opt.saw_tstamp)
 		tcp_clear_options(&tmp_opt);
 =

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1685c5ab4913..c3a0a4676fc8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -95,7 +95,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw,=
 struct sk_buff *skb,
 	struct tcp_timewait_sock *tcptw =3D tcp_twsk((struct sock *)tw);
 	bool paws_reject =3D false;
 =

-	tmp_opt.saw_tstamp =3D 0;
+	tcp_clear_options(&tmp_opt);
 	if (th->doff > (sizeof(*th) >> 2) && tcptw->tw_ts_recent_stamp) {
 		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL,
 				  (struct sock *)tw);
@@ -109,6 +109,10 @@ tcp_timewait_state_process(struct inet_timewait_sock *=
tw, struct sk_buff *skb,
 		}
 	}
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled) &&
+	    tcp_extra_options_check((struct sock *)tw, skb, &tmp_opt))
+		return TCP_TW_SUCCESS;
+
 	if (tw->tw_substate =3D=3D TCP_FIN_WAIT2) {
 		/* Just repeat all the checks of tcp_rcv_state_process() */
 =

@@ -594,7 +598,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_b=
uff *skb,
 	bool paws_reject =3D false;
 	bool own_req;
 =

-	tmp_opt.saw_tstamp =3D 0;
+	tcp_clear_options(&tmp_opt);
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL,
 				  req_to_sk(req));
@@ -612,6 +616,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_=
buff *skb,
 		}
 	}
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled) &&
+	    tcp_extra_options_check(req_to_sk(req), skb, &tmp_opt))
+		return NULL;
+
 	/* Check for pure retransmitted SYN. */
 	if (TCP_SKB_CB(skb)->seq =3D=3D tcp_rsk(req)->rcv_isn &&
 	    flg =3D=3D TCP_FLAG_SYN &&
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 67ea216b7ffa..05228c28c992 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -174,6 +174,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct s=
k_buff *skb)
 	if (!cookie_timestamp_decode(sock_net(sk), &tcp_opt))
 		goto out;
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled) &&
+	    tcp_extra_options_check(sk, skb, &tcp_opt))
+		goto out;
+
 	ret =3D NULL;
 	req =3D inet_reqsk_alloc(&tcp6_request_sock_ops, sk, false);
 	if (!req)
-- =

2.15.0


--===============5820716080685618851==--
