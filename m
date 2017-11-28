Content-Type: multipart/mixed; boundary="===============4833897244649952344=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 10/25] tcp_extra_options: Extend
 tcp_extra_options_write
Date: Mon, 27 Nov 2017 21:57:11 -0800
Message-ID: <20171128055726.430-11-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 184

--===============4833897244649952344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The sk in tcp_extra_options_write cannot be a const, because we need to
be able to modify it (see TCP_MD5 in tcp_transmit_skb).

In tcp_v4_send_ack/reset (and the v6 counterpart), we also need the
original skb that triggers the response. Further, the sk must be a const
here. So, we need a new tcp_extra_options_response_write callback to
handle these cases. It's also cleaner IMO as these responses are quite
different from tcp_options_write.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/tcp.h     | 13 +++++++++++--
 net/ipv4/tcp.c        | 22 +++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c   |  4 ++--
 net/ipv4/tcp_output.c |  2 +-
 net/ipv6/tcp_ipv6.c   |  2 +-
 5 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index fff0959dfd91..0981a1b429ca 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2081,7 +2081,11 @@ struct tcp_extra_option_ops {
 				struct tcp_out_options *opts,
 				const struct sock *sk);
 	void (*write)(__be32 *ptr, struct sk_buff *skb,
-		      struct tcp_out_options *opts, const struct sock *sk);
+		      struct tcp_out_options *opts, struct sock *sk);
+	void (*response_write)(__be32 *ptr, struct sk_buff *orig,
+			       struct tcphdr *th,
+			       struct tcp_out_options *opts,
+			       const struct sock *sk);
 	int (*add_header_len)(const struct sock *listener,
 			      const struct sock *sk);
 	struct module		*owner;
@@ -2099,7 +2103,12 @@ unsigned int tcp_extra_options_prepare(struct sk_buf=
f *skb, u8 flags,
 =

 void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
 			     struct tcp_out_options *opts,
-			     const struct sock *sk);
+			     struct sock *sk);
+
+void tcp_extra_options_response_write(__be32 *ptr, struct sk_buff *orig,
+				      struct tcphdr *th,
+				      struct tcp_out_options *opts,
+				      const struct sock *sk);
 =

 int tcp_extra_options_add_header(const struct sock *listener,
 				 const struct sock *sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 155bee4659fa..487f28222d3c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3539,7 +3539,7 @@ EXPORT_SYMBOL_GPL(tcp_extra_options_prepare);
  */
 void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
 			     struct tcp_out_options *opts,
-			     const struct sock *sk)
+			     struct sock *sk)
 {
 	struct tcp_extra_option_ops *entry;
 =

@@ -3552,6 +3552,26 @@ void tcp_extra_options_write(__be32 *ptr, struct sk_=
buff *skb,
 }
 EXPORT_SYMBOL_GPL(tcp_extra_options_write);
 =

+/* The RCU read lock must be held before calling, and should span both
+ * the call to tcp_extra_options_write and this function to ensure that
+ * tcp_option_list does not change between the two calls.
+ */
+void tcp_extra_options_response_write(__be32 *ptr, struct sk_buff *orig,
+				      struct tcphdr *th,
+				      struct tcp_out_options *opts,
+				      const struct sock *sk)
+{
+	struct tcp_extra_option_ops *entry;
+
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (unlikely(!entry->write))
+			continue;
+
+		entry->response_write(ptr, orig, th, opts, sk);
+	}
+}
+EXPORT_SYMBOL_GPL(tcp_extra_options_response_write);
+
 int tcp_extra_options_add_header(const struct sock *listener,
 				 const struct sock *sk)
 {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ccbb219c7b61..f717069ad778 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -696,7 +696,7 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb)
 		used =3D tcp_extra_options_prepare(NULL, TCPHDR_RST, remaining,
 						 &opts, sk);
 =

-		tcp_extra_options_write(&rep.opt[0], NULL, &opts, sk);
+		tcp_extra_options_response_write(&rep.opt[0], skb, &rep.th, &opts, sk);
 		rcu_read_unlock();
 =

 		arg.iov[0].iov_len +=3D used;
@@ -829,7 +829,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 		used =3D tcp_extra_options_prepare(NULL, TCPHDR_ACK, remaining,
 						 &opts, sk);
 =

-		tcp_extra_options_write(&rep.opt[offset], NULL, &opts, sk);
+		tcp_extra_options_response_write(&rep.opt[offset], skb, &rep.th, &opts, =
sk);
 		rcu_read_unlock();
 =

 		arg.iov[0].iov_len +=3D used;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 199a8baf281c..1fd331018e58 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -527,7 +527,7 @@ static void tcp_options_write(__be32 *ptr, struct sk_bu=
ff *skb, struct sock *sk,
 	smc_options_write(ptr, &options);
 =

 	if (static_branch_unlikely(&tcp_extra_options_enabled))
-		tcp_extra_options_write(ptr, skb, opts, tcp_to_sk(tp));
+		tcp_extra_options_write(ptr, skb, opts, sk);
 }
 =

 static void smc_set_option(const struct tcp_sock *tp,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7e4e8788943f..ef037990ea5e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -896,7 +896,7 @@ static void tcp_v6_send_response(const struct sock *sk,=
 struct sk_buff *skb, u32
 #endif
 =

 	if (static_branch_unlikely(&tcp_extra_options_enabled))
-		tcp_extra_options_write(topt, buff, &extraopts, sk);
+		tcp_extra_options_response_write(topt, skb, t1, &extraopts, sk);
 =

 	memset(&fl6, 0, sizeof(fl6));
 	fl6.daddr =3D ipv6_hdr(skb)->saddr;
-- =

2.15.0


--===============4833897244649952344==--
