Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5115886C
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380055; cv=none; b=gnsqoGcefmbrCwd6OSJ8Ays1QdwJ4e0ou1NHtzYCljF8kxL9u42dZqoXeTn2np+Rj2b2ZRJ1xCApEXCJYaUsQI15zSC+RGCzc7YCVhCOD7ocGzT2Y8GWCV7n7uUf5a51S7CVx8gh+gR0QbIANOWemWxkdqlflUNY21cWut6Y8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380055; c=relaxed/simple;
	bh=4V8wUDFwNfH9SPX2nbDnwNXY+KgKcQgwprQXQvaZlbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cekVX+YqS0oUfthkv/dQvy93acstbhiSf2ZxooTvUM0Lhf+Kr1QmMqtL458kLYGoZAAqv0BnQ9QqFPx0ZQGx69l+DauiYZb019660cm8C6Sr4b7hBEMuh++ogpNMt0hA6KdxPhXrpXrOFKNktmdwWrHVtLSHs/NHjIDuM9Z9Plg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciRqHtyy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciRqHtyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F48C4CED6;
	Mon, 24 Feb 2025 06:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740380055;
	bh=4V8wUDFwNfH9SPX2nbDnwNXY+KgKcQgwprQXQvaZlbc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ciRqHtyyKGUTyLZNaxruV/FEa5asNnfQsd2R6ZL2Jk2ue54KfMtNL7+T773sdwOip
	 imna+V+2MGvwcbytmIsN/cl3lmWtiKcDR7XX36HtBrhn4SS4VLtrrQuMMZNOZuH8Vu
	 QVe596BOj3RA1lwu6XbX4hbbdYRxUU8Y1BbFwhRjzYGfZoGz5oUmzveeUR/ACGo2vL
	 8SEMhVgVwi7DjxzFPizkeQ74DXdSy65zjBP3T8w4JeLxHbeEWtL7dqtOS9x+UrOt4y
	 S1e+JT8EzlC4M25oZ5m6TopvKr/MIzLyV1ub4+mGsJfiqMFjcgR/ipbVc2xPXEAWdw
	 8IsBzvHc0thng==
Message-ID: <328be50889c11a6358d360d5454f8b7a6ed200b7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 4/9] mptcp: pm: define struct mptcp_pm_ops
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 24 Feb 2025 14:54:10 +0800
In-Reply-To: <b7333a19-921a-41e1-9a87-ff70aab3e000@kernel.org>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
	 <5f83856741646b16dde9a741fcfbfa55753eee39.1740019794.git.tanggeliang@kylinos.cn>
	 <b7333a19-921a-41e1-9a87-ff70aab3e000@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for the review.

