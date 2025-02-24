Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270F24502A
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388280; cv=none; b=ljwFgucGfUr8NyZ+y1bng3GXup3c/78+TEBPChOCqXSGhs59BJK4nZdnGrBlUdA++QrACrow+bn6QaJ5Z7DJ8TCG+8XW3WjaWyjq5lWj/WFcm28fYykGIa9sC5Rigl2YHI0oCasuy3Xs85RKmHvK8cmT4W6ryrY7xyPuVYiwnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388280; c=relaxed/simple;
	bh=CzZEAENvZGM9fN6Vi1fYlrFqe1JIUZnML3GtZKylfjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Irg4p1rZRnK2IEFnbONTqJGrGmpGASIDxFqmZrMtJ89ldK8mDHqA1pRo41uMxUrqlpc7ve85+BqApPw3p3LNYjp5D0HMZCE2W7hEW0JGP33705V9T/PX4nX3H5IuCPbhaqp585bVzunTc7JAKh5uCS1UQS+b9/x6hpsZ2iWyhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsFzdPlt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsFzdPlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6475EC4CED6;
	Mon, 24 Feb 2025 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388280;
	bh=CzZEAENvZGM9fN6Vi1fYlrFqe1JIUZnML3GtZKylfjA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tsFzdPlt6tWhBIDNGzck73YVS4M+0AK1D8WG5ueOEEgBPe3xlXLHN/7gGySR7e7Lj
	 0WNhQC0q4+sk5e0EIgpcWs4C1QEwwgw2nurcmfrklfgOYUsZcayZ/E58kZsemaR6EL
	 gg6VL+sir1WieGbhXRrtESeeNFbOUJvnS202jVkzP2aEhENT9g5Tg70gh54ilPSM0R
	 SrYL8DFka45Q58JC/Q3K/kcjrUS//40xUPuZ+mzfgRqV/aaD8CWxRx1JNgJtIIcaEs
	 5ufGGNkuvntcx9fo2pOjb1TGRDNT6ZWPh9Vzvc6m8PuWkODqMu56gE5eGL94WAhuYt
	 vVZ3NOuO+y6hA==
Message-ID: <022f884dd933fcbb6777d8de4e2aecc1a1a99199.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 4/9] mptcp: pm: define struct mptcp_pm_ops
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 24 Feb 2025 17:11:16 +0800
In-Reply-To: <3cb661e0-47f9-4775-b15b-f9365208ff17@kernel.org>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
	 <5f83856741646b16dde9a741fcfbfa55753eee39.1740019794.git.tanggeliang@kylinos.cn>
	 <b7333a19-921a-41e1-9a87-ff70aab3e000@kernel.org>
	 <328be50889c11a6358d360d5454f8b7a6ed200b7.camel@kernel.org>
	 <3cb661e0-47f9-4775-b15b-f9365208ff17@kernel.org>
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

