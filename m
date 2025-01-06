Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834BC2BAEC
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152038; cv=none; b=bqjfHlfG5xwC4RkbZeQgF7CrI8qZQ6IQ8s2mu8Em6ZUWqmCJ9077U4FRwzkHVuvnjlHQE1SUuiDvAHu0kbBDMgbJM9LTI21wgU/sOsKt+6l6djLdKcNoQXzJgVffgM5+t26sZhQBmGsEWYa79IqKVi8DWjWplTPZ9jVQBCsTAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152038; c=relaxed/simple;
	bh=JdYJl8GtsZVT89RsN+WGQwoRGDciVaG1mC0sEwFBRmw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcN+sFToCkU8DTuyOsEs8KPo9n/HmICecMveTwYBbc6XhEmKVfe4ntukbOWAiyCsDS9XMUJT4/veGeKZwX5MvanmudSA/AejNwO+f2DFV8sAl3y1J0Rk/imfqXrXquD33pizCb5SHxvwsx7op/9jE3qUHM0p3ZTXNLRBtN+Z+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hteS1X2c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hteS1X2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1318C4CED2;
	Mon,  6 Jan 2025 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736152037;
	bh=JdYJl8GtsZVT89RsN+WGQwoRGDciVaG1mC0sEwFBRmw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=hteS1X2caFDx+pmy1HlTNtovN4x/cGAgGTg1LiyNkwFRYfD3QCVp9aVLpQ4e3S3jg
	 YKXmE6h1oJU/oDX0g3j9VUvKmDsF4id99YfSXwR5RFfZydgR1lBsGHQnTPThf9CiG5
	 OaogjT87I53yieiD/hRCRiy4bAcE0xMViiFEx/WaXz4nCx3uG760Qk19XaOC8AjJEB
	 OrzLjSgq48WEJzyTbURpt/RxcBasX+h/zLuxvJJvQpobV+DSm5468Q6RuUHn4CJR6p
	 +hFvKCi/QTVNqBo6oyWpwXMacPxTHpwyhUtg+c1H+jUzrf6Kd6oivP8kDWT/807aDv
	 WsC9U9nV+7Avw==
Message-ID: <59dbcaf581144fafcc1085726e7e06cdabd244da.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 1/7] mptcp: pm: use NL_SET_ERR_MSG_ATTR
 when possible
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 06 Jan 2025 16:27:13 +0800
In-Reply-To: <20241230-genl_req_attr_check-v6-1-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
	 <20241230-genl_req_attr_check-v6-1-3ec9103559e7@kernel.org>
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

On Mon, 2024-12-30 at 14:24 +0100, Matthieu Baerts (NGI0) wrote:
> Instead of only returning a text message with GENL_SET_ERR_MSG(),
> NL_SET_ERR_MSG_ATTR() can help the userspace developers by also
> reporting which attribute is faulty.
> 
> When the error is specific to an attribute, NL_SET_ERR_MSG_ATTR() is
> now
> used. The error messages have not been modified in this commit.
> 
> mptcp_userspace_pm_remove_id_zero_address() has been modified to set

A new patch to drop "info" parameter of this function is added in v7.

