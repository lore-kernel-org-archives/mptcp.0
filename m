Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189E202C40
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089732; cv=none; b=nhYnCadZ6CWIP1iB0JhNniOeyyneq/ehHtIw9+XrjJjIvapgCo52AwIF+AAkqgEslrYX1fQyZpUaG7kkiydL+n55jz5OHmbcQl6ApiuQq9ZaibTG88IPqlBu0//b/j/1xObt50nprKXqvVnowkX15UUO3gigJMNZIv6ZVXFyFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089732; c=relaxed/simple;
	bh=RbqhG4b9pPURSRHToZYbM0SqChrhV4nXXocefPWtzFY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMVQXE53LD0XR57cGhHEIjBX6oRLjZfJrLM8wNBhKCDP9IU6/2MtcdEXWu7cm9QlAoxl0qn24l7pirmT7xNc/4/R+6qyC/gQCqdpUD0oioTtWBEPB7384qwkSjRVZ10jYQzvIEna6i9RPD1tAzT6jRd8VDZ4H8iHGkE0BHTjkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bBuRW1WU; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bBuRW1WU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1741089723;
	bh=eNh0diATeYlRqagozsP6QhdIwqmd2iJRNDyRDOQ5r/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bBuRW1WU6fa5Or/LJuHDXONSlErJ9VxgXQH0DZ1nCZHAjmeVGgBqKZRZhYCoKyDBm
	 57H8Ayq3IO/kb7m3nNhtz4odMqzRNbOD4GqF8kEe6A8i5dPeCxzHMBtncPHMHKbYf2
	 pK8PiIdH6gwrXjuzpshy4cfemV0oyLWWJrn1+UJw=
Received: from localhost ([223.70.160.239])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id C27098F3; Tue, 04 Mar 2025 19:48:39 +0800
X-QQ-mid: xmsmtpt1741088919tgb4bp70z
Message-ID: <tencent_C5EC2504BB7561514BCABC185027C5324008@qq.com>
X-QQ-XMAILINFO: MRLc0g//fdpv/YD7bxFbDh+zoGp2KB6YTKVHCuXQ3Cmk/+l48GUdvO1+n0tU9g
	 VSU9qL3oroDBlkYiv7915HmzG3xNTwXdVHm5xURaG9Ntjss1HkfASxwrw1+7sFb51GlxKTLpAd59
	 Vu4U8Gt692lMOHkly0h8MdLyK5X1uMON1rV873dE9VeDyVPp+J9i2dMRCw0fF+/Bl9oz6l5oionk
	 TDoVwrC3+cY31as4QCt3UtpXRDx+gO0O9OUT786VqXoure+EHrEeC8w4+N7UUbyMVxRAAGafwpWj
	 yKl6i6y+rYgDg40ODHm9ZfL2fm4Ipz6SL/eKNMtJaJBCsTVZIBh3/unwWoxQPYqbklCBcSethC7G
	 txf/SU3tpqiQuctiLKtagy0wFFhqBXbCiQTo3/K6/1fXTUErqEfw0dP3nR+efXoE6bAwoYwLbbDk
	 RrvCrXVHoU9VGfi6q++63nt7Wcmoi62v157Ikcd3qQ3tsrRQCSUyoeJ9aSxid+Lw6UD62pxH/IKq
	 TxEnkhsTm0OUBskr2TH5DQjSGNi6C5gHin9oDT6l5DlsSku0q7COaoYIiD+fHGldO/wOmm3FDalu
	 ewfH87OQaVXBVaRn1iG1khLPIWDEa7mu2tyaSEX6c5XCW86SV/enQwICqQsO8dB1cqCTT2s1dm1h
	 ovx91wvNuVeHENhtfD2/vs1oeIgz8zs+j80QCR8T+pUNQHGCfsHJoRDdGvn1r6FYO5mZ4s02lCWg
	 3OgWAt7PP9KTdRg2knX9cwZRMZn+Bqf/RrGEJWz3tE9s6iIrlHwvFgsTqCVYaj0aJTY8/hw+GyNX
	 jZOXutfiGkBEnr68ygFKx/SLCDzqnwVLzlEK+mQEUO6xYAPddbr/LPvZE8MFCMg1pxyu4ZuTOeX5
	 P1Q1BWStYdZDNarafKwLdFLk9mdJbD0P7xmTSJOGcaiVC4r6zq+xs3igYZOMVAaccwgw4cLmiemk
	 kFpvdWPtxkmBisMiSf/cBLFcXAh5lVkfy2lXKlxW6ZiPffUN7QlUX11hPQLE9q
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Date: Tue, 4 Mar 2025 19:48:39 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Subject: Re: [mptcp-net] mptcp: fix NULL pointer in can_accept_new_subflow
X-OQ-MSGID: <20250304114839.GA342655@yangang-pc>
References: <20250304102634.331497-1-yangang@kylinos.cn>
 <3ca5355f-d449-4540-9707-e54c6715d0df@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ca5355f-d449-4540-9707-e54c6715d0df@kernel.org>

