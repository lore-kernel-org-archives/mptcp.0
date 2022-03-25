Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52A7E
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648252725; x=1679788725;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oYZtKpSkTW0d2+lXzyYvYV8zM7MqAzoj659O4VpXGIs=;
  b=hzjgAcEt06KEBhAzsvtU/RjTDZlcQ1cVcl8S5mPQnTuO20os1mpXZt2u
   f57fvr9xvarhgFZan/Bav+Gio7VT/qv063sUibsSFsM/hzbmCplJ/Oe4j
   8KAYBGbHl+SVAHPlMqgQfKsEMI5mqIRVfKhIm2DPc/jXv9XsUsW+nuYTZ
   DmdArkyjzqs7pYeUxk9kZ1yC9q1sezHi8gZ4acI6DBJcY05T3J5nY52yR
   QPeh/7DtvoAPSHSlIu6mGmbuAYbNxoOhE+Q1c6NVYoAFoVdNol8dqC4z3
   PUPxMge9Sw7lamSl5o75X4M4y59L2kN/pKdhD2FCJ4rkq1Pxh78vZi5mM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="345175167"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="345175167"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:58:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="520371268"
Received: from ivbeskor-mobl1.amr.corp.intel.com ([10.209.23.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:58:44 -0700
Date: Fri, 25 Mar 2022 16:58:44 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 4/8] mptcp: add sched in mptcp_sock
In-Reply-To: <19e9377ac9a72587f729820fc793ebdca12d7424.1648223504.git.geliang.tang@suse.com>
Message-ID: <8163387d-485c-d972-4924-c347c88564f8@linux.intel.com>
References: <cover.1648223504.git.geliang.tang@suse.com> <19e9377ac9a72587f729820fc793ebdca12d7424.1648223504.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 26 Mar 2022, Geliang Tang wrote:

> This patch added a new struct member sched in struct mptcp_sock.
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
> net/mptcp/sched.c    | 21 +++++++++++++++++++++
> 3 files changed, 29 insertions(+)
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
> index 9ad7d83767fa..b70582f9c3c9 100644
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
> struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> void mptcp_sched_init(void);
> void mptcp_sched_data_init(struct sock *sk);
> +void mptcp_init_sched(struct mptcp_sock *msk,
> +		      struct mptcp_sched_ops *sched);
> +void mptcp_release_sched(struct mptcp_sock *msk);
>
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 1fb3dd24d6ff..5ccdb1756dc6 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -125,3 +125,24 @@ void mptcp_sched_data_init(struct sock *sk)
> {
> 	mptcp_register_scheduler(sock_net(sk), &mptcp_sched_default);
> }
> +
> +void mptcp_init_sched(struct mptcp_sock *msk,
> +		      struct mptcp_sched_ops *sched)
> +{
> +	if (!sched)
> +		msk->sched = &mptcp_sched_default;
> +	else
> +		msk->sched = sched;
> +

The msk has a direct pointer to the scheduler object now. The scheduler 
could be unregistered at any time, making this pointer invalid.

The TCP CA comments mention a reference count for the non-bpf CA modules, 
but is that handled for schedulers? Does each scheduler have to implement 
that in their init/release hooks? If so, would be good to document that in 
the struct mptcp_sched_ops declaration comments.

> +	if (msk->sched->init)
> +		msk->sched->init(msk);
> +
> +	pr_debug("sched=%s", msk->sched->name);
> +}
> +
> +void mptcp_release_sched(struct mptcp_sock *msk)
> +{
> +	if (msk->sched && msk->sched->release)
> +		msk->sched->release(msk);
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
