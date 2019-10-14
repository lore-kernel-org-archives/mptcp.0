Content-Type: multipart/mixed; boundary="===============4228931016451978036=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/6] net: tcp: add __tcp_poll helper
Date: Tue, 15 Oct 2019 01:19:16 +0200
Message-ID: <20191014231919.2454-4-fw@strlen.de>
In-Reply-To: 20191014231919.2454-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2125

--===============4228931016451978036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MPTCP will need to be able to call tcp_poll to check if the tcp socket is
available for reading/writing, but without adding the task to the waitlist.

This splits tcp_poll into two functions so __tcp_poll can be called by
mptcp in followup patch.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/tcp.h |  1 +
 net/ipv4/tcp.c    | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7f254765074f..e9dcf6806877 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -396,6 +396,7 @@ void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op);
 __poll_t tcp_poll(struct file *file, struct socket *sock,
 		      struct poll_table_struct *wait);
+__poll_t __tcp_poll(struct sock *sk);
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 int tcp_setsockopt(struct sock *sk, int level, int optname,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 70402e5882fa..d149fcb2dcc9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -490,15 +490,12 @@ static inline bool tcp_stream_is_readable(const struc=
t tcp_sock *tp,
  *	take care of normal races (between the test and the event) and we don't
  *	go look at any of the socket buffers directly.
  */
-__poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
+__poll_t __tcp_poll(struct sock *sk)
 {
 	__poll_t mask;
-	struct sock *sk =3D sock->sk;
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 	int state;
 =

-	sock_poll_wait(file, sock, wait);
-
 	state =3D inet_sk_state_load(sk);
 	if (state =3D=3D TCP_LISTEN)
 		return inet_csk_listen_poll(sk);
@@ -590,6 +587,13 @@ __poll_t tcp_poll(struct file *file, struct socket *so=
ck, poll_table *wait)
 =

 	return mask;
 }
+
+__poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	sock_poll_wait(file, sock, wait);
+
+	return __tcp_poll(sock->sk);
+}
 EXPORT_SYMBOL(tcp_poll);
 =

 int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
-- =

2.21.0

--===============4228931016451978036==--
