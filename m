Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1D2517B0
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105588; cv=none; b=rY9OzWXU2hOXr8Gv7dWpRPBa8+tvMJr9KSbIoCMJZUEnQ8EcwwKRZYVJTRM3cOReTXOilkEX3KGTrnAcS8r6IMR4XsM5TFzMdkFd3csv0ezUMK+ekb5h3rI+q0UJj2zqDwzIaZLlJ/UXAxL6H3peN8DMx/acvLI4XCJjDbop2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105588; c=relaxed/simple;
	bh=9MJ6+aXVn4FqKeM4zQp5PYERD/ONlh09V2ExSXZjmCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+BZP+i2DfW2iUVEvNB4Qm5jw7nbwxfgzgkmgghhK3MJXUhrF49h9t1zpxfzSsEWMQgWwpBbteXnDOXBL9JesUGteutzOm9iYoTMeiZfwf69Q3/WXpJ2uz1Ugii3prhZBWvGxndkaNgjfi3ooRiDkyVS8W2TSze5GwgKwoHQSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekzuWdEv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekzuWdEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABF5C4CEE5;
	Tue,  4 Mar 2025 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741105587;
	bh=9MJ6+aXVn4FqKeM4zQp5PYERD/ONlh09V2ExSXZjmCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ekzuWdEvFhnucOIxS3HiJiIteuyxbItiEETClLKlH5IaJgNkFoMLbsMIw3oPG35Vl
	 qDlY4qUzUoQTXeuWX+7XXwj6dtGLP4Njz+5k4yX3V/wWAzLHWVdBUUmVM4vK4ukpqd
	 TBEAmzbb+QFTxAHrjL/OgWsAXn43KruFKxVO4fJIFxh5BmkYV9heuheWSJQSepd6VB
	 W3IXgbWbedaj/xvmRhVFr56b5b1xtQfYeiBurfzSPFLVlRi6+5wyedz9JLDtGyllAo
	 S4nT/Ekn/Is8hQkb+j70+q/TRbgZYscA33syLUCWC4UwaJF0b8kM9WW4Ex3nnEw22d
	 i8I8/D9T4GvHQ==
Message-ID: <e1c36a29-7f27-4c2c-8dba-778e4ea5c7ae@kernel.org>
Date: Tue, 4 Mar 2025 17:26:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-net] mptcp: fix NULL pointer in can_accept_new_subflow
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <20250304102634.331497-1-yangang@kylinos.cn>
 <3ca5355f-d449-4540-9707-e54c6715d0df@kernel.org>
 <tencent_C5EC2504BB7561514BCABC185027C5324008@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_C5EC2504BB7561514BCABC185027C5324008@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 12:48, Gang Yan wrote:
