Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585026ED25
	for <mptcp@lists.linux.dev>; Thu, 15 Jan 2026 04:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768452970; cv=none; b=SkW3TVJN0AacTMQMy7+1mB/cqCwnCvlD2eVXPyKivIh0hHo3SXcndpZKl1xwD/o8CbJuKBSZ5aa0pKIhfRcagPt/7EX5ztL3r5VH7h/ROx7MML33Uqy8QzRoxbp95gz4FMDCEro2jA6K65xm+vNyiA3UDUOOKWdZCcjt75/hZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768452970; c=relaxed/simple;
	bh=ZFmdhxg454RLVhrPjaEoYzpi3Iv0XMv/chK+3HybxM8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ld+re6E5JnSzqK5GO9dAIvAAoTeAFZJa9H8sikoYmH/QMq32lSITS/mWqm60bQTU3qQJrBzcmU6XcTqZa8hPk7HQtaUN5GPncnwirwfWVvxv/7MqWaZtjm13zP7ugqLM6YasJqf9GZgalA5zGxCNroVmAkxCshJryhOmGsRNy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flsY2NB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flsY2NB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA38AC116D0;
	Thu, 15 Jan 2026 04:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768452970;
	bh=ZFmdhxg454RLVhrPjaEoYzpi3Iv0XMv/chK+3HybxM8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=flsY2NB3Png100f13n9jNJd7HTGzBn64MKFQsAx1LiTr6IpScfcHyRIxXRpQalvu5
	 K+IxUOyuBtarBBl98gsS09dQ6G881KYWPfRnZz785bdo2TmJpSKj4sXTpAx9rFKu02
	 3afSY3G23qo2dGgDdppg878uVpTQmUV6fQFuOnbJEKL7TgpOlDhVocuKWMphe/AWlt
	 A1FQLSRf+R6m4zF6nQ9nVDOFE8coD9zAvqN9iRytbqaRUIQWbGC0bbfIriCBQ7ZVW4
	 007o+tUX6ntnXPPDo2o385iDsK1/z8+vFkgbNqNO7TqdZ86sSfkA9RIbCvFybloyS2
	 TvxkrMFTpvxRg==
Date: Wed, 14 Jan 2026 20:56:09 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
    syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com
Subject: Re: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: always set as unavail
 when removing addr
In-Reply-To: <20251215-issue-606-mark-subflow-endp-avail-v1-1-2f1b36da8993@kernel.org>
Message-ID: <2059f374-0447-30ff-92ff-b090fd91504d@kernel.org>
References: <20251215-issue-606-mark-subflow-endp-avail-v1-0-2f1b36da8993@kernel.org> <20251215-issue-606-mark-subflow-endp-avail-v1-1-2f1b36da8993@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 15 Dec 2025, Matthieu Baerts (NGI0) wrote:

