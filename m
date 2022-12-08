Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117D621
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670464207; x=1702000207;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BbtGS17GWkfRkxYaAdSAelBUnwfsZHk4wBvSWKDc3tI=;
  b=ljZbXJ9aWRHUbilXE5JaQyDgg+Hx/e0kjNHOuAJi10mnYDeCtqxGxe9K
   H9WhnE5wKHc7S+GRTemD1pG6Bm17K0y4eAlK4PXldBo5B+W6QPYWGqOi8
   rDtH7LVDQ3gohGnStIsJ7pdjhC9D639hjVFe79HT6VfHiuEw9hqltV1l4
   9rou8inyTSueG6wgvjF6ZMlQ7w/l3dCHbsk9rHvju86JyNvtblycVVKbc
   BJGIwm/4/b1UXaCR6XgHnDbQFy8zR295kV1AufCUeT8bqdFe1AUSiDySU
   XadngUMbJWkIHSqoup0cFmAdqctxOMcUAVcrX3WV2N1oEIZKS7OcdNBAt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="317058144"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="317058144"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 17:50:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="648955981"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="648955981"
Received: from rtalla-mobl.amr.corp.intel.com ([10.209.87.225])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 17:50:07 -0800
Date: Wed, 7 Dec 2022 17:50:06 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: fix lockdep false positive
In-Reply-To: <0818f7332284bd7781956959fbebb90188e140cb.1670435550.git.pabeni@redhat.com>
Message-ID: <194f648f-4813-a0ef-2c28-dd46acc3c4eb@linux.intel.com>
References: <0818f7332284bd7781956959fbebb90188e140cb.1670435550.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 7 Dec 2022, Paolo Abeni wrote:

> MatB reported a lockdep splat in the mptcp listener code cleanup:
>
> WARNING: possible circular locking dependency detected
> packetdrill/14278 is trying to acquire lock:
> ffff888017d868f0 ((work_completion)(&msk->work)){+.+.}-{0:0}, at: __flush_work (kernel/workqueue.c:3069)
>
> but task is already holding lock:
> ffff888017d84130 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close (net/mptcp/protocol.c:2973)
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
>        __lock_acquire (kernel/locking/lockdep.c:5055)
>        lock_acquire (kernel/locking/lockdep.c:466)
>        lock_sock_nested (net/core/sock.c:3463)
>        mptcp_worker (net/mptcp/protocol.c:2614)
>        process_one_work (kernel/workqueue.c:2294)
>        worker_thread (include/linux/list.h:292)
>        kthread (kernel/kthread.c:376)
>        ret_from_fork (arch/x86/entry/entry_64.S:312)
>
> -> #0 ((work_completion)(&msk->work)){+.+.}-{0:0}:
>        check_prev_add (kernel/locking/lockdep.c:3098)
>        validate_chain (kernel/locking/lockdep.c:3217)
>        __lock_acquire (kernel/locking/lockdep.c:5055)
>        lock_acquire (kernel/locking/lockdep.c:466)
>        __flush_work (kernel/workqueue.c:3070)
>        __cancel_work_timer (kernel/workqueue.c:3160)
>        mptcp_cancel_work (net/mptcp/protocol.c:2758)
>        mptcp_subflow_queue_clean (net/mptcp/subflow.c:1817)
>        __mptcp_close_ssk (net/mptcp/protocol.c:2363)
>        mptcp_destroy_common (net/mptcp/protocol.c:3170)
>        mptcp_destroy (include/net/sock.h:1495)
>        __mptcp_destroy_sock (net/mptcp/protocol.c:2886)
>        __mptcp_close (net/mptcp/protocol.c:2959)
>        mptcp_close (net/mptcp/protocol.c:2974)
>        inet_release (net/ipv4/af_inet.c:432)
>        __sock_release (net/socket.c:651)
>        sock_close (net/socket.c:1367)
>        __fput (fs/file_table.c:320)
>        task_work_run (kernel/task_work.c:181 (discriminator 1))
>        exit_to_user_mode_prepare (include/linux/resume_user_mode.h:49)
>        syscall_exit_to_user_mode (kernel/entry/common.c:130)
>        do_syscall_64 (arch/x86/entry/common.c:87)
>        entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(sk_lock-AF_INET);
>                                lock((work_completion)(&msk->work));
>                                lock(sk_lock-AF_INET);
>   lock((work_completion)(&msk->work));
>
>  *** DEADLOCK ***
>

