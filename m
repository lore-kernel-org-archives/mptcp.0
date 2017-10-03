Content-Type: multipart/mixed; boundary="===============0010361121771731110=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 07/18] tcp_extra_option: add_header callback for TCP
 extra options
Date: Tue, 03 Oct 2017 09:21:53 -0700
Message-ID: <20171003162204.17945-8-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 89

--===============0010361121771731110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Extra options need to be accounted in tcp_header_len of tcp_sock.
Thus, we need another callback for this as well.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/tcp.h        |  5 +++++
 net/ipv4/tcp.c           | 18 ++++++++++++++++++
 net/ipv4/tcp_minisocks.c |  3 +++
 net/ipv4/tcp_output.c    |  3 +++
 4 files changed, 29 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 676ae8991e7f..641b1cf71528 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2126,6 +2126,8 @@ struct tcp_extra_option_ops {
 				    struct request_sock *req);
 	void (*write)(__be32 *ptr, struct tcp_out_options *opts,
 		      struct tcp_sock *tp);
+	int (*add_header_len)(const struct sock *listener,
+			      const struct sock *sk);
 	struct module		*owner;
 };
 =

@@ -2147,6 +2149,9 @@ unsigned int tcp_extra_options_prepare_req(struct sk_=
buff *skb, u8 flags,
 void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
 			     struct tcp_sock *tp);
 =

+int tcp_extra_options_add_header(const struct sock *listener,
+				 const struct sock *sk);
+
 int tcp_register_extra_option(struct tcp_extra_option_ops *ops);
 void tcp_unregister_extra_option(struct tcp_extra_option_ops *ops);
 =

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82b022d5f215..7ecd1ffdf3ad 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3466,6 +3466,24 @@ void tcp_extra_options_write(__be32 *ptr, struct tcp=
_out_options *opts,
 	rcu_read_unlock();
 }
 =

+int tcp_extra_options_add_header(const struct sock *listener,
+				 const struct sock *sk)
+{
+	struct tcp_extra_option_ops *entry;
+	int tcp_header_len =3D 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (unlikely(!entry->add_header_len))
+			continue;
+
+		tcp_header_len +=3D entry->add_header_len(listener, sk);
+	}
+	rcu_read_unlock();
+
+	return tcp_header_len;
+}
+
 int tcp_register_extra_option(struct tcp_extra_option_ops *ops)
 {
 	int ret =3D 0;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1c3e91899dac..2b1683611898 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -525,6 +525,9 @@ struct sock *tcp_create_openreq_child(const struct sock=
 *sk,
 		if (newtp->af_specific->md5_lookup(sk, newsk))
 			newtp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
 #endif
+		if (static_branch_unlikely(&tcp_extra_options_enabled))
+			newtp->tcp_header_len +=3D tcp_extra_options_add_header(sk, newsk);
+
 		if (skb->len >=3D TCP_MSS_DEFAULT + newtp->tcp_header_len)
 			newicsk->icsk_ack.last_seg_size =3D skb->len - newtp->tcp_header_len;
 		newtp->rx_opt.mss_clamp =3D req->mss;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c4089202e686..60b3b85ff2d3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3250,6 +3250,9 @@ static void tcp_connect_init(struct sock *sk)
 		tp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
 #endif
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tp->tcp_header_len +=3D tcp_extra_options_add_header(sk, sk);
+
 	/* If user gave his TCP_MAXSEG, record it to clamp */
 	if (tp->rx_opt.user_mss)
 		tp->rx_opt.mss_clamp =3D tp->rx_opt.user_mss;
-- =

2.14.1


--===============0010361121771731110==--
