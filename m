Content-Type: multipart/mixed; boundary="===============1815193373811449484=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix tcp fallback crash
Date: Tue, 31 Mar 2020 14:34:15 +0200
Message-ID: <20200331123415.GG23604@breakpoint.cc>
In-Reply-To: a493819f742ffa9cf6e8fe5a58111eb8d013c930.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4116

--===============1815193373811449484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Davide Caratti <dcaratti(a)redhat.com> wrote:
> On Tue, 2020-03-31 at 13:19 +0200, Florian Westphal wrote:
> > Christoph Paasch reports following crash:
> > =

> > general protection fault, probably for non-canonical address 0xfe85e717=
fe88a633: 0000 [#1] PREEMPT SMP
> > CPU: 0 PID: 2874 Comm: syz-executor072 Not tainted 5.6.0-rc5 #62
> > RIP: 0010:__pv_queued_spin_lock_slowpath+0x1b3/0x2f0 kernel/locking/qsp=
inlock.c:471
> > [..]
> >  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
> >  do_raw_spin_lock include/linux/spinlock.h:181 [inline]
> >  spin_lock_bh include/linux/spinlock.h:343 [inline]
> >  __mptcp_flush_join_list+0x44/0xb0 net/mptcp/protocol.c:278
> >  mptcp_shutdown+0xb3/0x230 net/mptcp/protocol.c:1882
> > [..]
> > =

> > Problem is that mptcp_shutdown() socket isn't an mptcp socket,
> > its a plain tcp_sk.  Thus, trying to access mptcp_sk specific
> > members accesses garbage.
> > =

> > Root cause is that accept() returns a fallback (tcp) socket,
> > not an mptcp one.  There is code in getpeername to detect this
> > and override the sockets stream_ops.  But this will only run when
> > accept() caller provided a sockaddr struct.  "accept(fd, NULL, 0)"
> > will therefore result in mptcp stream ops, with sock->sk being a
> > tcp_sk.  Update the existing fallback handling to detect this as well.
> > =

> > Moreover, mptcp_shutdown did not have fallback handling, and
> > mptcp_poll did it too late so add that there as well.
> =

> hi Florian,
> =

> maybe there is still a point where the NULL dereference can happen, in
> mptcp_sendmsg()

Not because of this specific problem.

>  730         lock_sock(ssk);
>  731         while (msg_data_left(msg)) {
>  732                 ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &time=
o, &mss_now,
>  733                                          &size_goal);
>  734                 if (ret < 0)
>  735                         break;
>  736                 if (ret =3D=3D 0 && unlikely(__mptcp_needs_tcp_fallb=
ack(msk))) {
>  737                         release_sock(ssk);
>  738                         ssock =3D __mptcp_tcp_fallback(msk);
>  739                         goto fallback; <--- can ssock can be NULL he=
re?
>  740                 }

It looks odd, yes.  I propose this separate patch:

Subject: mptcp: consistently retry tcp fallback lookup

There is confusion about when we can assume that the fallback socket
is non-null.  Handle this consistently and do a full re-lookup.

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -734,9 +734,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 			goto out;
 	}
 =

+fallback:
 	ssock =3D __mptcp_tcp_fallback(msk);
 	if (unlikely(ssock)) {
-fallback:
 		pr_debug("fallback passthrough");
 		ret =3D sock_sendmsg(ssock, msg);
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
@@ -779,7 +779,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 			break;
 		if (ret =3D=3D 0 && unlikely(__mptcp_needs_tcp_fallback(msk))) {
 			release_sock(ssk);
-			ssock =3D __mptcp_tcp_fallback(msk);
 			goto fallback;
 		}
 =

@@ -889,9 +888,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		return -EOPNOTSUPP;
 =

 	lock_sock(sk);
+fallback:
 	ssock =3D __mptcp_tcp_fallback(msk);
 	if (unlikely(ssock)) {
-fallback:
 		pr_debug("fallback-read subflow=3D%p",
 			 mptcp_subflow_ctx(ssock->sk));
--===============1815193373811449484==--
