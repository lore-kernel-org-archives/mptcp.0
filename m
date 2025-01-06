Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BB1D5AB6
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736153211; cv=none; b=V8iS8K17pPadQ0j2idG1KqI6PVI4XuSDYKNPYD5RVQGZvBu2hinLEq5wiXdPdDj2KD0ZDnpqMCFbgi+aOpNhyqJgLOt+zGfqsbqfGHpPecXEJMfHW/6Z8Ne0UXqWhxr25jd4L9x3CX4zNnRcVYItGK39SkLx4M4la2QnHF5f0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736153211; c=relaxed/simple;
	bh=qObL+Qmo35ghF2Kxo7zlgIbaW0vvDVH1fnPyx0+746s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePp0jkD0OWZGXer96rFCKPGHfyuOqUC0uD+3kGfs+8E11Wibkjpv/WZoJpY0oNeAvlKj+Ag0AhChqD3eAyz4ab5RuxbUExjMpzB94NiyDXJ8DPVmsbynM5sro+SgouT4t3puH0FU0PWnRxhRkokVKcNcJe4f/0Oe56EcU1UQ7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNGOT7Hb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNGOT7Hb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD680C4CED2;
	Mon,  6 Jan 2025 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736153210;
	bh=qObL+Qmo35ghF2Kxo7zlgIbaW0vvDVH1fnPyx0+746s=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=qNGOT7Hb8SmrISx4SKLO3tuxunv4vp9K60imqJDt1PC1GRBucNg+n775IR/KHM9eP
	 KKWBaM0+dpHp7UpgWEACC3s1HCuw5XPSeQeFQpM7c2GgN/jV5dxIbqT1UG1DivxLc/
	 M9hLzb3oEXqrplN+Gdc5+rX0USgFuWbwUODd/zGNEpxNAJr4GwbFz25uxrRCiUw4t/
	 gdiMLoz9tLIYicG5zKuiJY91hD++uqNtzt1OjqonQVrehI0fe6PEQudB1OtSyeZWJr
	 VHqjjvvmTF8Y9kr2nCo++oys4Y/A53AbBO8qtmGaRebKMY+fgUqtjeWVMSlpLLkA04
	 8Gx8uiBvkhGQg==
Message-ID: <a7048ad95016f7c77dc6ebe053dbfbb994b9d1cc.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 4/7] mptcp: pm: userspace: flags: clearer
 msg if no remote addr
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 06 Jan 2025 16:46:46 +0800
In-Reply-To: <20241230-genl_req_attr_check-v6-4-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
	 <20241230-genl_req_attr_check-v6-4-3ec9103559e7@kernel.org>
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
> Since its introduction in commit 892f396c8e68 ("mptcp: netlink: issue
> MP_PRIO signals from userspace PMs"), it was mandatory to specify the
> remote address, because of the 'if (rem->addr.family == AF_UNSPEC)'
> check done later one.
> 
> In theory, this attribute can be optional, but it sounds better to be
> precise to avoid sending the MP_PRIO on the wrong subflow, e.g. if
> there
> are multiple subflows attached to the same local ID. This can be
> relaxed
> later on if there is a need to act on multiple subflows with one
> command.
> 
> For the moment, the check to see if attr_rem is NULL can be removed,
> because mptcp_pm_parse_entry() will do this check as well, no need to
> do
> that differently here.
> 
> While at it, move the parsing after the check linked to the local
> attribute.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_userspace.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index
> a8f73b082460ba00f7fa998cf7646368f8201e2e..2f82ac49db35ec34dcc0b9208f4
> ac12edc6ab254 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -601,12 +601,6 @@ int mptcp_userspace_pm_set_flags(struct sk_buff
> *skb, struct genl_info *info)
>  	if (ret < 0)
>  		goto set_flags_err;
>  
> -	if (attr_rem) {
> -		ret = mptcp_pm_parse_entry(attr_rem, info, false,
> &rem);
> -		if (ret < 0)
> -			goto set_flags_err;
> -	}

I did not remove this 'if (attr_rem)' check in v7. I moved this code to
a common place for userspace PM and in-kernel PM. For in-kernel PM,
this check is required.

> -
>  	if (loc.addr.family == AF_UNSPEC) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, attr,
>  				    "invalid local address family");
> @@ -614,6 +608,10 @@ int mptcp_userspace_pm_set_flags(struct sk_buff
> *skb, struct genl_info *info)
>  		goto set_flags_err;
>  	}
>  
> +	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
> +	if (ret < 0)
> +		goto set_flags_err;
> +
>  	if (rem.addr.family == AF_UNSPEC) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
>  				    "invalid remote address
> family");
> 