> the
> missing attribute.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_netlink.c   | 23 ++++++++++++++---------
>  net/mptcp/pm_userspace.c | 27 +++++++++++++++++----------
>  2 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index
> 98ac73938bd8196e196d5ee8c264784ba8d37645..49c34494e156ff6c3277b107c38
> 40ee29dd3afbb 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1403,18 +1403,21 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff
> *skb, struct genl_info *info)
>  		return ret;
>  
>  	if (addr.addr.port && !address_use_port(&addr)) {
> -		GENL_SET_ERR_MSG(info, "flags must have signal and
> not subflow when using port");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +				    "flags must have signal and not
> subflow when using port");
>  		return -EINVAL;
>  	}
>  
>  	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
>  	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
> -		GENL_SET_ERR_MSG(info, "flags mustn't have both
> signal and fullmesh");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +				    "flags mustn't have both signal
> and fullmesh");
>  		return -EINVAL;
>  	}
>  
>  	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
> -		GENL_SET_ERR_MSG(info, "can't create IMPLICIT
> endpoint");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +				    "can't create IMPLICIT
> endpoint");
>  		return -EINVAL;
>  	}
>  
> @@ -1608,7 +1611,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff
> *skb, struct genl_info *info)
>  	spin_lock_bh(&pernet->lock);
>  	entry = __lookup_addr_by_id(pernet, addr.addr.id);
>  	if (!entry) {
> -		GENL_SET_ERR_MSG(info, "address not found");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not
> found");
>  		spin_unlock_bh(&pernet->lock);
>  		return -EINVAL;
>  	}
> @@ -1790,7 +1793,7 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb,
> struct genl_info *info)
>  	rcu_read_lock();
>  	entry = __lookup_addr_by_id(pernet, addr.addr.id);
>  	if (!entry) {
> -		GENL_SET_ERR_MSG(info, "address not found");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not
> found");
>  		ret = -EINVAL;
>  		goto unlock_fail;
>  	}
> @@ -1875,7 +1878,8 @@ static int parse_limit(struct genl_info *info,
> int id, unsigned int *limit)
>  
>  	*limit = nla_get_u32(attr);
>  	if (*limit > MPTCP_PM_ADDR_MAX) {
> -		GENL_SET_ERR_MSG(info, "limit greater than
> maximum");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +				    "limit greater than maximum");
>  		return -EINVAL;
>  	}
>  	return 0;
> @@ -2003,7 +2007,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb,
> struct genl_info *info)
>  	if (addr.addr.family == AF_UNSPEC) {
>  		lookup_by_id = 1;
>  		if (!addr.addr.id) {
> -			GENL_SET_ERR_MSG(info, "missing required
> inputs");
> +			NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +					    "missing required
> inputs");
>  			return -EOPNOTSUPP;
>  		}
>  	}
> @@ -2016,13 +2021,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff
> *skb, struct genl_info *info)
>  			       __lookup_addr(pernet, &addr.addr);
>  	if (!entry) {
>  		spin_unlock_bh(&pernet->lock);
> -		GENL_SET_ERR_MSG(info, "address not found");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not
> found");
>  		return -EINVAL;
>  	}
>  	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
>  	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
>  		spin_unlock_bh(&pernet->lock);
> -		GENL_SET_ERR_MSG(info, "invalid addr flags");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid
> addr flags");
>  		return -EINVAL;
>  	}
>  
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index
> a3d477059b11c3a5618dbb6256434a8e55845995..72d4861e497eef5a516fc1c3ec1
> 659807ffedd53 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -190,7 +190,8 @@ static struct mptcp_sock
> *mptcp_userspace_pm_get_sock(const struct genl_info *in
>  	}
>  
>  	if (!mptcp_pm_is_userspace(msk)) {
> -		GENL_SET_ERR_MSG(info, "invalid request; userspace
> PM not selected");
> +		NL_SET_ERR_MSG_ATTR(info->extack, token,
> +				    "invalid request; userspace PM
> not selected");
>  		sock_put((struct sock *)msk);
>  		return NULL;
>  	}
> @@ -224,14 +225,16 @@ int mptcp_pm_nl_announce_doit(struct sk_buff
> *skb, struct genl_info *info)
>  	}
>  
>  	if (addr_val.addr.id == 0 || !(addr_val.flags &
> MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> -		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
> +		NL_SET_ERR_MSG_ATTR(info->extack, addr,
> +				    "invalid addr id or flags");
>  		err = -EINVAL;
>  		goto announce_err;
>  	}
>  
>  	err = mptcp_userspace_pm_append_new_local_addr(msk,
> &addr_val, false);
>  	if (err < 0) {
> -		GENL_SET_ERR_MSG(info, "did not match address and
> id");
> +		NL_SET_ERR_MSG_ATTR(info->extack, addr,
> +				    "did not match address and id");
>  		goto announce_err;
>  	}
>  
> @@ -254,7 +257,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff
> *skb, struct genl_info *info)
>  }
>  
>  static int mptcp_userspace_pm_remove_id_zero_address(struct
> mptcp_sock *msk,
> -						     struct
> genl_info *info)
> +						     struct
> genl_info *info,
> +						     struct nlattr
> *attr)
>  {
>  	struct mptcp_rm_list list = { .nr = 0 };
>  	struct mptcp_subflow_context *subflow;
> @@ -270,7 +274,8 @@ static int
> mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
>  		}
>  	}
>  	if (!has_id_0) {
> -		GENL_SET_ERR_MSG(info, "address with id 0 not
> found");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +				    "address with id 0 not found");
>  		goto remove_err;
>  	}
>  
> @@ -330,7 +335,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb,
> struct genl_info *info)
>  	sk = (struct sock *)msk;
>  
>  	if (id_val == 0) {
> -		err = mptcp_userspace_pm_remove_id_zero_address(msk,
> info);
> +		err = mptcp_userspace_pm_remove_id_zero_address(msk,
> info, id);
>  		goto out;
>  	}
>  
> @@ -339,7 +344,8 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb,
> struct genl_info *info)
>  	spin_lock_bh(&msk->pm.lock);
>  	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
>  	if (!match) {
> -		GENL_SET_ERR_MSG(info, "address with specified id
> not found");
> +		NL_SET_ERR_MSG_ATTR(info->extack, id,
> +				    "address with specified id not
> found");
>  		spin_unlock_bh(&msk->pm.lock);
>  		release_sock(sk);
>  		goto out;
> @@ -389,7 +395,7 @@ int mptcp_pm_nl_subflow_create_doit(struct
> sk_buff *skb, struct genl_info *info)
>  	}
>  
>  	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> -		GENL_SET_ERR_MSG(info, "invalid addr flags");
> +		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "invalid
> addr flags");
>  		err = -EINVAL;
>  		goto create_err;
>  	}
> @@ -409,7 +415,8 @@ int mptcp_pm_nl_subflow_create_doit(struct
> sk_buff *skb, struct genl_info *info)
>  
>  	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry,
> false);
>  	if (err < 0) {
> -		GENL_SET_ERR_MSG(info, "did not match address and
> id");
> +		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
> +				    "did not match address and id");
>  		goto create_err;
>  	}
>  
> @@ -702,7 +709,7 @@ int mptcp_userspace_pm_get_addr(struct sk_buff
> *skb,
>  	spin_lock_bh(&msk->pm.lock);
>  	entry = mptcp_userspace_pm_lookup_addr_by_id(msk,
> addr.addr.id);
>  	if (!entry) {
> -		GENL_SET_ERR_MSG(info, "address not found");
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not
> found");
>  		ret = -EINVAL;
>  		goto unlock_fail;
>  	}
> 

