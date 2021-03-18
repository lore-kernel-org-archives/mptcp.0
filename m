Content-Type: multipart/mixed; boundary="===============6030062111173133167=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 2/3] mptcp: send ack for
 rm_addr
Date: Wed, 17 Mar 2021 17:08:28 -0700
Message-ID: <fdaf497d-b89b-bbb6-24ee-789dde61b1d@linux.intel.com>
In-Reply-To: CA+WQbwviKpyzH=11BFTAmDz5wpbEpaJOSvLQN-tGTM0zEXsvUg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8203

--===============6030062111173133167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Mar 2021, Geliang Tang wrote:

> Hi Mat,
>
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=
=B43=E6=9C=8817=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=888:31=E5=86=99=
=E9=81=93=EF=BC=9A
>>
>> On Tue, 16 Mar 2021, Geliang Tang wrote:
>>
>>> This patch changes the sending ACK conditions for the ADD_ADDR, send an
>>> ACK packet for RM_ADDR too.
>>>
>>> In mptcp_pm_remove_addr, invoke mptcp_pm_nl_add_addr_send_ack to send
>>> the ACK packet.
>>>
>>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>>> ---
>>> net/mptcp/pm.c         |  1 +
>>> net/mptcp/pm_netlink.c | 10 +++++-----
>>> net/mptcp/protocol.h   |  1 +
>>> 3 files changed, 7 insertions(+), 5 deletions(-)
>>>
>>
>> Thanks for the v2 update!
>>
>> The code looked ok on visual inspection, but I ran in to problems with
>> mptcp_join.sh tests (looks like the "remove id 0 address" test that
>> triggers it):
>
> Did you apply the patch (Squash to "mptcp: remove id 0 address") before
> applying this patch set? We need to apply the squash-to patch first.
>
> I didn't get this "bad unlock balance" warning on my test, could you plea=
se
> share your kconfig file to me?
>

You're right, I was testing the patch sets in separate branches. I rebased =

on the current export branch with the locking fix squashed and I'm not =

seeing the crash.

Mat


