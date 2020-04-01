Content-Type: multipart/mixed; boundary="===============0193171888141196142=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix tcp fallback crash
Date: Tue, 31 Mar 2020 17:02:33 -0700
Message-ID: <alpine.OSX.2.22.394.2003311701290.28972@ldelcroi-mobl1.amr.corp.intel.com>
In-Reply-To: 20200331111926.13919-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4119

--===============0193171888141196142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Mar 2020, Florian Westphal wrote:

> Christoph Paasch reports following crash:
>
> general protection fault, probably for non-canonical address 0xfe85e717fe=
88a633: 0000 [#1] PREEMPT SMP
> CPU: 0 PID: 2874 Comm: syz-executor072 Not tainted 5.6.0-rc5 #62
> RIP: 0010:__pv_queued_spin_lock_slowpath+0x1b3/0x2f0 kernel/locking/qspin=
lock.c:471
> [..]
> queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
> do_raw_spin_lock include/linux/spinlock.h:181 [inline]
> spin_lock_bh include/linux/spinlock.h:343 [inline]
> __mptcp_flush_join_list+0x44/0xb0 net/mptcp/protocol.c:278
> mptcp_shutdown+0xb3/0x230 net/mptcp/protocol.c:1882
> [..]
>
> Problem is that mptcp_shutdown() socket isn't an mptcp socket,
> its a plain tcp_sk.  Thus, trying to access mptcp_sk specific
> members accesses garbage.
>
> Root cause is that accept() returns a fallback (tcp) socket,
> not an mptcp one.  There is code in getpeername to detect this
> and override the sockets stream_ops.  But this will only run when
> accept() caller provided a sockaddr struct.  "accept(fd, NULL, 0)"
> will therefore result in mptcp stream ops, with sock->sk being a
> tcp_sk.  Update the existing fallback handling to detect this as well.
>
> Moreover, mptcp_shutdown did not have fallback handling, and
> mptcp_poll did it too late so add that there as well.
>
> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 46 insertions(+), 4 deletions(-)
>

Looks good to me, thanks Florian.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============0193171888141196142==--
