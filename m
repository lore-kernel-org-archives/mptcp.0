Content-Type: multipart/mixed; boundary="===============2131694484787008060=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] general protection fault in
 __mptcp_flush_join_list
Date: Tue, 31 Mar 2020 12:35:31 +0200
Message-ID: <20200331103531.GF23604@breakpoint.cc>
In-Reply-To: 20200329181412.GB14672@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4113

--===============2131694484787008060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch <cpaasch(a)apple.com> wrote:
> another one - on top of 402d1b0dc2e1 (yes, it's a week old - I wanted to
> let syzkaller deep-dive a bit).
> =

> general protection fault, probably for non-canonical address 0xfe85e717fe=
88a633: 0000 [#1] PREEMPT SMP
> CPU: 0 PID: 2874 Comm: syz-executor072 Not tainted 5.6.0-rc5 #62
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-=
ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__write_once_size include/linux/compiler.h:226 [inline]
> RIP: 0010:__pv_queued_spin_lock_slowpath+0x1b3/0x2f0 kernel/locking/qspin=
lock.c:471
> Code: c5 c1 ea 12 41 bf 01 00 00 00 8d 42 ff 41 83 e5 03 4c 8d 73 14 49 c=
1 e5 05 48 98 49 81 c5 00 bf 02 00 4c 03 2c c5 a0 11 86 82 <49> 89 5d 00 b8=
 00 80 00 00 eb 14 84 c0 75 09 41 0f b6 55 14 84 d2
> RSP: 0018:ffffc9000017bdf8 EFLAGS: 00010286
> RAX: 000000000000130d RBX: ffff88807dc2bf00 RCX: 0000000000000001
> RDX: 000000000000130e RSI: 0000000000000000 RDI: 0000000000000005
> RBP: ffffc9000017be30 R08: ffff88807b6a11c0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807b783844
> R13: fe85e717fe88a633 R14: ffff88807dc2bf14 R15: 0000000000000001
> FS:  00007f8886bbe700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000558feddd6040 CR3: 000000007d668002 CR4: 0000000000160ef0
> Call Trace:
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:645 [inline]
>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:81 [inline]
>  do_raw_spin_lock include/linux/spinlock.h:181 [inline]
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
>  _raw_spin_lock_bh+0x36/0x40 kernel/locking/spinlock.c:175
>  spin_lock_bh include/linux/spinlock.h:343 [inline]
>  __mptcp_flush_join_list+0x44/0xb0 net/mptcp/protocol.c:278

We enter here with msk =3D=3D tcp_sk, so not surprising that this crashes.

Following patch fixes this for me, test cases still pass.
I don't see a better solution at the moment.

The patch only requires a minor change on top to avoid build barf with
IV6=3Dn.

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -57,10 +57,41 @@ static bool __mptcp_needs_tcp_fallback(const struct mpt=
cp_sock *msk)
 	return msk->first && !sk_is_mptcp(msk->first);
 }
 =

+static struct socket *mptcp_is_tcpsk(struct sock *sk)
+{
+	struct socket *sock =3D sk->sk_socket;
+
+	if (sock->sk !=3D sk)
+		return NULL;
+
+	if (unlikely(sk->sk_prot =3D=3D &tcp_prot)) {
+		/* we are being invoked after mptcp_accept() has
+		 * accepted a non-mp-capable flow: sk is a tcp_sk,
+		 * not an mptcp one.
+		 *
+		 * Hand the socket over to tcp so all further socket ops
+		 * bypass mptcp.
+		 */
+		sock->ops =3D &inet_stream_ops;
+		return sock;
+	} else if (unlikely(sk->sk_prot =3D=3D &tcpv6_prot)) {
+		sock->ops =3D &inet6_stream_ops;
+		return sock;
+	}
+
+	return NULL;
+}
+
 static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
+	struct socket *sock;
+
 	sock_owned_by_me((const struct sock *)msk);
 =

+	sock =3D mptcp_is_tcpsk((struct sock *)msk);
+	if (unlikely(sock))
+		return sock;
+
 	if (likely(!__mptcp_needs_tcp_fallback(msk)))
 		return NULL;
 =

@@ -84,6 +115,10 @@ static struct socket *__mptcp_socket_create(struct mptc=
p_sock *msk, int state)
 	struct socket *ssock;
 	int err;
 =

+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (unlikely(ssock))
+		return ssock;
+
 	ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock)
 		goto set_state;
@@ -1820,7 +1855,9 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 =

 	msk =3D mptcp_sk(sk);
 	lock_sock(sk);
-	ssock =3D __mptcp_nmpc_socket(msk);
+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (!ssock)
+		ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock) {
 		mask =3D ssock->ops->poll(file, ssock, wait);
 		release_sock(sk);
@@ -1830,9 +1867,6 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 	release_sock(sk);
 	sock_poll_wait(file, sock, wait);
 	lock_sock(sk);
-	ssock =3D __mptcp_tcp_fallback(msk);
-	if (unlikely(ssock))
-		return ssock->ops->poll(file, ssock, NULL);
 =

 	if (test_bit(MPTCP_DATA_READY, &msk->flags))
 		mask =3D EPOLLIN | EPOLLRDNORM;
@@ -1851,11 +1885,17 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct mptcp_subflow_context *subflow;
+	struct socket *ssock;
 	int ret =3D 0;
 =

 	pr_debug("sk=3D%p, how=3D%d", msk, how);
 =

 	lock_sock(sock->sk);
+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (ssock) {
+		release_sock(sock->sk);
+		return inet_shutdown(ssock, how);
+	}
 =

 	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
 		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
--===============2131694484787008060==--