>>
>> [  286.809888] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [  286.810818] WARNING: bad unlock balance detected!
>> [  286.811921] 5.12.0-rc2+ #5 Tainted: G        W
>> [  286.813119] -------------------------------------
>> [  286.814218] pm_nl_ctl/3445 is trying to release lock (&msk->pm.lock)
>> at:
>> [  286.815822] [<ffffffffa5ede78b>] mptcp_pm_nl_addr_send_ack+0xab/0x1a0
>> [  286.816979] but there are no more locks to release!
>> [  286.817795]
>> [  286.817795] other info that might help us debug this:
>> [  286.818874] 3 locks held by pm_nl_ctl/3445:
>> [  286.819598]  #0: ffffffffa7514770 (cb_lock){++++}-{3:3}, at:
>> genl_rcv+0x10/0x30
>> [  286.820982]  #1: ffffffffa7514828 (genl_mutex){+.+.}-{3:3}, at:
>> genl_rcv_msg+0x1f5/0x2c0
>> [  286.822520]  #2: ffff888104840120 (sk_lock-AF_INET){+.+.}-{0:0}, at:
>> mptcp_nl_remove_id_zero_address+0x10f/0x280
>> [  286.824648]
>> [  286.824648] stack backtrace:
>> [  286.825355] CPU: 1 PID: 3445 Comm: pm_nl_ctl Tainted: G        W
>> 5.12.0-rc2+ #5
>> [  286.826666] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS
>> 1.14.0-1.fc33 04/01/2014
>> [  286.828234] Call Trace:
>> [  286.828688]  dump_stack+0x93/0xc2
>> [  286.829296]  lock_release.cold+0x10/0x4e
>> [  286.830000]  ? mptcp_pm_nl_addr_send_ack+0xab/0x1a0
>> [  286.830833]  ? lock_downgrade+0x390/0x390
>> [  286.831553]  ? __mptcp_flush_join_list+0x20/0x180
>> [  286.832480]  _raw_spin_unlock_bh+0x12/0x30
>> [  286.833409]  mptcp_pm_nl_addr_send_ack+0xab/0x1a0
>> [  286.834453]  mptcp_pm_remove_addr+0x7a/0xb0
>> [  286.835203]  mptcp_nl_remove_id_zero_address+0x11f/0x280
>> [  286.836204]  ? lookup_subflow_by_saddr+0x1a0/0x1a0
>> [  286.837116]  ? mptcp_nl_fill_addr+0x320/0x320
>> [  286.837848]  ? lock_release+0x1d0/0x400
>> [  286.838565]  ? lock_release+0x1d0/0x400
>> [  286.839302]  mptcp_nl_cmd_del_addr+0x497/0x5e0
>> [  286.840130]  ? mptcp_pm_remove_anno_addr.isra.0+0x180/0x180
>> [  286.841165]  ? nla_get_range_signed+0x1c0/0x1c0
>> [  286.842053]  ? lock_is_held_type+0x98/0x110
>> [  286.842820]  ? __nla_parse+0x22/0x30
>> [  286.843503]  ? genl_family_rcv_msg_attrs_parse.constprop.0+0xd1/0x130
>> [  286.844739]  genl_family_rcv_msg_doit+0x17a/0x200
>> [  286.845641]  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x130/0x130
>> [  286.847167]  ? security_capable+0x48/0x60
>> [  286.848086]  genl_rcv_msg+0x18d/0x2c0
>> [  286.848873]  ? genl_get_cmd+0x1b0/0x1b0
>> [  286.849780]  ? genl_rcv+0x10/0x30
>> [  286.850730]  ? mptcp_pm_remove_anno_addr.isra.0+0x180/0x180
>> [  286.852074]  ? netlink_deliver_tap+0xa6/0x570
>> [  286.852801]  netlink_rcv_skb+0xc4/0x1f0
>> [  286.853434]  ? find_held_lock+0x85/0xa0
>> [  286.854074]  ? genl_get_cmd+0x1b0/0x1b0
>> [  286.854713]  ? netlink_ack+0x4f0/0x4f0
>> [  286.855336]  genl_rcv+0x1f/0x30
>> [  286.855863]  netlink_unicast+0x2d3/0x410
>> [  286.856516]  ? netlink_attachskb+0x400/0x400
>> [  286.857219]  ? _copy_from_iter_full+0xd8/0x360
>> [  286.857986]  netlink_sendmsg+0x394/0x670
>> [  286.858644]  ? netlink_unicast+0x410/0x410
>> [  286.859343]  ? netlink_unicast+0x410/0x410
>> [  286.860256]  sock_sendmsg+0x91/0xa0
>> [  286.861032]  __sys_sendto+0x16e/0x210
>> [  286.861881]  ? __ia32_sys_getpeername+0x40/0x40
>> [  286.862902]  ? handle_mm_fault+0x103/0x270
>> [  286.863807]  ? do_user_addr_fault+0x3f0/0x950
>> [  286.864781]  ? trace_page_fault_kernel+0x110/0x110
>> [  286.865862]  ? mark_held_locks+0x24/0x90
>> [  286.866777]  __x64_sys_sendto+0x6f/0x80
>> [  286.867621]  do_syscall_64+0x33/0x40
>> [  286.868504]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  286.869788] RIP: 0033:0x7f1279a1014a
>> [  286.870857] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 =
0f
>> 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05
>> <48> 3d 00 f0 ff ff 77 76 c3 0f 1f 44 00 00 55 48 83 ec 30 44 89 4c
>> [  286.875110] RSP: 002b:00007ffe1a791af8 EFLAGS: 00000246 ORIG_RAX: 000=
000000000002c
>> [  286.876758] RAX: ffffffffffffffda RBX: 00007ffe1a791b40 RCX: 00007f12=
79a1014a
>> [  286.878317] RDX: 0000000000000030 RSI: 00007ffe1a791b40 RDI: 00000000=
00000003
>> [  286.879885] RBP: 0000000000000030 R08: 00007ffe1a791b04 R09: 00000000=
0000000c
>> [  286.881537] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
>> [  286.883189] R13: 0000000000000003 R14: 0000000000000000 R15: 00000000=
00000000
>>
>>
>> --
>> Mat Martineau
>> Intel
>

--
Mat Martineau
Intel

--===============6030062111173133167==--
