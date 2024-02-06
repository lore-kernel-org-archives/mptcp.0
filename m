Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DF6FA9
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182930; cv=none; b=ZWN/eYhf23Lt1r87jhqmwSKzlKl5/BZwAqY1lV/9lQerpLZjmQjwE48vf2OeAr0568TCQLj90HgMKgNfZOivVv8cIL+b++rZJaepK9t+R+e0A5MR7lKYnySwCSICeMXmACfwOvt5gdIs+qFCsCQOu9LS8qNsngBjSIps0uCRstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182930; c=relaxed/simple;
	bh=uSr2OCitnI1RSFtueXbDE0Mhu9V+E/Jq3vI4COTs7l4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VM9TvGMeNiV8jO6wZ4jjlDbBAfiwROsMseyTmlQY36FXlBq10NxyjKPkb9WBy8tHnvXkARqCGQyIcbijoS/nviVayLXQJFFQz7ap8+mZu1f43C5UuH8hyqAgS1QKN/agaKXI3GNGNMnlvMJGDxg7onNrHpojBtuo+syEEQQbnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a42fK5WF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a42fK5WF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A7CC433C7;
	Tue,  6 Feb 2024 01:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707182929;
	bh=uSr2OCitnI1RSFtueXbDE0Mhu9V+E/Jq3vI4COTs7l4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=a42fK5WFvBQcIxXpmFlwDx5rIhyQAA7vdi0XAiudW19TeAVFET8hghJOTlUpPTdFf
	 RqyLHpWueMjWHL2w6lD9n6xWDKma3zUhLfU/PU6/5g+NCs/MwOJ0YX1N7MgHdHerIO
	 I2/TtGeYtw4kPZ9F1kl6m5VEoEqHra1Cirf/ZijtCoVq/u5mmpkI6st6WG6lbzBz8Y
	 Lgr3BV1KVcMjRweHhOI3Eq3uW3F/k6XDuWt3JEW0mHH53/k0/yf81MG75zmOrwsgD1
	 Au+3Fhzii596KYvmyM8wpEFG70gf4urI0tv2d01YELtxe8cTe0qa7Ine8Lw0/Tr8Hf
	 dSNqivrp7dfUg==
Date: Mon, 5 Feb 2024 17:28:49 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net 2/4] mptcp: add needs_id for netlink appending
 addr
In-Reply-To: <1d1970ac75aa9b924f1da17c3c89dcba96e5bb46.1706759413.git.tanggeliang@kylinos.cn>
Message-ID: <8d1fa3bc-b591-0820-82b0-61a3efa340ea@kernel.org>
References: <cover.1706759413.git.tanggeliang@kylinos.cn> <1d1970ac75aa9b924f1da17c3c89dcba96e5bb46.1706759413.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 1 Feb 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Just the same as userspace PM, a new parameter needs_id is added for
> in-kernel PM mptcp_pm_nl_append_new_local_addr() too.
>
> Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
> ID is set from PM or not. It will be used in the next two commits.
>
> In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
> mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
> needs_it.
>
> Fixes: fd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
> 1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d9ad45959219..9367ab506908 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -901,7 +901,8 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
> }
>
> static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> -					     struct mptcp_pm_addr_entry *entry)
> +					     struct mptcp_pm_addr_entry *entry,
> +					     bool needs_id)
> {
> 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
> 	unsigned int addr_max;
> @@ -949,7 +950,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> 		}
> 	}
>
> -	if (!entry->addr.id) {
> +	if (!entry->addr.id && needs_id) {
> find_next:
> 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
> 						    MPTCP_PM_MAX_ADDR_ID + 1,
> @@ -960,7 +961,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> 		}
> 	}
>
> -	if (!entry->addr.id)
> +	if (!entry->addr.id && needs_id)
> 		goto out;
>
> 	__set_bit(entry->addr.id, pernet->id_bitmap);
> @@ -1092,7 +1093,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
> 	entry->ifindex = 0;
> 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> 	entry->lsk = NULL;
> -	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> +	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
> 	if (ret < 0)
> 		kfree(entry);
>
> @@ -1285,6 +1286,18 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
> 	return 0;
> }
>
> +static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
> +				      struct genl_info *info)
> +{
> +	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
> +
> +	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> +					 mptcp_pm_address_nl_policy, info->extack) &&
> +	    tb[MPTCP_PM_ADDR_ATTR_ID])
> +		return true;
> +	return false;
> +}
> +
> int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
> {
> 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
> @@ -1326,7 +1339,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
> 			goto out_free;
> 		}
> 	}
> -	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> +	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
> +						!mptcp_pm_has_addr_attr_id(attr, info));
> 	if (ret < 0) {
> 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
> 		goto out_free;
> -- 
> 2.40.1
>
>
>
