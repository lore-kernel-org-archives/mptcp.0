Content-Type: multipart/mixed; boundary="===============1444485207055115007=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 09/18] tcp_extra_option: Use sock instead of tcp_sock
 in tcp_extra_options_parse/prepare/write
Date: Tue, 03 Oct 2017 09:21:55 -0700
Message-ID: <20171003162204.17945-10-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 92

--===============1444485207055115007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's just easier that way and we can do less type-casts later on for
MD5.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/tcp.h     | 12 ++++++------
 net/ipv4/tcp.c        | 12 ++++++------
 net/ipv4/tcp_input.c  |  3 ++-
 net/ipv4/tcp_output.c |  6 +++---
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 641b1cf71528..ead224b205d2 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2113,19 +2113,19 @@ struct tcp_extra_option_ops {
 	void (*parse)(int opsize, const unsigned char *opptr,
 		      const struct sk_buff *skb,
 		      struct tcp_options_received *opt_rx,
-		      struct tcp_sock *tp);
+		      struct sock *sk);
 	/* Return the number of bytes consumed */
 	unsigned int (*prepare)(struct sk_buff *skb, u8 flags,
 				unsigned int remaining,
 				struct tcp_out_options *opts,
-				struct tcp_sock *tp);
+				struct sock *sk);
 	/* Return the number of bytes consumed */
 	unsigned int (*prepare_req)(struct sk_buff *skb, u8 flags,
 				    unsigned int remaining,
 				    struct tcp_out_options *opts,
 				    struct request_sock *req);
 	void (*write)(__be32 *ptr, struct tcp_out_options *opts,
-		      struct tcp_sock *tp);
+		      struct sock *sk);
 	int (*add_header_len)(const struct sock *listener,
 			      const struct sock *sk);
 	struct module		*owner;
@@ -2134,12 +2134,12 @@ struct tcp_extra_option_ops {
 void tcp_extra_options_parse(int opcode, int opsize, const unsigned char *=
opptr,
 			     const struct sk_buff *skb,
 			     struct tcp_options_received *opt_rx,
-			     struct tcp_sock *tp);
+			     struct sock *sk);
 =

 unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
 				       unsigned int remaining,
 				       struct tcp_out_options *opts,
-				       struct tcp_sock *tp);
+				       struct sock *sk);
 =

 unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 flags,
 					   unsigned int remaining,
@@ -2147,7 +2147,7 @@ unsigned int tcp_extra_options_prepare_req(struct sk_=
buff *skb, u8 flags,
 					   struct request_sock *req);
 =

 void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
-			     struct tcp_sock *tp);
+			     struct sock *sk);
 =

 int tcp_extra_options_add_header(const struct sock *listener,
 				 const struct sock *sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7ecd1ffdf3ad..b822680a1709 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3399,21 +3399,21 @@ static struct tcp_extra_option_ops *tcp_extra_optio=
ns_find_kind(unsigned char ki
 void tcp_extra_options_parse(int opcode, int opsize, const unsigned char *=
opptr,
 			     const struct sk_buff *skb,
 			     struct tcp_options_received *opt_rx,
-			     struct tcp_sock *tp)
+			     struct sock *sk)
 {
 	struct tcp_extra_option_ops *entry;
 =

 	rcu_read_lock();
 	entry =3D tcp_extra_options_find_kind(opcode);
 	if (entry && entry->parse)
-		entry->parse(opsize, opptr, skb, opt_rx, tp);
+		entry->parse(opsize, opptr, skb, opt_rx, sk);
 	rcu_read_unlock();
 }
 =

 unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
 				       unsigned int remaining,
 				       struct tcp_out_options *opts,
-				       struct tcp_sock *tp)
+				       struct sock *sk)
 {
 	struct tcp_extra_option_ops *entry;
 	unsigned int used =3D 0;
@@ -3423,7 +3423,7 @@ unsigned int tcp_extra_options_prepare(struct sk_buff=
 *skb, u8 flags,
 		if (unlikely(!entry->prepare))
 			continue;
 =

-		used +=3D entry->prepare(skb, flags, remaining - used, opts, tp);
+		used +=3D entry->prepare(skb, flags, remaining - used, opts, sk);
 	}
 	rcu_read_unlock();
 =

@@ -3452,7 +3452,7 @@ unsigned int tcp_extra_options_prepare_req(struct sk_=
buff *skb, u8 flags,
 }
 =

 void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
-			     struct tcp_sock *tp)
+			     struct sock *sk)
 {
 	struct tcp_extra_option_ops *entry;
 =

@@ -3461,7 +3461,7 @@ void tcp_extra_options_write(__be32 *ptr, struct tcp_=
out_options *opts,
 		if (unlikely(!entry->write))
 			continue;
 =

-		entry->write(ptr, opts, tp);
+		entry->write(ptr, opts, sk);
 	}
 	rcu_read_unlock();
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 89c38ef94b54..f0d17c36610d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3830,7 +3830,8 @@ void tcp_parse_options(const struct net *net,
 =

 			default:
 				tcp_extra_options_parse(opcode, opsize, ptr,
-							skb, opt_rx, tp);
+							skb, opt_rx,
+							(struct sock *)tp);
 				break;
 =

 			}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ebf7b07e7589..f2885194ea10 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -526,7 +526,7 @@ static void tcp_options_write(__be32 *ptr, struct sk_bu=
ff *skb, struct sock *sk,
 	}
 =

 	if (static_branch_unlikely(&tcp_extra_options_enabled))
-		tcp_extra_options_write(ptr, opts, tp);
+		tcp_extra_options_write(ptr, opts, sk);
 }
 =

 /* Compute TCP options for SYN packets. This is not the final
@@ -596,7 +596,7 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 =

 	if (static_branch_unlikely(&tcp_extra_options_enabled))
 		remaining -=3D tcp_extra_options_prepare(skb, TCPHDR_SYN,
-						       remaining, opts, tp);
+						       remaining, opts, sk);
 =

 	return MAX_TCP_OPTION_SPACE - remaining;
 }
@@ -702,7 +702,7 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 	if (static_branch_unlikely(&tcp_extra_options_enabled))
 		size +=3D tcp_extra_options_prepare(skb, 0,
 						  MAX_TCP_OPTION_SPACE - size,
-						  opts, tp);
+						  opts, sk);
 =

 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
-- =

2.14.1


--===============1444485207055115007==--
