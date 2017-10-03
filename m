Content-Type: multipart/mixed; boundary="===============0867227978499824466=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 11/18] tcp_extra_option: Pass sock to prepare_req
Date: Tue, 03 Oct 2017 09:21:57 -0700
Message-ID: <20171003162204.17945-12-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 96

--===============0867227978499824466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will be needed for TCP_MD5.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/tcp.h     | 6 ++++--
 net/ipv4/tcp.c        | 5 +++--
 net/ipv4/tcp_output.c | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a66671127936..bc3b8f655a43 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2123,7 +2123,8 @@ struct tcp_extra_option_ops {
 	unsigned int (*prepare_req)(struct sk_buff *skb, u8 flags,
 				    unsigned int remaining,
 				    struct tcp_out_options *opts,
-				    struct request_sock *req);
+				    struct request_sock *req,
+				    const struct sock *sk);
 	void (*write)(__be32 *ptr, struct sk_buff *skb,
 		      struct tcp_out_options *opts, struct sock *sk);
 	int (*add_header_len)(const struct sock *listener,
@@ -2144,7 +2145,8 @@ unsigned int tcp_extra_options_prepare(struct sk_buff=
 *skb, u8 flags,
 unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 flags,
 					   unsigned int remaining,
 					   struct tcp_out_options *opts,
-					   struct request_sock *req);
+					   struct request_sock *req,
+					   const struct sock *sk);
 =

 void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
 			     struct tcp_out_options *opts, struct sock *sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3310e252b325..e6aea011b65d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3433,7 +3433,8 @@ unsigned int tcp_extra_options_prepare(struct sk_buff=
 *skb, u8 flags,
 unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 flags,
 					   unsigned int remaining,
 					   struct tcp_out_options *opts,
-					   struct request_sock *req)
+					   struct request_sock *req,
+					   const struct sock *sk)
 {
 	struct tcp_extra_option_ops *entry;
 	unsigned int used =3D 0;
@@ -3444,7 +3445,7 @@ unsigned int tcp_extra_options_prepare_req(struct sk_=
buff *skb, u8 flags,
 			continue;
 =

 		used +=3D entry->prepare_req(skb, flags, remaining - used, opts,
-					   req);
+					   req, sk);
 	}
 	rcu_read_unlock();
 =

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 522103a43941..1eb00e93c895 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -664,7 +664,8 @@ static unsigned int tcp_synack_options(const struct soc=
k *sk,
 							   TCPHDR_SYN |
 							   TCPHDR_ACK,
 							   remaining, opts,
-							   req);
+							   req,
+							   sk);
 =

 	return MAX_TCP_OPTION_SPACE - remaining;
 }
-- =

2.14.1


--===============0867227978499824466==--
