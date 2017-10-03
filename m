Content-Type: multipart/mixed; boundary="===============3788570431320892873=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 10/18] tcp_extra_option: Pass skb to
 tcp_extra_options_write
Date: Tue, 03 Oct 2017 09:21:56 -0700
Message-ID: <20171003162204.17945-11-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 95

--===============3788570431320892873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will be needed for TCP_MD5.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/tcp.h     | 8 ++++----
 net/ipv4/tcp.c        | 6 +++---
 net/ipv4/tcp_output.c | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ead224b205d2..a66671127936 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2124,8 +2124,8 @@ struct tcp_extra_option_ops {
 				    unsigned int remaining,
 				    struct tcp_out_options *opts,
 				    struct request_sock *req);
-	void (*write)(__be32 *ptr, struct tcp_out_options *opts,
-		      struct sock *sk);
+	void (*write)(__be32 *ptr, struct sk_buff *skb,
+		      struct tcp_out_options *opts, struct sock *sk);
 	int (*add_header_len)(const struct sock *listener,
 			      const struct sock *sk);
 	struct module		*owner;
@@ -2146,8 +2146,8 @@ unsigned int tcp_extra_options_prepare_req(struct sk_=
buff *skb, u8 flags,
 					   struct tcp_out_options *opts,
 					   struct request_sock *req);
 =

-void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
-			     struct sock *sk);
+void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
+			     struct tcp_out_options *opts, struct sock *sk);
 =

 int tcp_extra_options_add_header(const struct sock *listener,
 				 const struct sock *sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b822680a1709..3310e252b325 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3451,8 +3451,8 @@ unsigned int tcp_extra_options_prepare_req(struct sk_=
buff *skb, u8 flags,
 	return used;
 }
 =

-void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
-			     struct sock *sk)
+void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
+			     struct tcp_out_options *opts, struct sock *sk)
 {
 	struct tcp_extra_option_ops *entry;
 =

@@ -3461,7 +3461,7 @@ void tcp_extra_options_write(__be32 *ptr, struct tcp_=
out_options *opts,
 		if (unlikely(!entry->write))
 			continue;
 =

-		entry->write(ptr, opts, sk);
+		entry->write(ptr, skb, opts, sk);
 	}
 	rcu_read_unlock();
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f2885194ea10..522103a43941 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -526,7 +526,7 @@ static void tcp_options_write(__be32 *ptr, struct sk_bu=
ff *skb, struct sock *sk,
 	}
 =

 	if (static_branch_unlikely(&tcp_extra_options_enabled))
-		tcp_extra_options_write(ptr, opts, sk);
+		tcp_extra_options_write(ptr, skb, opts, sk);
 }
 =

 /* Compute TCP options for SYN packets. This is not the final
-- =

2.14.1


--===============3788570431320892873==--