> Syzkaller managed to find a combination of actions that was generating
> this warning:
>
>  WARNING: net/mptcp/pm_kernel.c:1074 at __mark_subflow_endp_available net/mptcp/pm_kernel.c:1074 [inline], CPU#1: syz.7.48/2535
>  WARNING: net/mptcp/pm_kernel.c:1074 at mptcp_pm_nl_fullmesh net/mptcp/pm_kernel.c:1446 [inline], CPU#1: syz.7.48/2535
>  WARNING: net/mptcp/pm_kernel.c:1074 at mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1474 [inline], CPU#1: syz.7.48/2535
>  WARNING: net/mptcp/pm_kernel.c:1074 at mptcp_pm_nl_set_flags+0x5de/0x640 net/mptcp/pm_kernel.c:1538, CPU#1: syz.7.48/2535
>  Modules linked in:
>  CPU: 1 UID: 0 PID: 2535 Comm: syz.7.48 Not tainted 6.18.0-03987-gea5f5e676cf5 #17 PREEMPT(voluntary)
>  Hardware name: QEMU Ubuntu 25.10 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>  RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_kernel.c:1074 [inline]
>  RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_kernel.c:1446 [inline]
>  RIP: 0010:mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1474 [inline]
>  RIP: 0010:mptcp_pm_nl_set_flags+0x5de/0x640 net/mptcp/pm_kernel.c:1538
>  Code: 89 c7 e8 c5 8c 73 fe e9 f7 fd ff ff 49 83 ef 80 e8 b7 8c 73 fe 4c 89 ff be 03 00 00 00 e8 4a 29 e3 fe eb ac e8 a3 8c 73 fe 90 <0f> 0b 90 e9 3d ff ff ff e8 95 8c 73 fe b8 a1 ff ff ff eb 1a e8 89
>  RSP: 0018:ffffc9001535b820 EFLAGS: 00010287
>  netdevsim0: tun_chr_ioctl cmd 1074025677
>  RAX: ffffffff82da294d RBX: 0000000000000001 RCX: 0000000000080000
>  RDX: ffffc900096d0000 RSI: 00000000000006d6 RDI: 00000000000006d7
>  netdevsim0: linktype set to 823
>  RBP: ffff88802cdb2240 R08: 00000000000104ae R09: ffffffffffffffff
>  R10: ffffffff82da27d4 R11: 0000000000000000 R12: 0000000000000000
>  R13: ffff88801246d8c0 R14: ffffc9001535b8b8 R15: ffff88802cdb1800
>  FS:  00007fc6ac5a76c0(0000) GS:ffff8880f90c8000(0000) knlGS:0000000000000000
>  netlink: 'syz.3.50': attribute type 5 has an invalid length.
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  netlink: 1232 bytes leftover after parsing attributes in process `syz.3.50'.
>  CR2: 0000200000010000 CR3: 0000000025b1a000 CR4: 0000000000350ef0
>  Call Trace:
>   <TASK>
>   mptcp_pm_set_flags net/mptcp/pm_netlink.c:277 [inline]
>   mptcp_pm_nl_set_flags_doit+0x1d7/0x210 net/mptcp/pm_netlink.c:282
>   genl_family_rcv_msg_doit+0x117/0x180 net/netlink/genetlink.c:1115
>   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>   genl_rcv_msg+0x3a8/0x3f0 net/netlink/genetlink.c:1210
>   netlink_rcv_skb+0x16d/0x240 net/netlink/af_netlink.c:2550
>   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>   netlink_unicast+0x3e9/0x4c0 net/netlink/af_netlink.c:1344
>   netlink_sendmsg+0x4ab/0x5b0 net/netlink/af_netlink.c:1894
>   sock_sendmsg_nosec net/socket.c:718 [inline]
>   __sock_sendmsg+0xc9/0xf0 net/socket.c:733
>   ____sys_sendmsg+0x272/0x3b0 net/socket.c:2608
>   ___sys_sendmsg+0x2de/0x320 net/socket.c:2662
>   __sys_sendmsg net/socket.c:2694 [inline]
>   __do_sys_sendmsg net/socket.c:2699 [inline]
>   __se_sys_sendmsg net/socket.c:2697 [inline]
>   __x64_sys_sendmsg+0x110/0x1a0 net/socket.c:2697
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xed/0x360 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x7fc6adb66f6d
>  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
>  RSP: 002b:00007fc6ac5a6ff8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>  RAX: ffffffffffffffda RBX: 00007fc6addf5fa0 RCX: 00007fc6adb66f6d
>  RDX: 0000000000048084 RSI: 00002000000002c0 RDI: 000000000000000e
>  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>  netlink: 'syz.5.51': attribute type 2 has an invalid length.
>  R13: 00007fff25e91fe0 R14: 00007fc6ac5a7ce4 R15: 00007fff25e920d7
>   </TASK>
>
> The actions that caused that seem to be:
>
> - Create an MPTCP endpoint for address A without any flags
> - Create a new MPTCP connection from address A
> - Remove the MPTCP endpoint: the corresponding subflows will be removed
> - Recreate the endpoint with the same ID, but with the subflow flag
> - Change the same endpoint to add the fullmesh flag
>
> In this case, msk->pm.local_addr_used has been decremented, but the
> corresponding bit in msk->pm.id_avail_bitmap has not been reset.
>
> When removing an endpoint, the corresponding endpoint ID was only marked
> as available for announced addresses, not the other types. In these
> cases, re-creating an endpoint with the same ID didn't signal/create
> anything. Adding the fullmesh flag was creating the splat when calling
> __mark_subflow_endp_available() from mptcp_pm_nl_fullmesh(), because
> msk->pm.local_addr_used was set to 0 while the ID was marked as used.
>
> Note: instead of adding a new spin_(un)lock_bh that would be taken in
> all cases, do all the actions requiring the spin lock under the same
> block.
>
> This modification potentially fixes another issue reported by syzbot,
> see [1]. But without a reproducer or more details about what exactly
> happened before, it is hard to confirm.
>
> Fixes: e255683c06df ("mptcp: pm: re-using ID of unused removed ADD_ADDR")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/606
> Reported-by: syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/68fcfc4a.050a0220.346f24.02fb.GAE@google.com [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm_kernel.c | 19 +++++++------------
> 1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index f59d21e7579c..51bcfcec882d 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1057,10 +1057,8 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
> 	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
> 	if (ret || force) {
> 		spin_lock_bh(&msk->pm.lock);
> -		if (ret) {
> -			__set_bit(addr->id, msk->pm.id_avail_bitmap);
> +		if (ret)
> 			msk->pm.add_addr_signaled--;
> -		}
> 		mptcp_pm_remove_addr(msk, &list);
> 		spin_unlock_bh(&msk->pm.lock);
> 	}
> @@ -1098,17 +1096,14 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
> 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
>
> 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
> -		if (remove_subflow) {
> -			spin_lock_bh(&msk->pm.lock);
> -			mptcp_pm_rm_subflow(msk, &list);
> -			spin_unlock_bh(&msk->pm.lock);
> -		}
>
> -		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
> -			spin_lock_bh(&msk->pm.lock);
> +		spin_lock_bh(&msk->pm.lock);
> +		if (remove_subflow)
> +			mptcp_pm_rm_subflow(msk, &list);
> +		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
> 			__mark_subflow_endp_available(msk, list.ids[0]);
> -			spin_unlock_bh(&msk->pm.lock);
> -		}
> +		__set_bit(addr->id, msk->pm.id_avail_bitmap);

There's not any harm in setting this bit a second time if it was also set 
in __mark_subflow_endp_available().

However, __mark_subflow_endp_available() has some logic around ID 0 and 
mpc_endpoint_id. Is that relevant in this code path or is the new 
__set_bit() doing the correct thing by always clearing based on addr->id?

- Mat


> +		spin_unlock_bh(&msk->pm.lock);
>
> 		if (msk->mpc_endpoint_id == entry->addr.id)
> 			msk->mpc_endpoint_id = 0;
>
> -- 
> 2.51.0
>
>
>
