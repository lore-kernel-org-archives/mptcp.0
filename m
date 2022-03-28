Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724C7C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:49:28 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nYlzz-00059L-2L; Mon, 28 Mar 2022 11:49:19 +0200
Date: Mon, 28 Mar 2022 11:49:19 +0200
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-next v7 1/8] mptcp: add struct mptcp_sched_ops
Message-ID: <20220328094919.GB18687@breakpoint.cc>
References: <cover.1648459865.git.geliang.tang@suse.com>
 <033f8762a38a1d4a838bc737104c609d86fec8cf.1648459865.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033f8762a38a1d4a838bc737104c609d86fec8cf.1648459865.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliang.tang@suse.com> wrote:
> This patch defines struct mptcp_sched_ops, which has three struct members,
> name, owner and list, and three function pointers, init, release and
> get_subflow.
> 
> Add the scheduler registering, unregistering and finding functions to add
> or delete or find a packet scheduler on the pernet sched_list.
> 
> Suggested-by: Florian Westphal <fw@strlen.de>

Huh?  I made some comments on earlier patch but I did not suggest this.
In fact, I don't like this at all but I guess I've been vetoed wrt.
pernet design.

> +struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
> +					 const char *name)
> +{
> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +	struct mptcp_sched_ops *sched, *ret = NULL;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(sched, &pernet->sched_list, list) {
> +		if (!strcmp(sched->name, name)) {
> +			ret = sched;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return ret;

This is fishy.  Either caller must already hold rcu read lock,
or mptcp_sched_ops can be free'd before function returns.

I suspect its best to force callers to do the rcu_read_lock and
document that this function is called with rcu read lock held.

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

This is racy.  Lock, test, add, unlock, not test, lock, ...

> +	spin_lock(&pernet->lock);
> +	list_del_rcu(&sched->list);
> +	spin_unlock(&pernet->lock);
> +
> +	/* avoid workqueue lockup */
> +	synchronize_rcu();

Hmm.  You mean 'wait until rcu read sides are done'?
But even that makes little sense to me.

There is no free operation done here so this is safe even
without synchronize_rcu()?
