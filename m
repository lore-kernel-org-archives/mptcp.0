Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0E1AE01C
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383568; cv=none; b=P1zULANGfbG13+hOhR3x+SFyfnICbV8xYiYGzyYSwR+1RhkCqCjONL5wQ/CDPQItuUcpEBYg+z8ki6NcxzC/e14f57Z4NTjfguUE8dY+0WaTEZQQySga62OUPZojMubao+gUeFxK3rWVUWn+FRDv1qKyFsBnl+VwwR6ouS1yWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383568; c=relaxed/simple;
	bh=nVFi+94QT/YT813ThbXJPPxpiWkC87E0xjfy7OXS0OI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VETpHeY8fCYofeTJHa2InS6sphBNCsPq7ivsFiJUG4O3Lt19f+oN0D2fUTEJ5wDHYNlKo3mD3JqB3yoy+9MSMjq9jV5QVFZIEjQQYoj1/sgvNHvaIzAoXE7FSlwgSSbyYFW2jdLvfjWUE74gY1QXo/UlGthrv/w8YduWS/TndIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJnB1yd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJnB1yd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F548C4CED1;
	Thu,  5 Dec 2024 07:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733383568;
	bh=nVFi+94QT/YT813ThbXJPPxpiWkC87E0xjfy7OXS0OI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VJnB1yd8OiG9q2FW82dOLSjEc3gOKWhbntlLqu8s1VjMu+LgJ3H/VSHMg1e2nXDXH
	 Jm5876w3K46krCWOjA0iwqlFtJnygMtsNRDhDwO30jTtT4JlnjJu8V+ZaI32AhOKad
	 aaQiq6HKA2rjA+D9DdySiipRMC5oVK8UMTbMVKn2CYU3+/xjew/GHNI8P9y2kHyXa/
	 1moVuphfYF9OX/8koW/Zxsq7QQmVxVv37OjgK8IjJkB1zgnP5ICd3aNRyCIxqufgJq
	 OXvVXZuXAiMkIBLQm5/S1REH5u3/+VjmvFVJlJ1e7Bh39MM1XqzH6/b1x4jp/NMul8
	 pEDW/8O8hRsyQ==
Message-ID: <e041dcecfe0c9080b91b49546ec29a49061e39c6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 4/9] mptcp: move mptcp_pm_remove_addrs
 into pm_userspace
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 05 Dec 2024 15:26:04 +0800
In-Reply-To: <b1024055-405e-426d-a5d1-2a6b16054191@kernel.org>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
	 <92ab4cbf71a2be676481b20c662b2f602aa346e2.1730961809.git.tanggeliang@kylinos.cn>
	 <b1024055-405e-426d-a5d1-2a6b16054191@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for the review.

On Wed, 2024-12-04 at 18:48 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/11/2024 07:45, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Since mptcp_pm_remove_addrs is only called from the userspace PM,
> > this
> > patch moves it into pm_userspace.c.
> > 
> > For this, lookup_subflow_by_saddr() and remove_anno_list_by_saddr()
> > helpers need to be exported in protocol.h. Also add "mptcp_" prefix
> > for
> > these helpers.
> > 
> > This patch doesn't change the behaviour of the code, just
> > refactoring.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm_netlink.c   | 45 +++++++-----------------------------
> > ----
> >  net/mptcp/pm_userspace.c | 28 +++++++++++++++++++++++++
> >  net/mptcp/protocol.h     |  4 ++++
> >  3 files changed, 40 insertions(+), 37 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 618289aac0ab..8aba7670345d 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> 
> (...)
> 
> > @@ -1639,35 +1639,6 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff
> > *skb, struct genl_info *info)
> >  	return ret;
> >  }
> >  
> > -/* Called from the userspace PM only */
> > -void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct
> > list_head *rm_list)
> > -{
> > -	struct mptcp_rm_list alist = { .nr = 0 };
> > -	struct mptcp_pm_addr_entry *entry;
> > -	int anno_nr = 0;
> > -
> > -	list_for_each_entry(entry, rm_list, list) {
> > -		if (alist.nr >= MPTCP_RM_IDS_MAX)
> > -			break;
> > -
> > -		/* only delete if either announced or matching a
> > subflow */
> > -		if (remove_anno_list_by_saddr(msk, &entry->addr))
> > -			anno_nr++;
> > -		else if (!lookup_subflow_by_saddr(&msk->conn_list,
> > -						  &entry->addr))
> > -			continue;
> > -
> > -		alist.ids[alist.nr++] = entry->addr.id;
> > -	}
> > -
> > -	if (alist.nr) {
> > -		spin_lock_bh(&msk->pm.lock);
> > -		msk->pm.add_addr_signaled -= anno_nr;
> > -		mptcp_pm_remove_addr(msk, &alist);
> > -		spin_unlock_bh(&msk->pm.lock);
> > -	}
> > -}
> > -
> >  /* Called from the in-kernel PM only */
> 
> I guess we can remove this command as well.

Dropped this in v4.

> 
> (Something I can change when applying the patch if there is nothing
> else.)
> 
> >  static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock
> > *msk,
> >  					      struct list_head
> > *rm_list)
> > @@ -1677,11 +1648,11 @@ static void
> > mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
> >  
> >  	list_for_each_entry(entry, rm_list, list) {
> >  		if (slist.nr < MPTCP_RM_IDS_MAX &&
> > -		    lookup_subflow_by_saddr(&msk->conn_list,
> > &entry->addr))
> > +		    mptcp_lookup_subflow_by_saddr(&msk->conn_list,
> > &entry->addr))
> >  			slist.ids[slist.nr++] =
> > mptcp_endp_get_local_id(msk, &entry->addr);
> >  
> >  		if (alist.nr < MPTCP_RM_IDS_MAX &&
> > -		    remove_anno_list_by_saddr(msk, &entry->addr))
> > +		    mptcp_remove_anno_list_by_saddr(msk, &entry-
> > >addr))
> >  			alist.ids[alist.nr++] =
> > mptcp_endp_get_local_id(msk, &entry->addr);
> >  	}
> >  
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index a6de837d8958..737a07f5defe 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -286,6 +286,34 @@ static int
> > mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
> >  	return err;
> >  }
> >  
> > +void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct
> > list_head *rm_list)
> 
> Can it not be 'static' now that it is only used in the userspace pm?

It will be invoked in BPF path manager, 'static' doesn't work.

> 
> (...)
> 
> Cheers,
> Matt

