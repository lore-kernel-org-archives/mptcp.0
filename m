Content-Type: multipart/mixed; boundary="===============6264367217499714012=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix tcp fallback crash
Date: Tue, 31 Mar 2020 13:58:47 +0200
Message-ID: <a493819f742ffa9cf6e8fe5a58111eb8d013c930.camel@redhat.com>
In-Reply-To: 20200331111926.13919-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4115

--===============6264367217499714012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-31 at 13:19 +0200, Florian Westphal wrote:
> Christoph Paasch reports following crash:
> =

> general protection fault, probably for non-canonical address 0xfe85e717fe=
88a633: 0000 [#1] PREEMPT SMP
> CPU: 0 PID: 2874 Comm: syz-executor072 Not tainted 5.6.0-rc5 #62
> RIP: 0010:__pv_queued_spin_lock_slowpath+0x1b3/0x2f0 kernel/locking/qspin=
lock.c:471
> [..]
>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
>  do_raw_spin_lock include/linux/spinlock.h:181 [inline]
>  spin_lock_bh include/linux/spinlock.h:343 [inline]
>  __mptcp_flush_join_list+0x44/0xb0 net/mptcp/protocol.c:278
>  mptcp_shutdown+0xb3/0x230 net/mptcp/protocol.c:1882
> [..]
> =

> Problem is that mptcp_shutdown() socket isn't an mptcp socket,
> its a plain tcp_sk.  Thus, trying to access mptcp_sk specific
> members accesses garbage.
> =

> Root cause is that accept() returns a fallback (tcp) socket,
> not an mptcp one.  There is code in getpeername to detect this
> and override the sockets stream_ops.  But this will only run when
> accept() caller provided a sockaddr struct.  "accept(fd, NULL, 0)"
> will therefore result in mptcp stream ops, with sock->sk being a
> tcp_sk.  Update the existing fallback handling to detect this as well.
> =

> Moreover, mptcp_shutdown did not have fallback handling, and
> mptcp_poll did it too late so add that there as well.

hi Florian,

maybe there is still a point where the NULL dereference can happen, in
mptcp_sendmsg()

 730         lock_sock(ssk);
 731         while (msg_data_left(msg)) {
 732                 ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo,=
 &mss_now,
 733                                          &size_goal);
 734                 if (ret < 0)
 735                         break;
 736                 if (ret =3D=3D 0 && unlikely(__mptcp_needs_tcp_fallbac=
k(msk))) {
 737                         release_sock(ssk);
 738                         ssock =3D __mptcp_tcp_fallback(msk);
 739                         goto fallback; <--- can ssock can be NULL here?
 740                 }
 741 =

 742                 copied +=3D ret;
 743         }

wdyt?

-- =

davide

--===============6264367217499714012==--
