Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07A72
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 13:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632491228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxAKTqjK1marCxbXhTWkxgyNws401V4kQcjrZlcghpo=;
	b=GHe48ZqQNieka4fR9Sg3Mw6FbAKK9EwSqELlYRMMLeveNh8Uihc0Hrfx+zngWGFfnmus8e
	5nwU4IQpfLKfksYAhE/UvYKbOr/HZon/rku1B2v4H0lVnLYP/CsFglzEbYfNcDAtdc1MiV
	SCH4vuxgCHE5MhX1cXbjdV8ZIJdlVMA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-PZCz72msO46qslgBJmNe3g-1; Fri, 24 Sep 2021 09:47:06 -0400
X-MC-Unique: PZCz72msO46qslgBJmNe3g-1
Received: by mail-wr1-f69.google.com with SMTP id s14-20020adff80e000000b001601b124f50so8130289wrp.5
        for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 06:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CxAKTqjK1marCxbXhTWkxgyNws401V4kQcjrZlcghpo=;
        b=q0UAg866WiywCAreqwyUnF5kum1JOroFKWAwjtVwlKHhqZl9skvxwai3iQnhMaNe+i
         ZHIhzxPUsUUHQ9vb0F9ENraX1fbRQeTiNOrsxzZlPcT8K9LpTmfco3yCddhsNMhGbstK
         463a+uFR1kd9BYLoBHQw0BKg0qwR8tyx/hl3hwVBEGpNanXBb9S+HLttdUHlZrsOvztv
         /scZg1JArnG1jgoCBhVQjp7JmQGcJkUgwBweD9pvjJkafIzdJgULtRHRAZ01hSMIpYAr
         YtulauBQmTvLQQ5PnQroo/Ntw8yRLrKeaH6bT3XJXHnuLFiraS5bdEt5hHrSKKmYDOCe
         xk0g==
X-Gm-Message-State: AOAM532UHCEX3nvhzwEupseQr+gEbdgxiwNNwEs2l8axeRs/lxLlgeFs
	O4E1NXXVscVX5ynxgq9SUbT3ks7KKSsIM/UGaEI3+tPabOMUM1afjnCVySwoix+d9pjhMf8E8lZ
	50y3uI6rmZkGzzEY=
X-Received: by 2002:a7b:c848:: with SMTP id c8mr2266911wml.187.1632491224859;
        Fri, 24 Sep 2021 06:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQg0dESFywgeKJdbFF/hWVkAcqJYhsAHE5nPv829dK6hSWQfXeunhfxnb/lPH3wbcvrxTJyQ==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr2266885wml.187.1632491224590;
        Fri, 24 Sep 2021 06:47:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-102-46.dyn.eolo.it. [146.241.102.46])
        by smtp.gmail.com with ESMTPSA id z13sm9383994wrs.90.2021.09.24.06.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:47:04 -0700 (PDT)
