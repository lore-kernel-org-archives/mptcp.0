Content-Type: multipart/mixed; boundary="===============2437118480628444571=="
MIME-Version: 1.0
From: Hillf Danton <hdanton at sina.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING: bad unlock balance in mptcp_shutdown
Date: Sun, 12 Apr 2020 11:29:40 +0800
Message-ID: <20200412032940.10044-1-hdanton@sina.com>
In-Reply-To: 000000000000adb83a05a30aaa04@google.com
X-Status: 
X-Keywords:                  
X-UID: 4155

--===============2437118480628444571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Sun, 12 Apr 2020 00:43:37 +0200 Florian Westphal wrote:
> =

> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17a5dbfbe00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dca75979eeeb=
f06c2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D6ebb6d4830e8f=
8815623
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > =

> > Unfortunately, I don't have any reproducer for this crash yet.
> > =

> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+6ebb6d4830e8f8815623(a)syzkaller.appspotmail.com
> > =

> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: bad unlock balance detected!
> > 5.6.0-syzkaller #0 Not tainted
> > -------------------------------------
> > syz-executor.5/2215 is trying to release lock (sk_lock-AF_INET6) at:
> > [<ffffffff87c5203b>] mptcp_shutdown+0x38b/0x550 net/mptcp/protocol.c:18=
89
> > but there are no more locks to release!
> > =

> > other info that might help us debug this:
> > 1 lock held by syz-executor.5/2215:
> >  #0: ffff88804a22eda0 (slock-AF_INET6){+.-.}-{2:2}, at: spin_lock_bh in=
clude/linux/spinlock.h:358 [inline]
> >  #0: ffff88804a22eda0 (slock-AF_INET6){+.-.}-{2:2}, at: release_sock+0x=
1b/0x1b0 net/core/sock.c:2974
> =

> I think this is same issue as the other report, so:
> =

> #syz dup: WARNING: bad unlock balance in mptcp_poll

Add a couple of lines to check if sk lock is released behind eye balls
in the path of mptcp poll, and shutdown as well, assuming it's not
going to make the current sk locking acheme worse.

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -98,8 +98,9 @@ static struct socket *__mptcp_tcp_fallba
 		return NULL;
 =

 	if (msk->subflow) {
+		sock =3D msk->subflow;
 		release_sock((struct sock *)msk);
-		return msk->subflow;
+		return sock;
 	}
 =

 	return NULL;
@@ -1843,17 +1844,19 @@ static __poll_t mptcp_poll(struct file *
 {
 	struct sock *sk =3D sock->sk;
 	struct mptcp_sock *msk;
-	struct socket *ssock;
+	struct socket *ssock, *subflow;
 	__poll_t mask =3D 0;
 =

 	msk =3D mptcp_sk(sk);
 	lock_sock(sk);
+	subflow =3D msk->subflow;
 	ssock =3D __mptcp_tcp_fallback(msk);
 	if (!ssock)
 		ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock) {
 		mask =3D ssock->ops->poll(file, ssock, wait);
-		release_sock(sk);
+		if (ssock !=3D subflow)
+			release_sock(sk);
 		return mask;
 	}
 =

@@ -1878,15 +1881,17 @@ static int mptcp_shutdown(struct socket
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct mptcp_subflow_context *subflow;
-	struct socket *ssock;
+	struct socket *ssock, *subf_sock;
 	int ret =3D 0;
 =

 	pr_debug("sk=3D%p, how=3D%d", msk, how);
 =

 	lock_sock(sock->sk);
+	subf_sock =3D msk->subflow;
 	ssock =3D __mptcp_tcp_fallback(msk);
 	if (ssock) {
-		release_sock(sock->sk);
+		if (ssock !=3D subf_sock)
+			release_sock(sock->sk);
 		return inet_shutdown(ssock, how);
 	}
=20

--===============2437118480628444571==--
