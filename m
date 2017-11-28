Content-Type: multipart/mixed; boundary="===============1068179021899935425=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 19/25] tcp_extra_options: Add post_process callback
Date: Mon, 27 Nov 2017 21:57:20 -0800
Message-ID: <20171128055726.430-20-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 194

--===============1068179021899935425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some options require that after validation of the segment, we
post-process the options (e.g., set certain bits,...)

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/tcp.h    |  6 ++++++
 net/ipv4/tcp.c       | 14 ++++++++++++++
 net/ipv4/tcp_input.c |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f2708d69bb43..a9b99209d726 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2081,6 +2081,9 @@ struct tcp_extra_option_ops {
 		      const struct sk_buff *skb,
 		      struct tcp_options_received *opt_rx,
 		      struct tcp_extra_option_store *store);
+	void (*post_process)(struct sock *sk,
+			     struct tcp_options_received *opt_rx,
+			     struct tcp_extra_option_store *store);
 	/* Return the number of bytes consumed */
 	unsigned int (*prepare)(struct sk_buff *skb, u8 flags,
 				unsigned int remaining,
@@ -2135,6 +2138,9 @@ bool tcp_extra_options_check(struct sock *sk,
 			     const struct sk_buff *skb,
 			     struct tcp_options_received *opt_rx);
 =

+void tcp_extra_options_post_process(struct sock *sk,
+				    struct tcp_options_received *opt_rx);
+
 unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
 				       unsigned int remaining,
 				       struct tcp_out_options *opts,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6d4e87aa1bbf..5a9269e9ca2b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3544,6 +3544,20 @@ bool tcp_extra_options_check(struct sock *sk,
 }
 EXPORT_SYMBOL_GPL(tcp_extra_options_check);
 =

+void tcp_extra_options_post_process(struct sock *sk,
+				    struct tcp_options_received *opt_rx)
+{
+	struct tcp_extra_option_store *entry;
+	struct list_head *lhead;
+
+	lhead =3D tcp_extra_options_get_list(sk);
+
+	list_for_each_entry(entry, lhead, list) {
+		if (entry->ops->post_process)
+			entry->ops->post_process(sk, opt_rx, entry);
+	}
+}
+
 unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
 				       unsigned int remaining,
 				       struct tcp_out_options *opts,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2a3debb2c7fe..dba59c8ae627 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5683,6 +5683,9 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 			tp->tcp_header_len =3D sizeof(struct tcphdr);
 		}
 =

+		if (static_branch_unlikely(&tcp_extra_options_enabled))
+			tcp_extra_options_post_process(sk, &tp->rx_opt);
+
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		tcp_initialize_rcv_mss(sk);
 =

@@ -5776,6 +5779,9 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 =

 		tcp_ecn_rcv_syn(tp, th);
 =

+		if (static_branch_unlikely(&tcp_extra_options_enabled))
+			tcp_extra_options_post_process(sk, &tp->rx_opt);
+
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		tcp_initialize_rcv_mss(sk);
-- =

2.15.0


--===============1068179021899935425==--
