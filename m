Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DD2C82
	for <mptcp@lists.linux.dev>; Wed,  1 Dec 2021 23:59:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="223813887"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="223813887"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 15:59:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="602495719"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.209.83.143])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 15:59:37 -0800
Date: Wed, 1 Dec 2021 15:59:37 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Maxim Galaganov <max@internet.ru>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
    Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-net] mptcp: fix deadlock in
 __mptcp_push_pending()
In-Reply-To: <20211201211523.7155-1-max@internet.ru>
Message-ID: <9a79d0a1-a66-c883-bea3-d91cef829d41@linux.intel.com>
References: <20211201211523.7155-1-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 2 Dec 2021, Maxim Galaganov wrote:

> __mptcp_push_pending() may call mptcp_flush_join_list() with subflow
> socket lock held. If such call hits mptcp_sockopt_sync_all() then
> subsequently __mptcp_sockopt_sync() could try to lock the subflow
> socket for itself, causing a deadlock.
>
> sysrq: Show Blocked State
> task:ss-server       state:D stack:    0 pid:  938 ppid:     1 flags:0x00000000
> Call Trace:
> <TASK>
> __schedule+0x2d6/0x10c0
> ? __mod_memcg_state+0x4d/0x70
> ? csum_partial+0xd/0x20
> ? _raw_spin_lock_irqsave+0x26/0x50
> schedule+0x4e/0xc0
> __lock_sock+0x69/0x90
> ? do_wait_intr_irq+0xa0/0xa0
> __lock_sock_fast+0x35/0x50
> mptcp_sockopt_sync_all+0x38/0xc0
> __mptcp_push_pending+0x105/0x200
> mptcp_sendmsg+0x466/0x490
> sock_sendmsg+0x57/0x60
> __sys_sendto+0xf0/0x160
> ? do_wait_intr_irq+0xa0/0xa0
> ? fpregs_restore_userregs+0x12/0xd0
> __x64_sys_sendto+0x20/0x30
> do_syscall_64+0x38/0x90
> entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f9ba546c2d0
> RSP: 002b:00007ffdc3b762d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f9ba56c8060 RCX: 00007f9ba546c2d0
> RDX: 000000000000077a RSI: 0000000000e5e180 RDI: 0000000000000234
> RBP: 0000000000cc57f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9ba56c8060
> R13: 0000000000b6ba60 R14: 0000000000cc7840 R15: 41d8685b1d7901b8
> </TASK>
>
> Fix the issue by using __mptcp_flush_join_list() instead of plain
> mptcp_flush_join_list() inside __mptcp_push_pending(), as suggested by
> Florian. The sockopt sync will be deferred to the workqueue.
>
> Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/244
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Maxim Galaganov <max@internet.ru>
> ---
> This is now running on my tproxy setup without any visible trouble.
> Could take a week or two to validate though, given how rarely the issue
> manifested itself.
>
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8b49866bcc25..8319e601bc2d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1568,7 +1568,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 			int ret = 0;
>
> 			prev_ssk = ssk;
> -			mptcp_flush_join_list(msk);
> +			__mptcp_flush_join_list(msk);
> 			ssk = mptcp_subflow_get_send(msk);
>
> 			/* First check. If the ssk has changed since
> -- 
> 2.33.1

Thanks Maxim!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
