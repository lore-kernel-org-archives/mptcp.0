Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707A1DB124
	for <mptcp@lists.linux.dev>; Wed, 12 Mar 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775806; cv=none; b=lBs6PZMFKXkhhQHriw8W7Ymu8Jw0sCH/nMj/zljpepGoHtA+DWsYwLqEeSMf36OZ6ldZ6lFhyDh5rGHdUPq5zTFZiZB9J0P7M+s4DWZV6YcMKcDrnAj18BClsLYn7bOMM7kLBJCYSLX11jtUl+Qyb3zmvzyoN8bfR/Htg5YzqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775806; c=relaxed/simple;
	bh=RBmG7zlccoG0AA7ZVhzkLHAbOi9T3YpsCaXHGDgRCok=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKMtOi+098rRRxTTsAhafeu8QYuR2/XM8ewE/Ys2IAfoTXB+0Tt/g64a7m38aOXuUG4jUg2/8Ka4q8D5Pg9z5bYCjFdnfyuBVLlnCDT1cHsBu9XJuGnM3RoJ6ot7ddeT5aPCR72NTjpCfCv5UrcZ5LQtzOm6pzq9f+LGFJPsHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=vxi4m+rz; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="vxi4m+rz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1741775792;
	bh=Qsu394qzbuCoaRF7Ix5IvDNVYa4stZhnpnL2Kb03dZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vxi4m+rzof1YCYgDkFJ2A/9SKuCvlw1pm+2cXMEpgQwbjeniM0xf6CebNTqqZXaH+
	 yJP4AAr9Y7mAOGPlfJc0qQi5wHdOh7Uj6NQ3p5HTppIqgDl1FtHgwh6an26HPXxzqI
	 SoNOKxojjuU7jYCZvG0/x5HHk1otIJDfe2NmUHrg=
Received: from localhost ([39.156.73.13])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 78920AAD; Wed, 12 Mar 2025 18:30:09 +0800
X-QQ-mid: xmsmtpt1741775409tv6151gfu
Message-ID: <tencent_F7B3BAC3285B65240C959317991676180207@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTzEi+a/WgofcTrXSOGXiJY0WBTzBoXw+9XQYwV0DKf1KMTVm8tD
	 1iydQv+4uRpB8aH2cMl3WA3PT6PuA9hDs2Z7ZnIhvY3nOKU1zywu4UbxLiAizrar258xwQKBZdxn
	 tJxP43/BnmWZWEfCmwXWnIdiRm+JSz+d6d32Vx8ykJJsFGv87yQI8ChUgM+vvHiUtLoD9wLt+cmh
	 gTSyRQZAhbv8s4qxH7Rg9qzgTi03URPVOPdib+kz4TsQoWOIDqAES1MxCN36LTO5/wouTmE7VQYD
	 GH90SPMy/PM/NiR/rEpRfkXGijQtwPw57D1M9Q+D5iOIbG3igzrBv2ZaYVGuyyQmCylZVK13uSKc
	 kYjjs+RxTtTgf4WaPap/7cDdcd3tsjUr9maSNHm1hzlgeGYa/TGMD9loeLxvd/+QqyrRxaNUuhjY
	 QRBgPebhw7+/FqMdF2s6ui/echikFAunIZgIsdCQnDBSraK6tCLhZr5/RFgybhzf6/VLDOe6aoGH
	 7jLP2zLa6UBSo2cMP0J+BduB526Ms+6nItMMlWviJ86VmP5eekzdZcH4PHeQmcs3ObNFGiDh6inI
	 60ynftCRzKoRNicwalf22gcB0UJc5gAYcevXviTJcQqoZk4nexwCf6Apjrt5h8No3cN3uczDL4YX
	 f0vBdM+Lti1FSo67rF613f3/PGGEA/Vi3bDn3uwipaInbFvK/CG//ik4Q1yHafGa5wOYnEbZH4BC
	 DdBG3iX4mTIy6aoXg0pSsofVbD/xZRxTkpvGKWusBxGhmg/aSpozlfIbmhLy4CmJQS+wTzGVJMud
	 369kOX0mCvt0Cr0d8+BlPjM3RaiEpBA3lpX+uZvrFOcFNCZthS1RWN+tPfh7cVSypvOLCBukQJ1e
	 e97csiHR/mZvHfWY7uLXQQ6bHITfnJE700affXEpweysVnIAGtiEgE0zytsMMugSIAl0+ptpfhBN
	 6OU/Rq/ws2dtMHwpOPmg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Date: Wed, 12 Mar 2025 18:30:08 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Subject: Re: [mptcp-net] mptcp: fix NULL pointer in can_accept_new_subflow