> On Tue, Mar 04, 2025 at 11:35:49AM +0100, Matthieu Baerts wrote:
>> Hi Gang Yan,
>>
>> On 04/03/2025 11:26, Gang Yan wrote:
>>> When testing Valkey with MPTCP, a kernel panic occurs in
>>> 'mptcp_can_accept_new_subflow' when 'subflow_req->msk' is NULL.
>>
>> Thank you for the patch!
>>
>>> The attached logs on 6.14.0-rc4 confirm the crash:
>>>
>>> [ 2691.198090] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000012
>>> [ 2691.202935] Internal error: Oops: 0000000096000004 [#1] SMP
>>> [ 2691.205451] CPU: 5 UID: 0 PID: 7346 Comm: valkey-benchmar Not tainted 6.14.0-rc4+ #2
>>> [ 2691.205657] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
>>> [ 2691.205915] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>> [ 2691.206099] pc : mptcp_can_accept_new_subflow+0x24/0x100
>>> [ 2691.206285] lr : subflow_syn_recv_sock+0x2ec/0x538
>>> [ 2691.206413] sp : ffff8000833f38e0
>>> [ 2691.206507] x29: ffff8000833f38e0 x28: 0000000000000a82 x27: 0000000000000000
>>> [ 2691.206726] x26: 0000000000000001 x25: ffff000081972c00 x24: ffff0000efc1c188
>>> [ 2691.206915] x23: ffff0000821fd100 x22: ffff8000833f3a2f x21: ffff0000bb0adf00
>>> [ 2691.207108] x20: 0000000000000000 x19: 0000000000000000 x18: ffff8000833dd088
>>> [ 2691.207308] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>> [ 2691.207504] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>> [ 2691.207707] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff800081654214
>>> [ 2691.207900] x8 : ffff8000833f37d8 x7 : 0000000000000000 x6 : 0000000000000000
>>> [ 2691.208098] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>>> [ 2691.208289] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000012
>>> [ 2691.208478] Call trace:
>>> [ 2691.208548]  mptcp_can_accept_new_subflow+0x24/0x100 (P)
>>> [ 2691.208708]  subflow_syn_recv_sock+0x2ec/0x538
>>> [ 2691.208826]  tcp_check_req+0x154/0x888
>>> [ 2691.208940]  tcp_v4_rcv+0x6e4/0x12c0
>>> [ 2691.209036]  ip_protocol_deliver_rcu+0x48/0x2d8
>>> [ 2691.209172]  ip_local_deliver_finish+0x8c/0xf8
>>> [ 2691.209294]  ip_local_deliver+0x8c/0x160
>>> [ 2691.209402]  ip_rcv_finish+0x9c/0xe0
>>> [ 2691.209497]  ip_rcv+0x64/0x138
>>> [ 2691.209583]  __netif_receive_skb_one_core+0x68/0xc0
>>> [ 2691.209721]  __netif_receive_skb+0x24/0x88
>>> [ 2691.209831]  process_backlog+0x94/0x180
>>> [ 2691.209957]  __napi_poll+0x44/0x2a8
>>> [ 2691.210067]  net_rx_action+0x1e0/0x3f0
>>> [ 2691.210206]  handle_softirqs+0x13c/0x418
>>> [ 2691.210411]  __do_softirq+0x20/0x3c
>>> [ 2691.210515]  ____do_softirq+0x1c/0x40
>>> [ 2691.210616]  call_on_irq_stack+0x3c/0x50
>>> [ 2691.210726]  do_softirq_own_stack+0x28/0x50
>>> [ 2691.210836]  do_softirq+0xd4/0xe0
>>> [ 2691.210936]  __local_bh_enable_ip+0xc8/0xe0
>>> [ 2691.211057]  __dev_queue_xmit+0x280/0xf00
>>> [ 2691.211194]  ip_finish_output2+0x340/0x6f0
>>> [ 2691.211307]  __ip_finish_output+0xcc/0x200
>>> [ 2691.211428]  ip_finish_output+0x40/0x1a8
>>> [ 2691.211542]  ip_output+0x78/0x140
>>> [ 2691.211631]  __ip_queue_xmit+0x178/0x498
>>> [ 2691.211744]  ip_queue_xmit+0x20/0x50
>>> [ 2691.211860]  __tcp_transmit_skb+0x508/0xf20
>>> [ 2691.211974]  tcp_write_xmit+0x6fc/0x15f0
>>> [ 2691.212096]  __tcp_push_pending_frames+0x48/0x160
>>> [ 2691.212231]  tcp_push+0xc4/0x1e0
>>> [ 2691.212328]  __mptcp_push_pending+0x150/0x2d8
>>> [ 2691.212447]  mptcp_sendmsg+0x6f4/0x780
>>> [ 2691.212571]  inet_sendmsg+0x50/0xb8
>>> [ 2691.212669]  __sock_sendmsg+0x80/0x108
>>> [ 2691.212777]  __sys_sendto+0x124/0x1c0
>>> [ 2691.212881]  __arm64_sys_sendto+0x34/0x70
>>> [ 2691.212987]  invoke_syscall+0x74/0x128
>>> [ 2691.213096]  el0_svc_common.constprop.0+0x4c/0x140
>>> [ 2691.213231]  do_el0_svc+0x28/0x58
>>> [ 2691.213339]  el0_svc+0x40/0x1a0
>>> [ 2691.213429]  el0t_64_sync_handler+0x134/0x160
>>> [ 2691.213550]  el0t_64_sync+0x1b8/0x1c0
>>> [ 2691.213647] Code: 910003fd a90153f3 aa0003f3 91004800 (08dffc00)
>>> [ 2691.213815] ---[ end trace 0000000000000000 ]---
>>> [ 2691.224406] Kernel panic - not syncing: Oops: Fatal exception in interrupt
>>> [ 2691.224602] SMP: stopping secondary CPUs
>>> [ 2691.247158] Kernel Offset: disabled
>>> [ 2691.247290] CPU features: 0x000,00000050,00845250,ca07f723
>>> [ 2691.247487] Memory Limit: none
>>> [ 2691.260524] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
>>
>> Do you mind running ./scripts/decode_stacktrace.sh to resolve the
>> addresses please?
>>
>> While at it, can you also remove the timestamps
>>
> Thanks for the reminder letting me know what needs to be done.
> 
> To give you a clearer understanding of the issue, I have already
> used objdump -dS to disassemble and resolve some of the addresses:
> 
> ...
> ffff800081651be0 <mptcp_can_accept_new_subflow>:
> 	mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
> }
> static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
> {
> ...
> static inline int inet_sk_state_load(const struct sock *sk)
> {
> 	/* state change might impact lockless readers. */
> 	return smp_load_acquire(&sk->sk_state);
> ffff800081651c00:	91004800 	add	x0, x0, #0x12
> ffff800081651c04:	08dffc00 	ldarb	w0, [x0]
> ffff800081651c08:	12001c00 	and	w0, w0, #0xff
> 	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
> }
> ...
> 
> According to the Calltrace,ffff800081651be0 + 0x24 is ffff800081651c04,
> this might related to 'smp_load_acquire(&sk->sk_state)'.
> 
> To further confirm that the issue is with the subflow->msk being NULL,
> I added dmesg at both 'mptcp_is_fully_established' and 
> 'mptcp_can_accept_new_subflow'. The results confirmed this.
> 
> Here is the whole objdump -dS:
> https://github.com/multipath-tcp/mptcp_net-next/commit/c02e059bc9515ba0ced6717f7a53d2734b891b59

Thank you for that.

The current calltrace is helpful, and can help to understand that
"subflow_req->msk" is NULL, but it would be easier to read if you can
execute this "decode_stacktrace.sh". This script will simply resolve the
addresses, e.g. instead of displaying:

  Call trace:
    mptcp_can_accept_new_subflow+0x24/0x100 (P)

We will get something like:

  Call trace:
    mptcp_can_accept_new_subflow (net/mptcp/subflow.c:63)

Which is helpful for the reviewers, and future developers. That's the
format that is usually used in commit messages.

For more details about this script and why it is useful:

- https://lwn.net/Articles/592724/
- https://docs.kernel.org/admin-guide/bug-hunting.html

>>> The issue can be fixed by NULL check for 'subflow_req->msk' before
>>> 'mptcp_can_accept_new_subflow'.
>> Do you know why subflow_req->msk? Please always add a reason in your
>> commit message: adding this check might fix the issue, but why? What was
>> the root cause? How can we get into this situation? In which context?
>> Was it with syncookie being used?
>>
> Sorry for that, because it is an occasional problems. The information I
> collected is not enough to do this. I have tried to focus on the
> calltrace, but have no progress. Can you give me some suggestions?

A simple way is to read the code, e.g. in this case, finding how we can
have subflow_req->mp_join set to 1, but having subflow_req->msk not set.
Then when subflow_req->msk is not set, is it normal to continue up to
subflow_syn_recv_sock()?

>> Ideally, do you have a way to reproduce this issue? e.g. with a
>> packetdrill test? Or is it a race?
>>
> As for now, the mptcp_valkey.sh is the only way to repropduce it.The
> enviroment seems too complex to find the context. The objdump
> information may have some other clues can help this?
> https://github.com/multipath-tcp/mptcp_net-next/commit/56a546434db25cd6939ecb67f9c9e0661674a9e2

If this script can help you to reproduce the issue, then maybe can you
instrument the kernel to find the root cause? Finding why we end up in
subflow_syn_recv_sock() with subflow_req->mp_join set to 1, but having
subflow_req->msk not set.

In other words, the commit message should demonstrate that there is a
path to reach subflow_syn_recv_sock() in these conditions, and no other
ways to prevent it to happen before.

Once the root cause is found, it might also be easier to find a reproducer.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