On Tue, Mar 04, 2025 at 11:35:49AM +0100, Matthieu Baerts wrote:
> Hi Gang Yan,
> 
> On 04/03/2025 11:26, Gang Yan wrote:
> > When testing Valkey with MPTCP, a kernel panic occurs in
> > 'mptcp_can_accept_new_subflow' when 'subflow_req->msk' is NULL.
> 
> Thank you for the patch!
> 
> > The attached logs on 6.14.0-rc4 confirm the crash:
> > 
> > [ 2691.198090] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000012
> > [ 2691.202935] Internal error: Oops: 0000000096000004 [#1] SMP
> > [ 2691.205451] CPU: 5 UID: 0 PID: 7346 Comm: valkey-benchmar Not tainted 6.14.0-rc4+ #2
> > [ 2691.205657] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > [ 2691.205915] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > [ 2691.206099] pc : mptcp_can_accept_new_subflow+0x24/0x100
> > [ 2691.206285] lr : subflow_syn_recv_sock+0x2ec/0x538
> > [ 2691.206413] sp : ffff8000833f38e0
> > [ 2691.206507] x29: ffff8000833f38e0 x28: 0000000000000a82 x27: 0000000000000000
> > [ 2691.206726] x26: 0000000000000001 x25: ffff000081972c00 x24: ffff0000efc1c188
> > [ 2691.206915] x23: ffff0000821fd100 x22: ffff8000833f3a2f x21: ffff0000bb0adf00
> > [ 2691.207108] x20: 0000000000000000 x19: 0000000000000000 x18: ffff8000833dd088
> > [ 2691.207308] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [ 2691.207504] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > [ 2691.207707] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff800081654214
> > [ 2691.207900] x8 : ffff8000833f37d8 x7 : 0000000000000000 x6 : 0000000000000000
> > [ 2691.208098] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > [ 2691.208289] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000012
> > [ 2691.208478] Call trace:
> > [ 2691.208548]  mptcp_can_accept_new_subflow+0x24/0x100 (P)
> > [ 2691.208708]  subflow_syn_recv_sock+0x2ec/0x538
> > [ 2691.208826]  tcp_check_req+0x154/0x888
> > [ 2691.208940]  tcp_v4_rcv+0x6e4/0x12c0
> > [ 2691.209036]  ip_protocol_deliver_rcu+0x48/0x2d8
> > [ 2691.209172]  ip_local_deliver_finish+0x8c/0xf8
> > [ 2691.209294]  ip_local_deliver+0x8c/0x160
> > [ 2691.209402]  ip_rcv_finish+0x9c/0xe0
> > [ 2691.209497]  ip_rcv+0x64/0x138
> > [ 2691.209583]  __netif_receive_skb_one_core+0x68/0xc0
> > [ 2691.209721]  __netif_receive_skb+0x24/0x88
> > [ 2691.209831]  process_backlog+0x94/0x180
> > [ 2691.209957]  __napi_poll+0x44/0x2a8
> > [ 2691.210067]  net_rx_action+0x1e0/0x3f0
> > [ 2691.210206]  handle_softirqs+0x13c/0x418
> > [ 2691.210411]  __do_softirq+0x20/0x3c
> > [ 2691.210515]  ____do_softirq+0x1c/0x40
> > [ 2691.210616]  call_on_irq_stack+0x3c/0x50
> > [ 2691.210726]  do_softirq_own_stack+0x28/0x50
> > [ 2691.210836]  do_softirq+0xd4/0xe0
> > [ 2691.210936]  __local_bh_enable_ip+0xc8/0xe0
> > [ 2691.211057]  __dev_queue_xmit+0x280/0xf00
> > [ 2691.211194]  ip_finish_output2+0x340/0x6f0
> > [ 2691.211307]  __ip_finish_output+0xcc/0x200
> > [ 2691.211428]  ip_finish_output+0x40/0x1a8
> > [ 2691.211542]  ip_output+0x78/0x140
> > [ 2691.211631]  __ip_queue_xmit+0x178/0x498
> > [ 2691.211744]  ip_queue_xmit+0x20/0x50
> > [ 2691.211860]  __tcp_transmit_skb+0x508/0xf20
> > [ 2691.211974]  tcp_write_xmit+0x6fc/0x15f0
> > [ 2691.212096]  __tcp_push_pending_frames+0x48/0x160
> > [ 2691.212231]  tcp_push+0xc4/0x1e0
> > [ 2691.212328]  __mptcp_push_pending+0x150/0x2d8
> > [ 2691.212447]  mptcp_sendmsg+0x6f4/0x780
> > [ 2691.212571]  inet_sendmsg+0x50/0xb8
> > [ 2691.212669]  __sock_sendmsg+0x80/0x108
> > [ 2691.212777]  __sys_sendto+0x124/0x1c0
> > [ 2691.212881]  __arm64_sys_sendto+0x34/0x70
> > [ 2691.212987]  invoke_syscall+0x74/0x128
> > [ 2691.213096]  el0_svc_common.constprop.0+0x4c/0x140
> > [ 2691.213231]  do_el0_svc+0x28/0x58
> > [ 2691.213339]  el0_svc+0x40/0x1a0
> > [ 2691.213429]  el0t_64_sync_handler+0x134/0x160
> > [ 2691.213550]  el0t_64_sync+0x1b8/0x1c0
> > [ 2691.213647] Code: 910003fd a90153f3 aa0003f3 91004800 (08dffc00)
> > [ 2691.213815] ---[ end trace 0000000000000000 ]---
> > [ 2691.224406] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> > [ 2691.224602] SMP: stopping secondary CPUs
> > [ 2691.247158] Kernel Offset: disabled
> > [ 2691.247290] CPU features: 0x000,00000050,00845250,ca07f723
> > [ 2691.247487] Memory Limit: none
> > [ 2691.260524] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
> 
> Do you mind running ./scripts/decode_stacktrace.sh to resolve the
> addresses please?
> 
> While at it, can you also remove the timestamps
>
Thanks for the reminder letting me know what needs to be done.

To give you a clearer understanding of the issue, I have already
used objdump -dS to disassemble and resolve some of the addresses:

...
ffff800081651be0 <mptcp_can_accept_new_subflow>:
	mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
}
static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
{
...
static inline int inet_sk_state_load(const struct sock *sk)
{
	/* state change might impact lockless readers. */
	return smp_load_acquire(&sk->sk_state);
ffff800081651c00:	91004800 	add	x0, x0, #0x12
ffff800081651c04:	08dffc00 	ldarb	w0, [x0]
ffff800081651c08:	12001c00 	and	w0, w0, #0xff
	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
}
...

According to the Calltrace,ffff800081651be0 + 0x24 is ffff800081651c04,
this might related to 'smp_load_acquire(&sk->sk_state)'.

To further confirm that the issue is with the subflow->msk being NULL,
I added dmesg at both 'mptcp_is_fully_established' and 
'mptcp_can_accept_new_subflow'. The results confirmed this.

Here is the whole objdump -dS:
https://github.com/multipath-tcp/mptcp_net-next/commit/c02e059bc9515ba0ced6717f7a53d2734b891b59

> > The issue can be fixed by NULL check for 'subflow_req->msk' before
> > 'mptcp_can_accept_new_subflow'.
> Do you know why subflow_req->msk? Please always add a reason in your
> commit message: adding this check might fix the issue, but why? What was
> the root cause? How can we get into this situation? In which context?
> Was it with syncookie being used?
> 
Sorry for that, because it is an occasional problems. The information I
collected is not enough to do this. I have tried to focus on the
calltrace, but have no progress. Can you give me some suggestions?

> Ideally, do you have a way to reproduce this issue? e.g. with a
> packetdrill test? Or is it a race?
> 
As for now, the mptcp_valkey.sh is the only way to repropduce it.The
enviroment seems too complex to find the context. The objdump
information may have some other clues can help this?
https://github.com/multipath-tcp/mptcp_net-next/commit/56a546434db25cd6939ecb67f9c9e0661674a9e2

> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > ---
> >  net/mptcp/subflow.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index efe8d86496db..68b0e65e5239 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -852,6 +852,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> >  		mptcp_get_options(skb, &mp_opt);
> >  		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
> >  		    !subflow_hmac_valid(req, &mp_opt) ||
> > +		    !subflow_req->msk ||
> >  		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
> >  			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
> >  			fallback = true;
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
> 
Thanks for the reply again.
Best wishes!
Gang

