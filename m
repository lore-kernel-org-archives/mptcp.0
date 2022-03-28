Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB44366
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 13:49:07 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nYpk2-0006V4-1A; Mon, 28 Mar 2022 15:49:06 +0200
Date: Mon, 28 Mar 2022 15:49:06 +0200
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang.tang@suse.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 1/8] mptcp: add struct mptcp_sched_ops
Message-ID: <20220328134906.GD18687@breakpoint.cc>
References: <cover.1648459865.git.geliang.tang@suse.com>
 <033f8762a38a1d4a838bc737104c609d86fec8cf.1648459865.git.geliang.tang@suse.com>
 <20220328094919.GB18687@breakpoint.cc>
 <20220328131134.GA1310@localhost>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328131134.GA1310@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliang.tang@suse.com> wrote:
> > > +	if (!sched->get_subflow)
> > > +		return -EINVAL;
> > > +
> > > +	if (mptcp_sched_find(net, sched->name))
> > > +		return -EEXIST;
> > > +
> > > +	spin_lock(&pernet->lock);
> > > +	list_add_tail_rcu(&sched->list, &pernet->sched_list);
> > > +	spin_unlock(&pernet->lock);
> > 
> > This is racy.  Lock, test, add, unlock, not test, lock, ...
> 
> How should I fix this?

spin_lock(&pernet->lock);
if (mptcp_sched_find(net, sched->name)) {
	spin_unlock(&pernet->lock);
	return -EEXIST;
}
list_add_....
