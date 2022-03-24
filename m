Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7D1FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:27:55 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nXORN-0007AA-CK; Thu, 24 Mar 2022 15:27:53 +0100
Date: Thu, 24 Mar 2022 15:27:53 +0100
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v5 1/8] mptcp: add struct
 mptcp_sched_ops
Message-ID: <20220324142753.GD24666@breakpoint.cc>
References: <cover.1648130637.git.geliang.tang@suse.com>
 <4df8257d4783911e933bdf3a3ddcfbac1c9db4f1.1648130637.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df8257d4783911e933bdf3a3ddcfbac1c9db4f1.1648130637.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliang.tang@suse.com> wrote:
> This patch added struct mptcp_sched_ops. And define the scheduler
> register, unregister and find functions.

... but why are they pernet?  Makes no sense to me, so an
explanation would help.  Or, remove the pernet ops.

All callers pass &init_net, so I don't think there is any reason
for pernet data structures here.

> +struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
> +					 const char *name)
> +{
> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +	struct mptcp_sched_ops *sched, *ret = NULL;
> +
> +	spin_lock(&pernet->lock);
> +	list_for_each_entry_rcu(sched, &pernet->sched_list, list) {
> +		if (!strcmp(sched->name, name)) {
> +			ret = sched;
> +			break;
> +		}
> +	}
> +	spin_unlock(&pernet->lock);
> +

Locking isn't needed here if caller holds rcu read lock.

> +int mptcp_register_scheduler(const struct net *net,
> +			     struct mptcp_sched_ops *sched)
> +{
> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +
> +	if (!sched->get_subflow)
> +		return -EINVAL;
> +
> +	if (mptcp_sched_find(net, sched->name))
> +		return -EEXIST;
> +
> +	spin_lock(&pernet->lock);
> +	list_add_tail_rcu(&sched->list, &pernet->sched_list);
> +	spin_unlock(&pernet->lock);

I would use global list/lock, not pernet registration.
I don't see a reason why that is needed, its just duplicate info.

> +void mptcp_unregister_scheduler(const struct net *net,
> +				struct mptcp_sched_ops *sched)
> +{
> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +
> +	spin_lock(&pernet->lock);
> +	list_del_rcu(&sched->list);
> +	spin_unlock(&pernet->lock);
> +
> +	synchronize_rcu();

Why synchronize_rcu()?  Comment please why that is needed, no freeing
happens?

> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +	struct mptcp_sched_ops *sched;
> +
> +	spin_lock(&pernet->lock);
> +	list_for_each_entry_rcu(sched, &pernet->sched_list, list)
> +		list_del_rcu(&sched->list);
> +	spin_unlock(&pernet->lock);
> +
> +	synchronize_rcu();

Same, why is it needed?
