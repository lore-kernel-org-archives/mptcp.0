Content-Type: multipart/mixed; boundary="===============4422943125750266269=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 03/12] mptcp: Remove RPS-recording for flow-steering
 in MPTCP
Date: Wed, 05 Dec 2018 17:00:14 -0800
Message-ID: <20181206010023.18819-4-cpaasch@apple.com>
In-Reply-To: 20181206010023.18819-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 876

--===============4422943125750266269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's an optimization. We don't need it!

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/af_inet.c |  6 ------
 net/ipv4/tcp.c     | 34 ----------------------------------
 2 files changed, 40 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 6b510da0086d..e95f6ac342ff 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -744,12 +744,6 @@ int inet_accept(struct socket *sock, struct socket *ne=
wsock, int flags,
 	sock_rps_record_flow(sk2);
 =

 	if (sk2->sk_protocol =3D=3D IPPROTO_TCP && mptcp(tcp_sk(sk2))) {
-		struct mptcp_tcp_sock *mptcp;
-
-		mptcp_for_each_sub(tcp_sk(sk2)->mpcb, mptcp) {
-			sock_rps_record_flow(mptcp_to_sock(mptcp));
-		}
-
 		if (tcp_sk(sk2)->mpcb->master_sk) {
 			struct sock *sk_it =3D tcp_sk(sk2)->mpcb->master_sk;
 =

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b8a60db7fb7a..213be064adde 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -821,16 +821,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *p=
pos,
 =

 	lock_sock(sk);
 =

-#ifdef CONFIG_MPTCP
-	if (mptcp(tcp_sk(sk))) {
-		struct mptcp_tcp_sock *mptcp;
-
-		mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
-			sock_rps_record_flow(mptcp_to_sock(mptcp));
-		}
-	}
-#endif
-
 	timeo =3D sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
 	while (tss.len) {
 		ret =3D __tcp_splice_read(sk, &tss);
@@ -995,8 +985,6 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *=
page, int offset,
 	}
 =

 	if (mptcp(tp)) {
-		struct mptcp_tcp_sock *mptcp;
-
 		/* We must check this with socket-lock hold because we iterate
 		 * over the subflows.
 		 */
@@ -1009,10 +997,6 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page=
 *page, int offset,
 			lock_sock(sk);
 			return ret;
 		}
-
-		mptcp_for_each_sub(tp->mpcb, mptcp) {
-			sock_rps_record_flow(mptcp_to_sock(mptcp));
-		}
 	}
 =

 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
@@ -1290,14 +1274,6 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghd=
r *msg, size_t size)
 			goto do_error;
 	}
 =

-	if (mptcp(tp)) {
-		struct mptcp_tcp_sock *mptcp;
-
-		mptcp_for_each_sub(tp->mpcb, mptcp) {
-			sock_rps_record_flow(mptcp_to_sock(mptcp));
-		}
-	}
-
 	if (unlikely(tp->repair)) {
 		if (tp->repair_queue =3D=3D TCP_RECV_QUEUE) {
 			copied =3D tcp_send_rcvq(sk, msg, size);
@@ -2022,16 +1998,6 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg,=
 size_t len, int nonblock,
 =

 	lock_sock(sk);
 =

-#ifdef CONFIG_MPTCP
-	if (mptcp(tp)) {
-		struct mptcp_tcp_sock *mptcp;
-
-		mptcp_for_each_sub(tp->mpcb, mptcp) {
-			sock_rps_record_flow(mptcp_to_sock(mptcp));
-		}
-	}
-#endif
-
 	err =3D -ENOTCONN;
 	if (sk->sk_state =3D=3D TCP_LISTEN)
 		goto out;
-- =

2.16.2


--===============4422943125750266269==--