On Fri, 2025-02-21 at 18:23 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 20/02/2025 03:57, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > In order to allow users to develop their own BPF-based path
> > manager,
> > this patch defines a struct ops "mptcp_pm_ops" for a userspace path
> > manager, which contains a set of interfaces.
> > 
> > Add a set of functions to register, unregister, find and validate a
> > given struct ops.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  include/net/mptcp.h  | 29 ++++++++++++++++++++++
> >  net/mptcp/pm.c       | 59
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  net/mptcp/protocol.h |  5 ++++
> >  3 files changed, 93 insertions(+)
> > 
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index a41d6c74760f..f51e75d3882d 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -134,6 +134,35 @@ struct mptcp_pm_param {
> >  	struct mptcp_addr_info		addr;
> >  };
> >  
> > +struct mptcp_pm_ops {
> > +	int (*created)(struct mptcp_sock *msk);
> > +	int (*established)(struct mptcp_sock *msk);
> > +	int (*closed)(struct mptcp_sock *msk);
> > +	int (*address_announced)(struct mptcp_sock *msk,
> > +				 struct mptcp_pm_param *param);
> > +	int (*address_removed)(struct mptcp_sock *msk,
> > +			       struct mptcp_pm_param *param);
> > +	int (*subflow_established)(struct mptcp_sock *msk,
> > +				   struct mptcp_pm_param *param);
> > +	int (*subflow_closed)(struct mptcp_sock *msk,
> > +			      struct mptcp_pm_param *param);
> > +	int (*get_local_id)(struct mptcp_sock *msk,
> > +			    struct mptcp_pm_param *param);
> > +	bool (*get_priority)(struct mptcp_sock *msk,
> > +			     struct mptcp_pm_param *param);
> > +	int (*set_priority)(struct mptcp_sock *msk,
> > +			    struct mptcp_pm_param *param);
> > +	int (*listener_created)(struct mptcp_sock *msk);
> > +	int (*listener_closed)(struct mptcp_sock *msk);
> > +
> > +	u8			type;
> 
> I guess the type matches net.mptcp.pm_type sysctl knob, right?
> 
> I wonder if we should not deprecate this sysctl, and use a string
> like
> with the scheduler. So instead, we could have:
> 
>   char			name[MPTCP_PM_NAME_MAX];
> 
> And on ctrl.c, we could map pm_type for the moment with a custom
> proc_handler (and even remove this sysctl knob in a few releases):
> 
>  - 0  → in-kernel
>  - 1  → userspace
>  - >1 → bpf

Do we need to restrict BPF path manager to only extend the userspace
type path manager? That is, for all BPF path managers,
mptcp_pm_is_userspace() returns true. If this is the case, there is no
need to add "type" field in struct mptcp_pm_ops.

Is it necessary to allow BPF to create kernel type path managers, that
is, path managers for which mptcp_pm_is_userspace() returns false?
Since we registered mptcp_netlink_pm from this version, can the in-
kernel type path manager also be extended by BPF? If this is the case,
we need to add "type" field in struct mptcp_pm_ops to distinguish
whether it is a userspace type path manager.

> 
> WDYT? Would it not be clearer for devs and users?
> 
> Note that if for the implementation, if it is easier to keep this
> "type"
> entry for the moment for the sysctl stuff, I'm fine with that. But if
> we
> don't need it, let's not introduce it.
> 
> > +	struct module		*owner;
> > +	struct list_head	list;
> > +
> > +	void (*init)(struct mptcp_sock *msk);
> > +	void (*release)(struct mptcp_sock *msk);
> 
> To answer my question from the v3 review: the init/release is done
> for
> each MPTCP connection handled by this PM.

In-kernel pm is for each MPTCP connection handled by this PM while
userspace pm is only for this one being initialized. How should I deal
with this? Please give me more detailed suggestions.

Thanks,
-Geliang

> 
> > +} ____cacheline_aligned_in_smp;
> > +
> >  #ifdef CONFIG_MPTCP
> >  void mptcp_init(void);
> >  
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index e3457f34621c..f56b2d1e3409 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -6,12 +6,17 @@
> >  #define pr_fmt(fmt) "MPTCP: " fmt
> >  
> >  #include <linux/kernel.h>
> > +#include <linux/rculist.h>
> > +#include <linux/spinlock.h>
> >  #include <net/mptcp.h>
> >  #include "protocol.h"
> >  
> >  #include "mib.h"
> >  #include "mptcp_pm_gen.h"
> >  
> > +static DEFINE_SPINLOCK(mptcp_pm_list_lock);
> > +static LIST_HEAD(mptcp_pm_list);
> > +
> >  /* path manager command handlers */
> >  
> >  int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> > @@ -661,3 +666,57 @@ void __init mptcp_pm_init(void)
> >  {
> >  	mptcp_pm_nl_init();
> >  }
> > +
> > +/* Must be called with rcu read lock held */
> > +struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type)
> > +{
> > +	struct mptcp_pm_ops *pm;
> > +
> > +	list_for_each_entry_rcu(pm, &mptcp_pm_list, list) {
> > +		if (pm->type == type)
> > +			return pm;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +int mptcp_pm_validate(struct mptcp_pm_ops *pm)
> > +{
> > +	if (!pm->created && !pm->established && !pm->closed &&
> > +	    !pm->address_announced && !pm->address_removed &&
> > +	    !pm->subflow_established && !pm->subflow_closed &&
> > +	    !pm->get_local_id && !pm->get_priority && !pm-
> > >set_priority &&
> > +	    !pm->listener_created && !pm->listener_closed) {
> 
> I'm not sure to understand the purpose of this validation.
> 
> Why not forcing some or all of them?
> 
> (...)
> 
> Cheers,
> Matt

