Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B292363
	for <mptcp@lists.linux.dev>; Sat, 15 Oct 2022 00:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665793535; x=1697329535;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j5KjOui8szl6WY+akd9ZW0ZfZdKW69n1KkDsAkhxaG8=;
  b=GvisBwrJzwp4g5koL+BTN6EZmz0t4kQn4/K3n/cYrwkWZLGtlMO6+uP2
   zkGU3PKb+yV+FnnUX2Kw1/eaoKe5iV0WOwITiMC+MOxSHTGUuj6e3zwHp
   1mGbszIpY9ce9G0PjbnFLCiAKtDd5ncaUOzcuO2GyN3VvBj7lB9+8d0uN
   a38m7ySzMXPL8fHSWwVvCqGrtO4zuGp6xozUODxhZXAPDzoCaqnR4Kb1W
   SMcIpT/RvFB1tjYY9hLjCOB3smgzJwWRdrP0+iEaJYr883a8mho7eEP2c
   TR500trgga+jOKB2uU+kEJeGtd4E9BkZj3MPQ4MdpfjfwVuVpIr96Vwbj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="391805669"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="391805669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 17:25:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="605546991"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="605546991"
Received: from mcunning-mobl1.amr.corp.intel.com ([10.212.193.28])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 17:25:33 -0700
Date: Fri, 14 Oct 2022 17:25:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 09/15] mptcp: register default scheduler
In-Reply-To: <39bb9f95dc6bb94f22df5522b46f427c0888b415.1665753926.git.geliang.tang@suse.com>
Message-ID: <cd65e183-104f-5c0b-a8b6-bf8c67e16364@linux.intel.com>
References: <cover.1665753926.git.geliang.tang@suse.com> <39bb9f95dc6bb94f22df5522b46f427c0888b415.1665753926.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 Oct 2022, Geliang Tang wrote:

> This patch defines the default packet scheduler mptcp_sched_default.
> Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
> Skip deleting this default scheduler in mptcp_unregister_scheduler().
>
> Set msk->sched to the default scheduler when the input parameter of
> mptcp_init_sched() is NULL.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Hi Geliang -

Is there a benefit to registering the default scheduler? It adds an 
indirect call for the common case of using the default scheduler.

The scheduler wrappers can make direct calls to the default scheduler if 
msk->sched is NULL. It looks like this is partially handled already in 
"mptcp: add scheduler wrappers", so it doesn't seem necessary to handle it 
both ways. Some changes to setting the "default" scheduler and handling 
that name as a special case would still be needed.

- Mat

> ---
> net/mptcp/protocol.c |  7 ++++---
> net/mptcp/protocol.h |  4 ++++
> net/mptcp/sched.c    | 38 ++++++++++++++++++++++++++++++++++++--
> 3 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 106d22730954..93c2b5d71254 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1406,8 +1406,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>  * returns the subflow that will transmit the next DSS
>  * additionally updates the rtx timeout
>  */
> -static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
> -					   struct mptcp_sched_data *data)
> +struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
> +				    struct mptcp_sched_data *data)
> {
> 	struct subflow_send_info send_info[SSK_MODE_MAX];
> 	struct mptcp_subflow_context *subflow;
> @@ -2184,7 +2184,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
>  *
>  * A backup subflow is returned only if that is the only kind available.
>  */
> -static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
> +struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
> {
> 	struct sock *backup = NULL, *pick = NULL;
> 	struct mptcp_subflow_context *subflow;
> @@ -3851,6 +3851,7 @@ void __init mptcp_proto_init(void)
>
> 	mptcp_subflow_init();
> 	mptcp_pm_init();
> +	mptcp_sched_init();
> 	mptcp_token_init();
>
> 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) != 0)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e553fe70f9a2..cdea1efb14a5 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -633,11 +633,15 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> struct mptcp_sched_ops *mptcp_sched_find(const char *name);
> int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
> void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
> +void mptcp_sched_init(void);
> int mptcp_init_sched(struct mptcp_sock *msk,
> 		     struct mptcp_sched_ops *sched);
> void mptcp_release_sched(struct mptcp_sock *msk);
> void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> 				 bool scheduled);
> +struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
> +				    struct mptcp_sched_data *data);
> +struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
>
> static inline bool __tcp_can_send(const struct sock *ssk)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 0d7c73e9562e..92057ca94cf4 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -16,6 +16,33 @@
> static DEFINE_SPINLOCK(mptcp_sched_list_lock);
> static LIST_HEAD(mptcp_sched_list);
>
> +static void mptcp_sched_default_data_init(const struct mptcp_sock *msk,
> +					  struct mptcp_sched_data *data)
> +{
> +	data->snd_burst = 0;
> +}
> +
> +static int mptcp_sched_default_get_subflow(const struct mptcp_sock *msk,
> +					   struct mptcp_sched_data *data)
> +{
> +	struct sock *ssk;
> +
> +	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
> +			       mptcp_subflow_get_send(msk, data);
> +	if (!ssk)
> +		return -EINVAL;
> +
> +	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
> +	return 0;
> +}
> +
> +static struct mptcp_sched_ops mptcp_sched_default = {
> +	.data_init	= mptcp_sched_default_data_init,
> +	.get_subflow    = mptcp_sched_default_get_subflow,
> +	.name           = "default",
> +	.owner          = THIS_MODULE,
> +};
> +
> /* Must be called with rcu read lock held */
> struct mptcp_sched_ops *mptcp_sched_find(const char *name)
> {
> @@ -50,16 +77,24 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
>
> void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
> {
> +	if (sched == &mptcp_sched_default)
> +		return;
> +
> 	spin_lock(&mptcp_sched_list_lock);
> 	list_del_rcu(&sched->list);
> 	spin_unlock(&mptcp_sched_list_lock);
> }
>
> +void mptcp_sched_init(void)
> +{
> +	mptcp_register_scheduler(&mptcp_sched_default);
> +}
> +
> int mptcp_init_sched(struct mptcp_sock *msk,
> 		     struct mptcp_sched_ops *sched)
> {
> 	if (!sched)
> -		goto out;
> +		sched = &mptcp_sched_default;
>
> 	if (!bpf_try_module_get(sched, sched->owner))
> 		return -EBUSY;
> @@ -70,7 +105,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
>
> 	pr_debug("sched=%s", msk->sched->name);
>
> -out:
> 	return 0;
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