On Mon, 2025-02-24 at 09:26 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/02/2025 07:54, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for the review.
> > 
> > On Fri, 2025-02-21 at 18:23 +0100, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 20/02/2025 03:57, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > In order to allow users to develop their own BPF-based path
> > > > manager,
> > > > this patch defines a struct ops "mptcp_pm_ops" for a userspace
> > > > path
> > > > manager, which contains a set of interfaces.
> > > > 
> > > > Add a set of functions to register, unregister, find and
> > > > validate a
> > > > given struct ops.
> > > > 
> > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > ---
> > > >  include/net/mptcp.h  | 29 ++++++++++++++++++++++
> > > >  net/mptcp/pm.c       | 59
> > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > >  net/mptcp/protocol.h |  5 ++++
> > > >  3 files changed, 93 insertions(+)
> > > > 
> > > > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > > > index a41d6c74760f..f51e75d3882d 100644
> > > > --- a/include/net/mptcp.h
> > > > +++ b/include/net/mptcp.h
> > > > @@ -134,6 +134,35 @@ struct mptcp_pm_param {
> > > >  	struct mptcp_addr_info		addr;
> > > >  };
> > > >  
> > > > +struct mptcp_pm_ops {
> > > > +	int (*created)(struct mptcp_sock *msk);
> > > > +	int (*established)(struct mptcp_sock *msk);
> > > > +	int (*closed)(struct mptcp_sock *msk);
> > > > +	int (*address_announced)(struct mptcp_sock *msk,
> > > > +				 struct mptcp_pm_param
> > > > *param);
> > > > +	int (*address_removed)(struct mptcp_sock *msk,
> > > > +			       struct mptcp_pm_param *param);
> > > > +	int (*subflow_established)(struct mptcp_sock *msk,
> > > > +				   struct mptcp_pm_param
> > > > *param);
> > > > +	int (*subflow_closed)(struct mptcp_sock *msk,
> > > > +			      struct mptcp_pm_param *param);
> > > > +	int (*get_local_id)(struct mptcp_sock *msk,
> > > > +			    struct mptcp_pm_param *param);
> > > > +	bool (*get_priority)(struct mptcp_sock *msk,
> > > > +			     struct mptcp_pm_param *param);
> > > > +	int (*set_priority)(struct mptcp_sock *msk,
> > > > +			    struct mptcp_pm_param *param);
> > > > +	int (*listener_created)(struct mptcp_sock *msk);
> > > > +	int (*listener_closed)(struct mptcp_sock *msk);
> > > > +
> > > > +	u8			type;
> > > 
> > > I guess the type matches net.mptcp.pm_type sysctl knob, right?
> > > 
> > > I wonder if we should not deprecate this sysctl, and use a string
> > > like
> > > with the scheduler. So instead, we could have:
> > > 
> > >   char			name[MPTCP_PM_NAME_MAX];
> > > 
> > > And on ctrl.c, we could map pm_type for the moment with a custom
> > > proc_handler (and even remove this sysctl knob in a few
> > > releases):
> > > 
> > >  - 0  → in-kernel
> > >  - 1  → userspace
> > >  - >1 → bpf
> > 
> > Do we need to restrict BPF path manager to only extend the
> > userspace
> > type path manager? That is, for all BPF path managers,
> > mptcp_pm_is_userspace() returns true. If this is the case, there is
> > no
> > need to add "type" field in struct mptcp_pm_ops.
> 
> To me, mptcp_pm_is_userspace() should no longer be needed, because
> pm->ops will be used instead. So the "type" field should no longer be

Currently, the path manager must rely on mptcp_pm_is_userspace().
mptcp_pm_is_userspace() is not needed for get_local_id() and
get_priority(), but it's useful for address_announced(),
address_removed(), subflow_created() and subflow_closed(). 

Take address_announced() as an example:

For userspace pm, address_announced() is invoked in
mptcp_pm_nl_announce_doit(), which is the handler of the command
MPTCP_PM_CMD_ANNOUNCE [1].

While for in-kernel pm, address_announced() is invoked in
mptcp_pm_nl_add_addr_doit(), which is the handler of the command
MPTCP_PM_CMD_ADD_ADDR [2].

When we implement a BPF path manager, we must tell the PM core which
path to use to call its address_announced() interface. So I added
"type" in struct mptcp_pm_ops, and each path manager needs to set it to
tell the PM core whether it is a userspace type path manager, and check
this type in mptcp_pm_is_userspace().

[1]
https://patchwork.kernel.org/project/mptcp/patch/6d39ed9364b41f84b273598f198fa1aa226a2cbc.1740047738.git.tanggeliang@kylinos.cn/
[2]
https://patchwork.kernel.org/project/mptcp/patch/5881dc057b4927f30070193bde21703f0079e233.1740047738.git.tanggeliang@kylinos.cn/

> needed. Only the name should be stored, and the net.mptcp.pm_type
> sysctl
> knob should depend only on the name. (I guess a lock will be needed
> to
> handle the case where both the "pm_type" and "path_manager" will be
> set
> at the same time.)
> 
> > Is it necessary to allow BPF to create kernel type path managers,
> > that
> > is, path managers for which mptcp_pm_is_userspace() returns false?
> > Since we registered mptcp_netlink_pm from this version, can the in-
> > kernel type path manager also be extended by BPF? If this is the
> > case,
> > we need to add "type" field in struct mptcp_pm_ops to distinguish
> > whether it is a userspace type path manager.
> 
> I guess a BPF path-manager will have its own mptcp_pm_ops structure,
> and
> it will not extend anything. Of course, it is possible to add kfunc
> to
> share some code. No?
> 
> > > WDYT? Would it not be clearer for devs and users?
> > > 
> > > Note that if for the implementation, if it is easier to keep this
> > > "type"
> > > entry for the moment for the sysctl stuff, I'm fine with that.
> > > But if
> > > we
> > > don't need it, let's not introduce it.
> > > 
> > > > +	struct module		*owner;
> > > > +	struct list_head	list;
> > > > +
> > > > +	void (*init)(struct mptcp_sock *msk);
> > > > +	void (*release)(struct mptcp_sock *msk);
> > > 
> > > To answer my question from the v3 review: the init/release is
> > > done
> > > for
> > > each MPTCP connection handled by this PM.
> > 
> > In-kernel pm is for each MPTCP connection handled by this PM while
> > userspace pm is only for this one being initialized. How should I
> > deal
> > with this? Please give me more detailed suggestions.
> 
> Sorry, I'm not sure to understand your question. If one PM doesn't
> need
> to init and/or release anything, these ops can be set to NULL, no?
> 
> Cheers,
> Matt