X-OQ-MSGID: <20250312103008.GA326951@yangang-pc>
References: <20250304102634.331497-1-yangang@kylinos.cn>
 <3ca5355f-d449-4540-9707-e54c6715d0df@kernel.org>
 <tencent_C5EC2504BB7561514BCABC185027C5324008@qq.com>
 <e1c36a29-7f27-4c2c-8dba-778e4ea5c7ae@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1c36a29-7f27-4c2c-8dba-778e4ea5c7ae@kernel.org>

On Tue, Mar 04, 2025 at 05:26:24PM +0100, Matthieu Baerts wrote:
Hi Matt,

There have been new developments on this issue. I added some kernel logs and
have now basically pinpointed that 'subflow_req->msk' is being set to NULL
between '!subflow_hmac_valid' and '!mptcp_can_accept_new_subflow'
...
                if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
                    !subflow_hmac_valid(req, &mp_opt) ||
                    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
...
Although there is a NULL check for msk in the subflow_hmac_valid function,
there is still a risk of 'subflow_req->msk' being set to NULL later on.

After several days of research, I captured some useful kernel logs which show
that within a very short period of time, req:000000002a5ce31d executed
'subflow_syn_recv_sock' twice, which seems strange:

...
MPTCP: subflow=00000000f90ffe23
MPTCP: msk=00000000ec710aab
MPTCP: msk=00000000e7247175 state=1 flags=0
MPTCP: msk=00000000e7247175 state=1 flags=0
MPTCP: MP_JOIN hmac
MPTCP: msk=00000000e7247175 dfrag at seq=8532131614574795419 len=6 sent=0 new=1
2025-03-12T08:44:48.321697+00:00 MPTCP: listener=00000000c5bcffeb, req=000000002a5ce31d, conn=00000000d1c8e3bb
MPTCP: MP_JOIN hmac
MPTCP: msk=00000000e7247175 ssk=00000000cefa72e6 sending dfrag at seq=8532131614574795419 len=6 already sent=0
MPTCP: data_seq=8532131614574795419 subflow_seq=1 data_len=6 dsn64=1
2025-03-12T08:44:48.321698+00:00 MPTCP: listener=00000000c5bcffeb, req=000000002a5ce31d, conn=00000000d1c8e3bb
MPTCP: subflow=00000000501691f6
MPTCP: MP_JOIN hmac
MPTCP: msk=000000002e70bde0, subflow=00000000501691f6
MPTCP: msk=000000002e70bde0 subflows=5 max=8 allow=1
MPTCP: YGYG First step run and step3 cause req:000000002a5ce31d msk:0000000000000000 is NULL
MPTCP: DSS
MPTCP: MP_JOIN hmac
...

And this proves that if 'subflow_req->msk' ownership is transferred to
subflow in the first execution,  there will be a risk of a null pointer dereference here. 
Unfortunately, I haven't found the reason why 'subflow_syn_recv_sock' is executed twice.
Do you have any suggestions for me?

Thanks a lot!

