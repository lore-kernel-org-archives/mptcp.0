Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86179374CF
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667670; cv=none; b=S8aeivMV0FLh53zs9k2w/SIgBFTCdvGSFHKg50UkTrJrJpdCuDUJhgr+yotPLnQWFA66Ij78LWacmmUWZqUNvI4MxotNkjVL3IAzUpaKx4aFQRuwhutDd3+fCFglBYDXjktE1oOjBu3d2GI9uMOlQrxAj6j9nhFUD4zahy0LzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667670; c=relaxed/simple;
	bh=nMqGSJWf1RMhDnliCHRdvdh4t17zdotofhBixCQnwx4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G3Gql9vmWJcsafrFz9qhDpKae4KL+sBLwe9hAdYqtQ2ZOEIngmZMOhigjfF8iSl1jPqwqJlkjUctcMaVWaqmlZ2pjd30vC7d3ndKz7SY31i3TvtLshgp/pfTykMB6qummH1UG8VEzfIJrA/RTljqdrR5fquz06NC07V/4cPqF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKlNIXBC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKlNIXBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E611AC433F1;
	Wed, 31 Jan 2024 02:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706667669;
	bh=nMqGSJWf1RMhDnliCHRdvdh4t17zdotofhBixCQnwx4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RKlNIXBC3BRdTTIUh1F6bnlw2VyP8E8zB1vY/v3uW3v9L/grS0UNUVBZm769mkJCX
	 38DPalJeJXmHBA3cz5dmH7fB66o6doKD4vfAeGgI7CxvXWvsDTA35c0JmxXzxePz2I
	 mIJEptm2uO7euiAk411q+qk1V5ZbVsjS7OG4nbkoNA6+/ooXHFfqt2DZjsy8/WgBgh
	 5MrEJRp76yt57nmiu0GGaUqZmns8Zac8Terv0GRw+1Rgaa4gMSIciPwBOh3Ko3I3oB
	 OZf20vOxRJ5GXTTVZuxjlusPLtR3ctndGLWoHqmxPW+o7qMBT5WTHa3OuXAkjX8PMv
	 6C8eIfyg5uwrQ==
Date: Tue, 30 Jan 2024 18:21:08 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 04/23] mptcp: map v4 address to v6 when
 destroying subflow
In-Reply-To: <5b291bca5a8a69217ae9e1090c94fb8e10b0b4ce.1705558030.git.tanggeliang@kylinos.cn>
Message-ID: <360afd4e-72f5-f76a-5b12-f6f78485557c@kernel.org>
References: <cover.1705558030.git.tanggeliang@kylinos.cn> <5b291bca5a8a69217ae9e1090c94fb8e10b0b4ce.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 18 Jan 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Address family of server side mismatches with that of client side, like
> in "userspace pm add & remove address" test:
>
>    userspace_pm_add_addr $ns1 10.0.2.1 10
>    userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
>
> That's because on the server side, the family is set to AF_INET6 and the
> v4 address is mapped in a v6 one.
>
> This patch fixes this issue. In mptcp_pm_nl_subflow_destroy_doit(), before
> checking local address family with remote address family, map an IPv4
> address to an IPv6 address if the pair is a v4-mapped address.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")

Hi Geliang -

Are patches 4 & 5 for net or net-next?

Thanks,
Mat


> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/pm_userspace.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 8ca6e28a121e..7bb3574cc65a 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -497,6 +497,16 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
> 		goto destroy_err;
> 	}
>
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
> +		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
> +		addr_l.family = AF_INET6;
> +	}
> +	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
> +		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
> +		addr_r.family = AF_INET6;
> +	}
> +#endif
> 	if (addr_l.family != addr_r.family) {
> 		GENL_SET_ERR_MSG(info, "address families do not match");
> 		err = -EINVAL;
> -- 
> 2.40.1
>
>
>