Hi Paolo -

Just a couple of typo fixes, and a question below about the workaround.


> The report is actually a false positive, since the only exiting lock

s/exiting/existing/

> nesting is the msk socket lock acquire by the mptcp work.

s/acquire/acquired/

> cancel_work_sync() is invoked without the relevant socket lock being
> held, but under a different (the msk listener) socket lock.
>
> We could silence the splat adding a per workqueue dynamic lockdep key,
> but that looks overkill. Instead just tell lockdep the msk socket lock
> is not held around cancel_work_sync().
>
> Fixes: 30e51b923e43 ("mptcp: fix unreleased socket in accept queue")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> note: mutex_release() is available as a NULL macro even when LOCKDEP is
> disabled
> ---
> net/mptcp/protocol.c |  2 +-
> net/mptcp/protocol.h |  2 +-
> net/mptcp/subflow.c  | 14 ++++++++++++--
> 3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6d03bdcda33e..289dd4add88c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2363,7 +2363,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		/* otherwise tcp will dispose of the ssk and subflow ctx */
> 		if (ssk->sk_state == TCP_LISTEN) {
> 			tcp_set_state(ssk, TCP_CLOSE);
> -			mptcp_subflow_queue_clean(ssk);
> +			mptcp_subflow_queue_clean(sk, ssk);
> 			inet_csk_listen_stop(ssk);
> 			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
> 		}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a9ff7028fad8..3cd3270407b0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -630,7 +630,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		     struct mptcp_subflow_context *subflow);
> void __mptcp_subflow_send_ack(struct sock *ssk);
> void mptcp_subflow_reset(struct sock *ssk);
> -void mptcp_subflow_queue_clean(struct sock *ssk);
> +void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
> void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
> bool __mptcp_close(struct sock *sk, long timeout);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 29904303f5c2..d5ff502c88d7 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1764,7 +1764,7 @@ static void subflow_state_change(struct sock *sk)
> 	}
> }
>
> -void mptcp_subflow_queue_clean(struct sock *listener_ssk)
> +void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
> {
> 	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
> 	struct mptcp_sock *msk, *next, *head = NULL;
> @@ -1813,8 +1813,18 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
>
> 		do_cancel_work = __mptcp_close(sk, 0);
> 		release_sock(sk);
> -		if (do_cancel_work)
> +		if (do_cancel_work) {
> +			/* lockdep will report a false positive ABBA deadlock between
> +			 * cancel_work_sync and the listener socket. The involved locks
> +			 * belong to differen sockets WRT the existing AB chain.

s/differen/different/

> +			 * Using a per socket key would be very invasive and heavy, just
> +			 * tell lockdep to consider the listener socket released here
> +			 */
> +			mutex_release(&listener_sk->sk_lock.dep_map, _RET_IP_);
> 			mptcp_cancel_work(sk);
> +			mutex_acquire(&listener_sk->sk_lock.dep_map,
> +				      SINGLE_DEPTH_NESTING, 0, _RET_IP_);

Any concerns about this change breaking lockdep if the existing 
assumptions about listener sockets no longer apply? For example, if 
someone made the unfortunate choice to start using mptcp_worker() with a 
MPTCP listener sock?

Maybe it would help to add code in mptcp_worker() to check the 
"mptcp_worker() isn't used with TCP_LISTEN sockets" assumption to ensure 
that the above workaround doesn't hide future issues. Or maybe I'm being 
too paranoid :)


> +		}
> 		sock_put(sk);
> 	}
>
> -- 
> 2.38.1
>
>
>

--
Mat Martineau
Intel
