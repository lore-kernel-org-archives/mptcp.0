Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CA7F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644621057; x=1676157057;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fknXKtVA3XaiVO66ezd7bXAGBuVVS3wpDDiJa2Ww3Rg=;
  b=l//errUk3hJhQnYQAwbVAwYuZ0cktJiksMv7CBIWEsGLu/ER8QOQjUM1
   xbVQy97Cfp6LJRa8a3o4Y7YsUJ+qKScrAz7+e5DziuRGt2I1Pg1G6by1W
   uUlb68LfacgsbBaHa7P6WKmldOYtrmjTA/0B5GhsgpfrHsfNh41hwGhYl
   Eo9t0EOM0RZsXKdp/o6YdHx8rLV74yzEx1EuaFMUStLhibTAdZSVrDZth
   uNg1D6HPy/mopBJ+RNg2JhTjc4RsNn27vrJKt7P5g4GQBV5XUFtX2pzLE
   lyMwJ648uRwJt0F6BxXAHDbQvUmOCFgGYRf0WW1M9vcG+IJn1D/Uc+Aaz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="336247344"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="336247344"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 15:10:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542277464"
Received: from kpdespai-mobl.amr.corp.intel.com ([10.212.245.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 15:10:56 -0800
Date: Fri, 11 Feb 2022 15:10:56 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 2/3] mptcp: more careful RM_ADDR
 generation
In-Reply-To: <baade0ed606c745a8acd5bcb075269550cd80544.1644518737.git.pabeni@redhat.com>
Message-ID: <b8278b6c-95b7-3c24-73e4-59a093c47f8b@linux.intel.com>
References: <cover.1644518737.git.pabeni@redhat.com> <baade0ed606c745a8acd5bcb075269550cd80544.1644518737.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Feb 2022, Paolo Abeni wrote:

> In some edge scenarios, an MPTCP subflows can use a local address
> mapped by a "dummy" endpoint created by the in kernel path manager.
>
> When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
> suboption. That is somewhat unexpected, as an MPTCP listener will keep
> accepting incoming subflows targeting such address and the unexpected
> options can confuse some self-tests.
>
> Be more conservative about RM_ADDR generation: do it only if the
> relevant endpoint has either the SIGNAL or SUBFLOW flag - it's not a
> dummy one.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> include/uapi/linux/mptcp.h |  1 +
> net/mptcp/pm_netlink.c     | 25 +++++++++++++++++--------
> 2 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index f106a3941cdf..34ca8c04f64e 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -81,6 +81,7 @@ enum {
> #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
> #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
> #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
> +#define MPTCP_PM_ADDR_FLAG_DUMMY			(1 << 4)

Since this is a public API, "DUMMY" might be a confusing / ambiguous name. 
MPTCP_PM_ADDR_FLAG_IMPLICIT_ENDPOINT or MPTCP_PM_ADDR_FLAG_UNADVERTISED 
maybe? (open to other ideas of course)

It looks like these dummy/implicit records stay around until a flush 
happens. What if there's a request to advertise an address that has had a 
dummy created already? mptcp_pm_nl_append_new_local_addr() would consider 
that a duplicate and reject it, but replacing the dummy record with a real 
one would be better.

-Mat

>
> enum {
> 	MPTCP_PM_CMD_UNSPEC,
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 56f5603c10f2..928ebe4949e9 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1036,7 +1036,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
> 	entry->addr.id = 0;
> 	entry->addr.port = 0;
> 	entry->ifindex = 0;
> -	entry->flags = 0;
> +	entry->flags = MPTCP_PM_ADDR_FLAG_DUMMY;
> 	entry->lsk = NULL;
> 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> 	if (ret < 0)
> @@ -1238,6 +1238,11 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
> 		return -EINVAL;
> 	}
>
> +	if (addr.flags & MPTCP_PM_ADDR_FLAG_DUMMY) {
> +		GENL_SET_ERR_MSG(info, "can't create DUMMY endpoint");
> +		return -EINVAL;
> +	}
> +
> 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> 	if (!entry) {
> 		GENL_SET_ERR_MSG(info, "can't allocate addr");
> @@ -1322,11 +1327,12 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
> }
>
> static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
> -						   struct mptcp_addr_info *addr)
> +						   const struct mptcp_pm_addr_entry *entry)
> {
> -	struct mptcp_sock *msk;
> -	long s_slot = 0, s_num = 0;
> +	const struct mptcp_addr_info *addr = &entry->addr;
> 	struct mptcp_rm_list list = { .nr = 0 };
> +	long s_slot = 0, s_num = 0;
> +	struct mptcp_sock *msk;
>
> 	pr_debug("remove_id=%d", addr->id);
>
> @@ -1346,7 +1352,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
>
> 		lock_sock(sk);
> 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
> -		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
> +		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
> +						     !(entry->flags & MPTCP_PM_ADDR_FLAG_DUMMY));
> 		if (remove_subflow)
> 			mptcp_pm_remove_subflow(msk, &list);
> 		release_sock(sk);
> @@ -1443,7 +1450,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
> 	__clear_bit(entry->addr.id, pernet->id_bitmap);
> 	spin_unlock_bh(&pernet->lock);
>
> -	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
> +	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
> 	synchronize_rcu();
> 	__mptcp_pm_release_addr_entry(entry);
>
> @@ -1458,9 +1465,11 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
>
> 	list_for_each_entry(entry, rm_list, list) {
> 		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
> -		    alist.nr < MPTCP_RM_IDS_MAX &&
> 		    slist.nr < MPTCP_RM_IDS_MAX) {
> -			alist.ids[alist.nr++] = entry->addr.id;
> +			/* skip RM_ADDR for dummy endpoints */
> +			if (!(entry->flags & MPTCP_PM_ADDR_FLAG_DUMMY) &&
> +			    alist.nr < MPTCP_RM_IDS_MAX)
> +				alist.ids[alist.nr++] = entry->addr.id;
> 			slist.ids[slist.nr++] = entry->addr.id;
> 		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
> 			 alist.nr < MPTCP_RM_IDS_MAX) {
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
