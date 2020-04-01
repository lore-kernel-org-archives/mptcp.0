Content-Type: multipart/mixed; boundary="===============5912308308082516145=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix tcp fallback crash
Date: Wed, 01 Apr 2020 18:33:52 +0200
Message-ID: <391254f4-35dd-ec2c-a6dc-52f35af371e7@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2003311701290.28972@ldelcroi-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4122

--===============5912308308082516145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat, Christoph,

On 01/04/2020 02:02, Mat Martineau wrote:
> On Tue, 31 Mar 2020, Florian Westphal wrote:
> =

>> Christoph Paasch reports following crash:
>>
>> general protection fault, probably for non-canonical address =

>> 0xfe85e717fe88a633: 0000 [#1] PREEMPT SMP
>> CPU: 0 PID: 2874 Comm: syz-executor072 Not tainted 5.6.0-rc5 #62
>> RIP: 0010:__pv_queued_spin_lock_slowpath+0x1b3/0x2f0 =

>> kernel/locking/qspinlock.c:471
>> [..]
>> queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
>> do_raw_spin_lock include/linux/spinlock.h:181 [inline]
>> spin_lock_bh include/linux/spinlock.h:343 [inline]
>> __mptcp_flush_join_list+0x44/0xb0 net/mptcp/protocol.c:278
>> mptcp_shutdown+0xb3/0x230 net/mptcp/protocol.c:1882
>> [..]
>>
>> Problem is that mptcp_shutdown() socket isn't an mptcp socket,
>> its a plain tcp_sk.=C2=A0 Thus, trying to access mptcp_sk specific
>> members accesses garbage.
>>
>> Root cause is that accept() returns a fallback (tcp) socket,
>> not an mptcp one.=C2=A0 There is code in getpeername to detect this
>> and override the sockets stream_ops.=C2=A0 But this will only run when
>> accept() caller provided a sockaddr struct.=C2=A0 "accept(fd, NULL, 0)"
>> will therefore result in mptcp stream ops, with sock->sk being a
>> tcp_sk.=C2=A0 Update the existing fallback handling to detect this as we=
ll.
>>
>> Moreover, mptcp_shutdown did not have fallback handling, and
>> mptcp_poll did it too late so add that there as well.
>>
>> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>> ---
>> net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++++++++++++++----
>> 1 file changed, 46 insertions(+), 4 deletions(-)
>>
> =

> Looks good to me, thanks Florian.
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thank you for the patch, the review, the bug report and the test!

- 1367f91c2e4a: mptcp: fix tcp fallback crash
- 57580002e381: tg: remove accidental signed-off

I just added this patch at the end of the series (export branch)

Tests are all green on my side!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5912308308082516145==--