Message-ID: <cd19592e2ce6aa9806270e760961c3cbdb94daf3.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-net] mptcp: fix possible stall on recvmsg()
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Date: Fri, 24 Sep 2021 15:47:03 +0200
In-Reply-To: <9052bd061a82d1527fa34a74939c0df7f69cdf54.1632490689.git.pabeni@redhat.com>
References: <9052bd061a82d1527fa34a74939c0df7f69cdf54.1632490689.git.pabeni@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-09-24 at 15:38 +0200, Paolo Abeni wrote:
> recvmsg() can enter an infinite loop if the caller provides the
> MSG_WAITALL, the data present in the receive queue is not
> sufficient to fulfill the request and no more data is received by
> the peer.
> 
> When the above happens, mptcp_wait_data() will always return with
> no wait, as the MPTCP_DATA_READY flag checked by such function is
> set and never cleared in such code path.
> 
> Leveraging the above syzbot was able to trigger an RCU stall:
> 
> rcu: INFO: rcu_preempt self-detected stall on CPU
> rcu:    0-...!: (10499 ticks this GP) idle=0af/1/0x4000000000000000 softirq=10678/10678 fqs=1
>         (t=10500 jiffies g=13089 q=109)
> rcu: rcu_preempt kthread starved for 10497 jiffies! g13089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:28696 pid:   14 ppid:     2 flags:0x00004000
> Call Trace:
>  context_switch kernel/sched/core.c:4955 [inline]
>  __schedule+0x940/0x26f0 kernel/sched/core.c:6236
>  schedule+0xd3/0x270 kernel/sched/core.c:6315
>  schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
>  rcu_gp_fqs_loop+0x186/0x810 kernel/rcu/tree.c:1955
>  rcu_gp_kthread+0x1de/0x320 kernel/rcu/tree.c:2128
>  kthread+0x405/0x4f0 kernel/kthread.c:327
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> rcu: Stack dump where RCU GP kthread last ran:
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 8510 Comm: syz-executor827 Not tainted 5.15.0-rc2-next-20210920-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:84 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
> RIP: 0010:kasan_check_range+0xc8/0x180 mm/kasan/generic.c:189
> Code: 38 00 74 ed 48 8d 50 08 eb 09 48 83 c0 01 48 39 d0 74 7a 80 38 00 74 f2 48 89 c2 b8 01 00 00 00 48 85 d2 75 56 5b 5d 41 5c c3 <48> 85 d2 74 5e 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 50 80 38 00
> RSP: 0018:ffffc9000cd676c8 EFLAGS: 00000283
> RAX: ffffed100e9a110e RBX: ffffed100e9a110f RCX: ffffffff88ea062a
> RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888074d08870
> RBP: ffffed100e9a110e R08: 0000000000000001 R09: ffff888074d08877
> R10: ffffed100e9a110e R11: 0000000000000000 R12: ffff888074d08000
> R13: ffff888074d08000 R14: ffff888074d08088 R15: ffff888074d08000
> FS:  0000555556d8e300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> S:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000180 CR3: 0000000068909000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>  test_and_clear_bit include/asm-generic/bitops/instrumented-atomic.h:83 [inline]
>  mptcp_release_cb+0x14a/0x210 net/mptcp/protocol.c:3016
>  release_sock+0xb4/0x1b0 net/core/sock.c:3204
>  mptcp_wait_data net/mptcp/protocol.c:1770 [inline]
>  mptcp_recvmsg+0xfd1/0x27b0 net/mptcp/protocol.c:2080
>  inet6_recvmsg+0x11b/0x5e0 net/ipv6/af_inet6.c:659
>  sock_recvmsg_nosec net/socket.c:944 [inline]
>  ____sys_recvmsg+0x527/0x600 net/socket.c:2626
>  ___sys_recvmsg+0x127/0x200 net/socket.c:2670
>  do_recvmmsg+0x24d/0x6d0 net/socket.c:2764
>  __sys_recvmmsg net/socket.c:2843 [inline]
>  __do_sys_recvmmsg net/socket.c:2866 [inline]
>  __se_sys_recvmmsg net/socket.c:2859 [inline]
>  __x64_sys_recvmmsg+0x20b/0x260 net/socket.c:2859
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fc200d2dc39
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc5758e5a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc200d2dc39
> RDX: 0000000000000002 RSI: 00000000200017c0 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000f0b5ff
> R10: 0000000000000100 R11: 0000000000000246 R12: 0000000000000003
> R13: 00007ffc5758e5d0 R14: 00007ffc5758e5c0 R15: 0000000000000003
> 
> Fix the issue replacing the MPTCP_DATA_READY bit with direct
> inspection of the msk receive queue.
> 
> Reported-and-tested-by: syzbot+3360da629681aa0d22fe@syzkaller.appspotmail.com
> Fixes: 7a6a6cbc3e59 ("mptcp: recvmsg() can drain data from multiple subflow")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - instead of do more fiddling with the DATA_READY bit, just
>    check sk_receive_queue
> ---
>  net/mptcp/protocol.c | 52 ++++++++++----------------------------------
>  1 file changed, 12 insertions(+), 40 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e5df0b5971c8..cc996e8973b3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -528,7 +528,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
>  
>  		sk->sk_shutdown |= RCV_SHUTDOWN;
>  		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> -		set_bit(MPTCP_DATA_READY, &msk->flags);
>  
>  		switch (sk->sk_state) {
>  		case TCP_ESTABLISHED:
> @@ -742,10 +741,9 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  
>  	/* Wake-up the reader only for in-sequence data */
>  	mptcp_data_lock(sk);
> -	if (move_skbs_to_msk(msk, ssk)) {
> -		set_bit(MPTCP_DATA_READY, &msk->flags);
> +	if (move_skbs_to_msk(msk, ssk))
>  		sk->sk_data_ready(sk);
> -	}
> +
>  	mptcp_data_unlock(sk);
>  }
>  
> @@ -847,7 +845,6 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
>  		sk->sk_shutdown |= RCV_SHUTDOWN;
>  
>  		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> -		set_bit(MPTCP_DATA_READY, &msk->flags);
>  		sk->sk_data_ready(sk);
>  	}
>  
> @@ -1759,21 +1756,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	return copied ? : ret;
>  }
>  
> -static void mptcp_wait_data(struct sock *sk, long *timeo)
> -{
> -	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> -
> -	add_wait_queue(sk_sleep(sk), &wait);
> -	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> -
> -	sk_wait_event(sk, timeo,
> -		      test_bit(MPTCP_DATA_READY, &msk->flags), &wait);
> -
> -	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> -	remove_wait_queue(sk_sleep(sk), &wait);
> -}
> -
>  static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>  				struct msghdr *msg,
>  				size_t len, int flags,
> @@ -2077,19 +2059,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		}
>  
>  		pr_debug("block timeout %ld", timeo);
> -		mptcp_wait_data(sk, &timeo);
> -	}
> -
> -	if (skb_queue_empty_lockless(&sk->sk_receive_queue) &&
> -	    skb_queue_empty(&msk->receive_queue)) {
> -		/* entire backlog drained, clear DATA_READY. */
> -		clear_bit(MPTCP_DATA_READY, &msk->flags);
> -
> -		/* .. race-breaker: ssk might have gotten new data
> -		 * after last __mptcp_move_skbs() returned false.
> -		 */
> -		if (unlikely(__mptcp_move_skbs(msk)))
> -			set_bit(MPTCP_DATA_READY, &msk->flags);
> +		sk_wait_data(sk, &timeo, NULL);
>  	}
>  
>  out_err:
> @@ -2098,9 +2068,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  			tcp_recv_timestamp(msg, sk, &tss);
>  	}
>  
> -	pr_debug("msk=%p data_ready=%d rx queue empty=%d copied=%d",
> -		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
> -		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
> +	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
> +		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
> +		 skb_queue_empty(&msk->receive_queue), copied);
>  	if (!(flags & MSG_PEEK))
>  		mptcp_rcv_space_adjust(msk, copied);
>  
> @@ -2368,7 +2338,6 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
>  	inet_sk_state_store(sk, TCP_CLOSE);
>  	sk->sk_shutdown = SHUTDOWN_MASK;
>  	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> -	set_bit(MPTCP_DATA_READY, &msk->flags);
>  	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
>  
>  	mptcp_close_wake_up(sk);
> @@ -3385,8 +3354,11 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
>  
>  static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
>  {
> -	return test_bit(MPTCP_DATA_READY, &msk->flags) ? EPOLLIN | EPOLLRDNORM :
> -	       0;
> +	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
> +            skb_queue_empty_lockless(&msk->receive_queue))
> +		return 0;
> +
> +	return EPOLLIN | EPOLLRDNORM;
>  }
>  
>  static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
> @@ -3421,7 +3393,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>  	state = inet_sk_state_load(sk);
>  	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
>  	if (state == TCP_LISTEN)
> -		return mptcp_check_readable(msk);
> +		return test_bit(MPTCP_DATA_READY, &msk->flags) ? EPOLLIN | EPOLLRDNORM : 0;
>  
>  	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
>  		mask |= mptcp_check_readable(msk);

@netdev maintainer: this was intended for mptcp@lists.linux.dev only
consumption, it landed here due to PEBKAC, I'm sorry for the noise.
I'll drop this one from the netdev patchwork.

Cheers,

Paolo