Cheers!
Gang
> On 04/03/2025 12:48, Gang Yan wrote:
> > On Tue, Mar 04, 2025 at 11:35:49AM +0100, Matthieu Baerts wrote:
> >> Hi Gang Yan,
> >>
> >> On 04/03/2025 11:26, Gang Yan wrote:
> >>> When testing Valkey with MPTCP, a kernel panic occurs in
> >>> 'mptcp_can_accept_new_subflow' when 'subflow_req->msk' is NULL.
> >>
> >> Thank you for the patch!
> >>
> >>> The attached logs on 6.14.0-rc4 confirm the crash:
> >>>
> >>> [ 2691.198090] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000012
> >>> [ 2691.202935] Internal error: Oops: 0000000096000004 [#1] SMP
> >>> [ 2691.205451] CPU: 5 UID: 0 PID: 7346 Comm: valkey-benchmar Not tainted 6.14.0-rc4+ #2
> >>> [ 2691.205657] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> >>> [ 2691.205915] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> >>> [ 2691.206099] pc : mptcp_can_accept_new_subflow+0x24/0x100
> >>> [ 2691.206285] lr : subflow_syn_recv_sock+0x2ec/0x538
> >>> [ 2691.206413] sp : ffff8000833f38e0
> >>> [ 2691.206507] x29: ffff8000833f38e0 x28: 0000000000000a82 x27: 0000000000000000
> >>> [ 2691.206726] x26: 0000000000000001 x25: ffff000081972c00 x24: ffff0000efc1c188
> >>> [ 2691.206915] x23: ffff0000821fd100 x22: ffff8000833f3a2f x21: ffff0000bb0adf00
> >>> [ 2691.207108] x20: 0000000000000000 x19: 0000000000000000 x18: ffff8000833dd088
> >>> [ 2691.207308] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> >>> [ 2691.207504] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> >>> [ 2691.207707] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff800081654214
> >>> [ 2691.207900] x8 : ffff8000833f37d8 x7 : 0000000000000000 x6 : 0000000000000000
> >>> [ 2691.208098] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> >>> [ 2691.208289] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000012
> >>> [ 2691.208478] Call trace:
> >>> [ 2691.208548]  mptcp_can_accept_new_subflow+0x24/0x100 (P)
> >>> [ 2691.208708]  subflow_syn_recv_sock+0x2ec/0x538
> >>> [ 2691.208826]  tcp_check_req+0x154/0x888
> >>> [ 2691.208940]  tcp_v4_rcv+0x6e4/0x12c0
> >>> [ 2691.209036]  ip_protocol_deliver_rcu+0x48/0x2d8
> >>> [ 2691.209172]  ip_local_deliver_finish+0x8c/0xf8
> >>> [ 2691.209294]  ip_local_deliver+0x8c/0x160
> >>> [ 2691.209402]  ip_rcv_finish+0x9c/0xe0
> >>> [ 2691.209497]  ip_rcv+0x64/0x138
> >>> [ 2691.209583]  __netif_receive_skb_one_core+0x68/0xc0
> >>> [ 2691.209721]  __netif_receive_skb+0x24/0x88
> >>> [ 2691.209831]  process_backlog+0x94/0x180
> >>> [ 2691.209957]  __napi_poll+0x44/0x2a8
> >>> [ 2691.210067]  net_rx_action+0x1e0/0x3f0
> >>> [ 2691.210206]  handle_softirqs+0x13c/0x418
> >>> [ 2691.210411]  __do_softirq+0x20/0x3c
> >>> [ 2691.210515]  ____do_softirq+0x1c/0x40
> >>> [ 2691.210616]  call_on_irq_stack+0x3c/0x50
> >>> [ 2691.210726]  do_softirq_own_stack+0x28/0x50
> >>> [ 2691.210836]  do_softirq+0xd4/0xe0
> >>> [ 2691.210936]  __local_bh_enable_ip+0xc8/0xe0
> >>> [ 2691.211057]  __dev_queue_xmit+0x280/0xf00
> >>> [ 2691.211194]  ip_finish_output2+0x340/0x6f0
> >>> [ 2691.211307]  __ip_finish_output+0xcc/0x200
> >>> [ 2691.211428]  ip_finish_output+0x40/0x1a8
> >>> [ 2691.211542]  ip_output+0x78/0x140
> >>> [ 2691.211631]  __ip_queue_xmit+0x178/0x498
> >>> [ 2691.211744]  ip_queue_xmit+0x20/0x50
> >>> [ 2691.211860]  __tcp_transmit_skb+0x508/0xf20
> >>> [ 2691.211974]  tcp_write_xmit+0x6fc/0x15f0
> >>> [ 2691.212096]  __tcp_push_pending_frames+0x48/0x160
> >>> [ 2691.212231]  tcp_push+0xc4/0x1e0
> >>> [ 2691.212328]  __mptcp_push_pending+0x150/0x2d8
> >>> [ 2691.212447]  mptcp_sendmsg+0x6f4/0x780
> >>> [ 2691.212571]  inet_sendmsg+0x50/0xb8
> >>> [ 2691.212669]  __sock_sendmsg+0x80/0x108
> >>> [ 2691.212777]  __sys_sendto+0x124/0x1c0
> >>> [ 2691.212881]  __arm64_sys_sendto+0x34/0x70
> >>> [ 2691.212987]  invoke_syscall+0x74/0x128
> >>> [ 2691.213096]  el0_svc_common.constprop.0+0x4c/0x140
> >>> [ 2691.213231]  do_el0_svc+0x28/0x58
> >>> [ 2691.213339]  el0_svc+0x40/0x1a0
> >>> [ 2691.213429]  el0t_64_sync_handler+0x134/0x160
> >>> [ 2691.213550]  el0t_64_sync+0x1b8/0x1c0
> >>> [ 2691.213647] Code: 910003fd a90153f3 aa0003f3 91004800 (08dffc00)
> >>> [ 2691.213815] ---[ end trace 0000000000000000 ]---
> >>> [ 2691.224406] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> >>> [ 2691.224602] SMP: stopping secondary CPUs
> >>> [ 2691.247158] Kernel Offset: disabled
> >>> [ 2691.247290] CPU features: 0x000,00000050,00845250,ca07f723
> >>> [ 2691.247487] Memory Limit: none
> >>> [ 2691.260524] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
> >>
> >> Do you mind running ./scripts/decode_stacktrace.sh to resolve the
> >> addresses please?
> >>
> >> While at it, can you also remove the timestamps
> >>
> > Thanks for the reminder letting me know what needs to be done.
> > 
> > To give you a clearer understanding of the issue, I have already
> > used objdump -dS to disassemble and resolve some of the addresses:
> > 
> > ...
> > ffff800081651be0 <mptcp_can_accept_new_subflow>:
> > 	mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
> > }
> > static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
> > {
> > ...
> > static inline int inet_sk_state_load(const struct sock *sk)
> > {
> > 	/* state change might impact lockless readers. */
> > 	return smp_load_acquire(&sk->sk_state);
> > ffff800081651c00:	91004800 	add	x0, x0, #0x12
> > ffff800081651c04:	08dffc00 	ldarb	w0, [x0]
> > ffff800081651c08:	12001c00 	and	w0, w0, #0xff
> > 	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
> > }
> > ...
> > 
> > According to the Calltrace,ffff800081651be0 + 0x24 is ffff800081651c04,
> > this might related to 'smp_load_acquire(&sk->sk_state)'.
> > 
> > To further confirm that the issue is with the subflow->msk being NULL,
> > I added dmesg at both 'mptcp_is_fully_established' and 
> > 'mptcp_can_accept_new_subflow'. The results confirmed this.
> > 
> > Here is the whole objdump -dS:
> > https://github.com/multipath-tcp/mptcp_net-next/commit/c02e059bc9515ba0ced6717f7a53d2734b891b59
> 
> Thank you for that.
> 
> The current calltrace is helpful, and can help to understand that
> "subflow_req->msk" is NULL, but it would be easier to read if you can
> execute this "decode_stacktrace.sh". This script will simply resolve the
> addresses, e.g. instead of displaying:
> 
>   Call trace:
>     mptcp_can_accept_new_subflow+0x24/0x100 (P)
> 
> We will get something like:
> 
>   Call trace:
>     mptcp_can_accept_new_subflow (net/mptcp/subflow.c:63)
> 
> Which is helpful for the reviewers, and future developers. That's the
> format that is usually used in commit messages.
> 
> For more details about this script and why it is useful:
> 
> - https://lwn.net/Articles/592724/
> - https://docs.kernel.org/admin-guide/bug-hunting.html
> 
> >>> The issue can be fixed by NULL check for 'subflow_req->msk' before
> >>> 'mptcp_can_accept_new_subflow'.
> >> Do you know why subflow_req->msk? Please always add a reason in your
> >> commit message: adding this check might fix the issue, but why? What was
> >> the root cause? How can we get into this situation? In which context?
> >> Was it with syncookie being used?
> >>
> > Sorry for that, because it is an occasional problems. The information I
> > collected is not enough to do this. I have tried to focus on the
> > calltrace, but have no progress. Can you give me some suggestions?
> 
> A simple way is to read the code, e.g. in this case, finding how we can
> have subflow_req->mp_join set to 1, but having subflow_req->msk not set.
> Then when subflow_req->msk is not set, is it normal to continue up to
> subflow_syn_recv_sock()?
> 
> >> Ideally, do you have a way to reproduce this issue? e.g. with a
> >> packetdrill test? Or is it a race?
> >>
> > As for now, the mptcp_valkey.sh is the only way to repropduce it.The
> > enviroment seems too complex to find the context. The objdump
> > information may have some other clues can help this?
> > https://github.com/multipath-tcp/mptcp_net-next/commit/56a546434db25cd6939ecb67f9c9e0661674a9e2
> 
> If this script can help you to reproduce the issue, then maybe can you
> instrument the kernel to find the root cause? Finding why we end up in
> subflow_syn_recv_sock() with subflow_req->mp_join set to 1, but having
> subflow_req->msk not set.
> 
> In other words, the commit message should demonstrate that there is a
> path to reach subflow_syn_recv_sock() in these conditions, and no other
> ways to prevent it to happen before.
> 
> Once the root cause is found, it might also be easier to find a reproducer.
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 

