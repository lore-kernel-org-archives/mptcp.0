Content-Type: multipart/mixed; boundary="===============7629375403627621415=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 13/25] tcp_extra_options: Add response_prepare
 callback
Date: Mon, 27 Nov 2017 21:57:14 -0800
Message-ID: <20171128055726.430-14-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 188

--===============7629375403627621415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the same way as for the write-callback, having a separate one for the
response-case is useful to separate the two use-cases.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/tcp.h   | 10 ++++++++++
 net/ipv4/tcp.c      | 34 +++++++++++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c | 18 ++++++++++++------
 net/ipv6/tcp_ipv6.c | 10 ++++++++--
 4 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 1f34b1708990..0b94356ee5ba 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2085,6 +2085,11 @@ struct tcp_extra_option_ops {
 	void (*write)(__be32 *ptr, struct sk_buff *skb,
 		      struct tcp_out_options *opts, struct sock *sk,
 		      struct tcp_extra_option_store *store);
+	int (*response_prepare)(struct sk_buff *orig, u8 flags,
+				unsigned int remaining,
+				struct tcp_out_options *opts,
+				const struct sock *sk,
+				struct tcp_extra_option_store *store);
 	void (*response_write)(__be32 *ptr, struct sk_buff *orig,
 			       struct tcphdr *th,
 			       struct tcp_out_options *opts,
@@ -2130,6 +2135,11 @@ void tcp_extra_options_write(__be32 *ptr, struct sk_=
buff *skb,
 			     struct tcp_out_options *opts,
 			     struct sock *sk);
 =

+int tcp_extra_options_response_prepare(struct sk_buff *orig, u8 flags,
+				       unsigned int remaining,
+				       struct tcp_out_options *opts,
+				       const struct sock *sk);
+
 void tcp_extra_options_response_write(__be32 *ptr, struct sk_buff *orig,
 				      struct tcphdr *th,
 				      struct tcp_out_options *opts,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1afd56638854..81b98a33530f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3544,7 +3544,6 @@ unsigned int tcp_extra_options_prepare(struct sk_buff=
 *skb, u8 flags,
 =

 	return roundup(used, 4);
 }
-EXPORT_SYMBOL_GPL(tcp_extra_options_prepare);
 =

 void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
 			     struct tcp_out_options *opts,
@@ -3567,6 +3566,39 @@ void tcp_extra_options_write(__be32 *ptr, struct sk_=
buff *skb,
 }
 EXPORT_SYMBOL_GPL(tcp_extra_options_write);
 =

+int tcp_extra_options_response_prepare(struct sk_buff *orig, u8 flags,
+				       unsigned int remaining,
+				       struct tcp_out_options *opts,
+				       const struct sock *sk)
+{
+	struct tcp_extra_option_store *entry;
+	struct list_head *lhead;
+	unsigned int used =3D 0;
+
+	if (!sk)
+		return 0;
+
+	lhead =3D tcp_extra_options_get_list(sk);
+
+	list_for_each_entry(entry, lhead, list) {
+		int ret;
+
+		if (unlikely(!entry->ops->response_prepare))
+			continue;
+
+		ret =3D entry->ops->response_prepare(orig, flags,
+						   remaining - used, opts,
+						   sk, entry);
+		if (ret < 0)
+			return ret;
+
+		used +=3D ret;
+	}
+
+	return roundup(used, 4);
+}
+EXPORT_SYMBOL_GPL(tcp_extra_options_response_prepare);
+
 void tcp_extra_options_response_write(__be32 *ptr, struct sk_buff *orig,
 				      struct tcphdr *th,
 				      struct tcp_out_options *opts,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4a47bfd12662..f0db7beda04e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -681,8 +681,8 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb)
 =

 	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
 		unsigned int remaining;
-		unsigned int used;
 		struct tcp_out_options opts;
+		int used;
 =

 		remaining =3D sizeof(rep.opt);
 #ifdef CONFIG_TCP_MD5SIG
@@ -692,8 +692,11 @@ static void tcp_v4_send_reset(const struct sock *sk, s=
truct sk_buff *skb)
 =

 		memset(&opts, 0, sizeof(opts));
 =

-		used =3D tcp_extra_options_prepare(NULL, TCPHDR_RST, remaining,
-						 &opts, sk);
+		used =3D tcp_extra_options_response_prepare(skb, TCPHDR_RST,
+							  remaining,
+							  &opts, sk);
+		if (used < 0)
+			return;
 =

 		tcp_extra_options_response_write(&rep.opt[0], skb, &rep.th, &opts, sk);
 =

@@ -812,8 +815,8 @@ static void tcp_v4_send_ack(const struct sock *sk,
 =

 	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
 		unsigned int remaining;
-		unsigned int used;
 		struct tcp_out_options opts;
+		int used;
 =

 		remaining =3D sizeof(rep.th) + sizeof(rep.opt) - arg.iov[0].iov_len;
 =

@@ -823,8 +826,11 @@ static void tcp_v4_send_ack(const struct sock *sk,
 #endif
 =

 		memset(&opts, 0, sizeof(opts));
-		used =3D tcp_extra_options_prepare(NULL, TCPHDR_ACK, remaining,
-						 &opts, sk);
+		used =3D tcp_extra_options_response_prepare(skb, TCPHDR_ACK,
+							  remaining,
+							  &opts, sk);
+		if (used < 0)
+			return;
 =

 		tcp_extra_options_response_write(&rep.opt[offset], skb, &rep.th, &opts, =
sk);
 =

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0a29ef82db35..2fb688a36731 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -848,14 +848,20 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
 	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
 		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - tot_len;
 		u8 extraflags =3D rst ? TCPHDR_RST : 0;
+		int used;
 =

 		if (!rst || !th->ack)
 			extraflags |=3D TCPHDR_ACK;
 =

 		memset(&extraopts, 0, sizeof(extraopts));
 =

-		tot_len +=3D tcp_extra_options_prepare(skb, extraflags, remaining,
-						     &extraopts, sk);
+		used =3D tcp_extra_options_response_prepare(skb, extraflags,
+							  remaining,
+							  &extraopts, sk);
+		if (used < 0)
+			goto out;
+
+		tot_len +=3D used;
 	}
 =

 	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
-- =

2.15.0


--===============7629375403627621415==--
