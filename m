Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DDF38D
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLBAtJb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C253BC433C7;
	Tue,  7 Nov 2023 01:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699321489;
	bh=v7/QqP90YwrrK3yc3rbLiRRS4tbSX3kyI0tHw3uIIcg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FLBAtJb3dcGMS0u/7P+CVSr8gvxnyC1cgaGfMSfMEmJUMYTMIyvAaL/qm5zbhhURu
	 FrcsTPqbZZxPm5+0g0ozgSeoOlJyvWnS6tRzIcg11kTTVcAFFxWOqxxrthV+dRVlpW
	 bkDaXymQ16+1CbqazzuvEJL9pyGL3RKtLX2w/95gplVA1ixSs0HHPfbSDCPyxN2/Z9
	 XGl65XaoIyBUSUm0l79yGfdZ+JSBkOlmyIcRnDoGPjtU6gr0jOci68HaQj/aw+4CD6
	 ZPWMrCyFhETXz+pUAxhzBYqYKyRDG2ltwnsCWePTjDCdJfYjfGceX8iidkKr+8vbHn
	 LzuFEbngewItA==
Date: Mon, 6 Nov 2023 17:44:49 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix possible NULL pointer dereference
 on close
In-Reply-To: <3350eaf14a073538bf491f93fc852cd02ab0875a.1699280113.git.pabeni@redhat.com>
Message-ID: <4d50ae35-689b-5223-75c5-1b1845ab6211@kernel.org>
References: <3350eaf14a073538bf491f93fc852cd02ab0875a.1699280113.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Nov 2023, Paolo Abeni wrote:

> After the blamed commit below, the MPTCP release callback
> can dereference the first subflow pointer, even at socket
> release time.
>
> In such scenario such subflow is already released and the pointer
> zeroed, causing the following splat:
>
> general protection fault, probably for non-canonical address 0xdffffc00000000f2: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000790-0x0000000000000797]
> CPU: 1 PID: 26719 Comm: syz-executor.2 Not tainted 6.6.0-syzkaller-10102-gff269e2cd5ad #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
> RIP: 0010:mptcp_subflow_ctx net/mptcp/protocol.h:542 [inline]
> RIP: 0010:__mptcp_propagate_sndbuf net/mptcp/protocol.h:813 [inline]
> RIP: 0010:__mptcp_set_connected+0x57/0x3e0 net/mptcp/subflow.c:424
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8a62323c
> RDX: 00000000000000f2 RSI: ffffffff8a630116 RDI: 0000000000000790
> RBP: ffff88803334b100 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000034 R12: ffff88803334b198
> R13: ffff888054f0b018 R14: 0000000000000000 R15: ffff88803334b100
> FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbcb4f75198 CR3: 000000006afb5000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> mptcp_release_cb+0xa2c/0xc40 net/mptcp/protocol.c:3405
> release_sock+0xba/0x1f0 net/core/sock.c:3537
> mptcp_close+0x32/0xf0 net/mptcp/protocol.c:3084
> inet_release+0x132/0x270 net/ipv4/af_inet.c:433
> inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
> __sock_release+0xae/0x260 net/socket.c:659
> sock_close+0x1c/0x20 net/socket.c:1419
> __fput+0x270/0xbb0 fs/file_table.c:394
> task_work_run+0x14d/0x240 kernel/task_work.c:180
> exit_task_work include/linux/task_work.h:38 [inline]
> do_exit+0xa92/0x2a20 kernel/exit.c:876
> do_group_exit+0xd4/0x2a0 kernel/exit.c:1026
> get_signal+0x23ba/0x2790 kernel/signal.c:2900
> arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
> exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
> exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
> __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
> do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:88
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7fb515e7cae9
> Code: Unable to access opcode bytes at 0x7fb515e7cabf.
> RSP: 002b:00007fb516c560c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: 000000000000003c RBX: 00007fb515f9c120 RCX: 00007fb515e7cae9
> RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000006
> RBP: 00007fb515ec847a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007fb515f9c120 R15: 00007ffc631eb968
> </TASK>
>
> Address the issue explicitly checking msk->first before tacking
> action.
>
> Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
> Reported-by: syzbot+9dfbaedb6e6baca57a32@syzkaller.appspotmail.com
> Reported-by: Eric Dumazet <edumazet@google.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/454
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0ad507ac6bc7..1490fd724036 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3399,9 +3399,10 @@ static void mptcp_release_cb(struct sock *sk)
> 		__mptcp_clean_una_wakeup(sk);
> 	if (unlikely(msk->cb_flags)) {
> 		/* be sure to set the current sk state before tacking actions

(taking?)

> -		 * depending on sk_state, that is processing MPTCP_ERROR_REPORT
> +		 * depending on sk_state (MPTCP_ERROR_REPORT)
> +		 * On sk release avoid actions depending on the first subflow
> 		 */
> -		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
> +		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags) && msk->first)
> 			__mptcp_set_connected(sk);
> 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
> 			__mptcp_error_report(sk);
> -- 
> 2.41.0

Hi Paolo -

This does address the call stack that syzbot triggered. Are you sure 
enough that the only way to reach __mptcp_set_connected() with msk->first 
== NULL is when mptcp_set_connected() encountered a locked socket and had 
to defer the call? It seems like that *should* be the case but it's not 
obvious to me that it's impossible in every other scenario.

Checking for NULL inside __mptcp_set_connected() could catch more edge 
cases. If you're confident that there are no other edge cases it would 
help to note that in either the commit message or comment.

- Mat
