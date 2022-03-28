Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6317E7
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 22:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648507667; x=1680043667;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lrEltdH2qGeEZR5JJRWi50eP6jaySDQInIyoRWm8HX0=;
  b=TYS+Yy+AqSthfsehWzPDdj6k1tH2NBs+asUkYoU5fDSMsafaPrnFsBoA
   lb3SOCNcuY7QTOkCKOWD7iRCPHr+ulB7nQHSjgw/q0vmUa8JlIE/DEIRV
   j+7TePhFppyGQFgSH2v1++w+f9S3PwQ7v8d0j6l1FyvDI72DSiCLp1foJ
   zExgzBqyUBpXX9YEjvNBzcco9lUAFxJ3Sfu1Nyf9RQ9MSWRk8Gmzli0in
   m4mTJXltcRnuKtVzE4Jxt3JqesjKmPH1pB9XVDHQ1SI/REWu+w/BxYgLb
   OPGzw+4Iivb6i60OKDFfCQbTU4qIS7HBywfwWFJi3zjqd3turCGvxIs0c
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="345552860"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="345552860"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:47:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="694518115"
Received: from pchung1-mobl.amr.corp.intel.com ([10.209.44.61])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:47:47 -0700
Date: Mon, 28 Mar 2022 15:47:46 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 4/8] mptcp: add sched in mptcp_sock
In-Reply-To: <2812381119c23048dadbf5372293c724ff4b7970.1648459865.git.geliang.tang@suse.com>
Message-ID: <bb912e65-412f-1f2a-dab8-2c1f3fa374b@linux.intel.com>
References: <cover.1648459865.git.geliang.tang@suse.com> <2812381119c23048dadbf5372293c724ff4b7970.1648459865.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 28 Mar 2022, Geliang Tang wrote:

> This patch adds a new struct member sched in struct mptcp_sock.
> And two helpers mptcp_init_sched() and mptcp_release_sched() to
> init and release it.
>
> Init it with the sysctl scheduler in mptcp_init_sock(), copy the
> scheduler from the parent in mptcp_sk_clone(), and release it in
> __mptcp_destroy_sock().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c |  4 ++++
> net/mptcp/protocol.h |  4 ++++
> net/mptcp/sched.c    | 27 +++++++++++++++++++++++++++
> 3 files changed, 35 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2c684034fe7a..82b3846147a6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2662,6 +2662,8 @@ static int mptcp_init_sock(struct sock *sk)
> 	 * propagate the correct value
> 	 */
> 	mptcp_ca_reset(sk);
> +	mptcp_init_sched(mptcp_sk(sk),
> +			 mptcp_sched_find(net, mptcp_get_scheduler(net)));
>
> 	sk_sockets_allocated_inc(sk);
> 	sk->sk_rcvbuf = sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
> @@ -2817,6 +2819,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
> 	sk_stop_timer(sk, &sk->sk_timer);
> 	mptcp_data_unlock(sk);
> 	msk->pm.status = 0;
> +	mptcp_release_sched(msk);
>
> 	/* clears msk->subflow, allowing the following loop to close
> 	 * even the initial subflow
> @@ -2994,6 +2997,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	msk->snd_una = msk->write_seq;
> 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
> 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
> +	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
>
> 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
> 		msk->can_ack = true;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index dd4a2afdb38b..81c35af7ade5 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -288,6 +288,7 @@ struct mptcp_sock {
> 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
> 	struct sock	*first;
> 	struct mptcp_pm_data	pm;
> +	struct mptcp_sched_ops	*sched;
> 	struct {
> 		u32	space;	/* bytes copied in last measurement window */
> 		u32	copied; /* bytes copied in this measurement window */
> @@ -618,6 +619,9 @@ void mptcp_unregister_scheduler(const struct net *net,
> void mptcp_sched_init(void);
> struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> void mptcp_sched_data_init(struct sock *sk);
> +int mptcp_init_sched(struct mptcp_sock *msk,
> +		     struct mptcp_sched_ops *sched);
> +void mptcp_release_sched(struct mptcp_sock *msk);
>
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 1fb3dd24d6ff..9b3a3157111d 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -125,3 +125,30 @@ void mptcp_sched_data_init(struct sock *sk)
> {
> 	mptcp_register_scheduler(sock_net(sk), &mptcp_sched_default);
> }
> +
> +int mptcp_init_sched(struct mptcp_sock *msk,
> +		     struct mptcp_sched_ops *sched)
> +{
> +	if (!sched)
> +		msk->sched = &mptcp_sched_default;
> +	else
> +		msk->sched = sched;
> +
> +	if (!bpf_try_module_get(msk->sched, msk->sched->owner))
> +		return -EBUSY;

The bpf_try_module_get() should be before msk->sched is assigned.

> +
> +	if (msk->sched->init)
> +		msk->sched->init(msk);
> +
> +	pr_debug("sched=%s", msk->sched->name);
> +
> +	return 0;
> +}
> +
> +void mptcp_release_sched(struct mptcp_sock *msk)
> +{
> +	if (msk->sched && msk->sched->release)
> +		msk->sched->release(msk);

Looks like the null check here is already addressed in the squash-to 
patch.

> +	bpf_module_put(msk->sched, msk->sched->owner);

Would be better to store a local pointer to the sched struct and clear 
msk->sched before doing the bpf_module_put() call. With the RCU grace 
period it's not likely to be a problem but might as well do the put last.

> +	msk->sched = NULL;
> +}
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
