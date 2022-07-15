Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B44C65
	for <mptcp@lists.linux.dev>; Fri, 15 Jul 2022 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657912422; x=1689448422;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MbX6yjztcUfni/RounbCGEaCW/K4UNjn/BSgWxgfFpo=;
  b=awAbvqWAm0pVeqJCjWa8aS6Mn7iT4yv2teUq30rEU+FdEepGIA1SEnFA
   sHotP1j2sU096fstgDX9fotcjOsa08gzYSDjAEYqAJ8vMGtfahdr7GnIf
   Bysfb3ikyI4MtKruuJZAuWJsmg6/uTT2p76qcbm1eLstWnFdqmIG/GbYp
   bG/7s8Japp0OiDCvbHQs/u845v+hYEz54qywEV4DMSAu7y03Wc6y3k85Z
   b8z48mKlfZQcgvsPTR0JlpYl+x6Doh+4ygnwdHhL23re8xkgIh357XTiy
   hojJXOeADfh/qB5xMFETkYwDg8VRIwkzug0cxHvAzj+dGYxHNGAfaOGw3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="286617077"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="286617077"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:13:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="546765287"
Received: from ticeal-or-008.amr.corp.intel.com ([10.255.229.216])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:13:41 -0700
Date: Fri, 15 Jul 2022 12:13:41 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, phind.uet@gmail.com
Subject: Re: [PATCH mptcp-net] mptcp: move subflow cleanup in
 mptcp_destroy_common()
In-Reply-To: <bcfa7cfc41ada0c8811794cb3c45cdeb1b34f303.1657883173.git.pabeni@redhat.com>
Message-ID: <3e824615-67a2-77c5-6752-572fb17a71d5@linux.intel.com>
References: <bcfa7cfc41ada0c8811794cb3c45cdeb1b34f303.1657883173.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 15 Jul 2022, Paolo Abeni wrote:

> If the mptcp socket creation fails due to a CGROUP_INET_SOCK_CREATE
> eBPF program, the MPTCP protocol ends-up leaking all the subflows:
> the related cleanup happens in __mptcp_destroy_sock() that is not
> invoked in such code path.
>
> Address the issue moving the subflow sockets cleanup in the
> mptcp_destroy_common() helper, which is invoked in every msk cleanup
> path.
>
> Additionally get rid of the intermediate list_splice_init step, which
> is an unneeded relic from the past.
>
> The issue is present since before the reported root cause commit, but
> any attempt to backport the fix before that hash will require a complete
> rewrite.
>
> Fixes: e16163b6e2 ("mptcp: refactor shutdown and close")
> Reported-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Co-developed-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> The tags are provisional, waiting for Nguyen feedback/preferences.
>
> Sending out early to trigger the CI.

For some reason patchew didn't tag this commit, so the CI didn't trigger. 
Patchew did tag my patch about a half hour ago, so the importer doesn't 
seem to be completely offline.

I manually pushed a tag: patchew/20220715-pabeni-subflow-cleanup

That has started the github and cirrus-ci builds:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2678690859
https://cirrus-ci.com/build/4905612499746816


I also noticed that this patch conflicts with Matthieu's "mptcp: add 
mptcp_for_each_subflow_safe helper" patch, but that's only in the export 
branch currently so we can easily wait on that until your -net fix 
propagates to net-next.


One more question below (about mptcp_dispose_initial_subflow), but 
assuming the CI results are ok I think this would be good to apply to 
export-net and squash further fixes if needed:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> This will need likely some staging period.
>
> "mptcp: add mptcp_for_each_subflow_safe helper" needs to be rebased
> on top of this (we can replace another list_for_each_safe instance)
> ---
> net/mptcp/protocol.c | 39 +++++++++++++++------------------------
> net/mptcp/protocol.h |  2 +-
> net/mptcp/subflow.c  |  3 ++-
> 3 files changed, 18 insertions(+), 26 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 21a3ed64226e..6f3324955355 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2804,30 +2804,16 @@ static void __mptcp_wr_shutdown(struct sock *sk)
>
> static void __mptcp_destroy_sock(struct sock *sk)
> {
> -	struct mptcp_subflow_context *subflow, *tmp;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	LIST_HEAD(conn_list);
>
> 	pr_debug("msk=%p", msk);
>
> 	might_sleep();
>
> -	/* join list will be eventually flushed (with rst) at sock lock release time*/
> -	list_splice_init(&msk->conn_list, &conn_list);
> -
> 	mptcp_stop_timer(sk);
> 	sk_stop_timer(sk, &sk->sk_timer);
> 	msk->pm.status = 0;
>
> -	/* clears msk->subflow, allowing the following loop to close
> -	 * even the initial subflow
> -	 */
> -	mptcp_dispose_initial_subflow(msk);
> -	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -		__mptcp_close_ssk(sk, ssk, subflow, 0);
> -	}
> -
> 	sk->sk_prot->destroy(sk);
>
> 	WARN_ON_ONCE(msk->rmem_fwd_alloc);
> @@ -2919,24 +2905,20 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
>
> static int mptcp_disconnect(struct sock *sk, int flags)
> {
> -	struct mptcp_subflow_context *subflow, *tmp;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> 	inet_sk_state_store(sk, TCP_CLOSE);
>
> -	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -
> -		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
> -	}
> -
> 	mptcp_stop_timer(sk);
> 	sk_stop_timer(sk, &sk->sk_timer);
>
> 	if (mptcp_sk(sk)->token)
> 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
>
> -	mptcp_destroy_common(msk);
> +	/* msk->subflow is still intact, the following will not free the first
> +	 * subflow
> +	 */
> +	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
> 	msk->last_snd = NULL;
> 	WRITE_ONCE(msk->flags, 0);
> 	msk->cb_flags = 0;
> @@ -3086,12 +3068,17 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
> 	return newsk;
> }
>
> -void mptcp_destroy_common(struct mptcp_sock *msk)
> +void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> {
> +	struct mptcp_subflow_context *subflow, *tmp;
> 	struct sock *sk = (struct sock *)msk;
>
> 	__mptcp_clear_xmit(sk);
>
> +	/* join list will be eventually flushed (with rst) at sock lock release time */
> +	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node)
> +		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
> +
> 	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
> 	mptcp_data_lock(sk);
> 	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
> @@ -3113,7 +3100,11 @@ static void mptcp_destroy(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> -	mptcp_destroy_common(msk);
> +	/* clears msk->subflow, allowing the following to close
> +	 * even the initial subflow
> +	 */
> +	mptcp_dispose_initial_subflow(msk);

Was the missing call to mptcp_displose_initial_subflow() also causing a 
problem? Or did this cleanup end up happening through a different path?

This seems different from the "leaking all subflows" case mentioned in the 
commit message.

- Mat

> +	mptcp_destroy_common(msk, 0);
> 	sk_sockets_allocated_dec(sk);
> }
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 480c5320b86e..78c8c471b22e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -718,7 +718,7 @@ static inline void mptcp_write_space(struct sock *sk)
> 	}
> }
>
> -void mptcp_destroy_common(struct mptcp_sock *msk);
> +void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
>
> #define MPTCP_TOKEN_MAX_RETRIES	4
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 63e8892ec807..fc4ceb02328d 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -621,7 +621,8 @@ static void mptcp_sock_destruct(struct sock *sk)
> 		sock_orphan(sk);
> 	}
>
> -	mptcp_destroy_common(mptcp_sk(sk));
> +	/* We don't need to clear msk->subflow, as it's still NULL at this point */
> +	mptcp_destroy_common(mptcp_sk(sk), 0);
> 	inet_sock_destruct(sk);
> }
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
