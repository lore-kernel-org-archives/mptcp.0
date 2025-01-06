Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8E1BC58
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152903; cv=none; b=rgWBCvX28kjFA++HoEjeL4a/XBYCh/LjOfOLUKNMScTK0kglV466VhD7n4qqTny5bQ32K0hBrG+qGeIYfB1ydFB37K5pKoIHbjIC5TRT4U8cX0RZFtsfPXGLdg0w1mE62SJYJ00nEO89ox9yH0KqE3gWYK012U+GfAbi68oJfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152903; c=relaxed/simple;
	bh=uWs76edBpk5k4/KgoXa5hlUTU9+7l4uGqRU26LuiIhY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JL6rXy2wOR4v4MKXyojgeKNnvlLUhXVD4q0ie1xlqxSUpoy0268+2I/ihouFNMFRk5UHp1RK0eowOqpw1JC8Xdwlx9km/1JZt1vszwpMInNt/NgyOnmHbEZ+urIX4wumGPdjj3OHB5F2G4QjASDBCK0ym+TOSncqYqxLQdM8TAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvnxOMgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvnxOMgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85BCC4CED2;
	Mon,  6 Jan 2025 08:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736152903;
	bh=uWs76edBpk5k4/KgoXa5hlUTU9+7l4uGqRU26LuiIhY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=hvnxOMgvVFt+3oIcerCGhfGEsaNBaZwylPK9UVQVJk9HHGW/7+1i6bCn6JWoTZ1HH
	 Xtn1/OWxezbNLvF/yVnV1SMTQDIYmEvbDXtxK02ctP/QrWejZFfGXLn/VeJwroEqCm
	 QeSWlu35SltwkQdL3tCuwPSuaHORa+1TULRm+EZWNPeJFBWruTeHGjkLYwLm5p01k8
	 I4qYpvJE2IS4Yx32gnVnZh3G2wmR4eKZg2tATgukZAvgpooBzt3iyaQiPfK42Z3GTm
	 SY6XjKoD/ciS6aVQCcCMQ3NJHRibG3PCqekRhJQgFZSpXf0LA/rJ23Ya/58kgzdVh0
	 oJGQn9ueXhBTg==
Message-ID: <e22df271143ccf0dd9d7f20398c37dcd68db01af.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 3/7] mptcp: pm: improve error messages
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 06 Jan 2025 16:41:39 +0800
In-Reply-To: <20241230-genl_req_attr_check-v6-3-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
	 <20241230-genl_req_attr_check-v6-3-3ec9103559e7@kernel.org>
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
> Some error messages were:
> 
>  - too generic: "missing input", "invalid request"
> 
>  - not precise enough: "limit greater than maximum" but what's the
> max?
> 
>  - missing: subflow not found, or connect error.
> 
> This can be easily improved by being more precise, or adding new
> error
> messages.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_netlink.c   | 7 ++++---
>  net/mptcp/pm_userspace.c | 9 ++++++++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index
> 49c34494e156ff6c3277b107c3840ee29dd3afbb..3bb213e2a967e87d4244dc0f1ba
> 58d3ba21fb371 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1878,8 +1878,9 @@ static int parse_limit(struct genl_info *info,
> int id, unsigned int *limit)
>  
>  	*limit = nla_get_u32(attr);
>  	if (*limit > MPTCP_PM_ADDR_MAX) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> -				    "limit greater than maximum");
> +		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
> +					"limit greater than maximum
> (%u)",
> +					MPTCP_PM_ADDR_MAX);
>  		return -EINVAL;
>  	}
>  	return 0;
> @@ -2008,7 +2009,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb,
> struct genl_info *info)
>  		lookup_by_id = 1;
>  		if (!addr.addr.id) {
>  			NL_SET_ERR_MSG_ATTR(info->extack, attr,
> -					    "missing required
> inputs");
> +					    "missing address ID");
>  			return -EOPNOTSUPP;
>  		}
>  	}
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index
> 9c0bec588c498e0aa78acf4018db509abe90cad2..a8f73b082460ba00f7fa998cf76
> 46368f8201e2e 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -191,7 +191,7 @@ static struct mptcp_sock
> *mptcp_userspace_pm_get_sock(const struct genl_info *in
>  
>  	if (!mptcp_pm_is_userspace(msk)) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, token,
> -				    "invalid request; userspace PM
> not selected");
> +				    "userspace PM not selected");
>  		sock_put((struct sock *)msk);
>  		return NULL;
>  	}
> @@ -433,6 +433,9 @@ int mptcp_pm_nl_subflow_create_doit(struct
> sk_buff *skb, struct genl_info *info)
>  	err = __mptcp_subflow_connect(sk, &local, &addr_r);
>  	release_sock(sk);
>  
> +	if (err)
> +		GENL_SET_ERR_MSG_FMT(info, "connect error: %d",
> err);
> +
>  	spin_lock_bh(&msk->pm.lock);
>  	if (err)
>  		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> @@ -557,6 +560,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct
> sk_buff *skb, struct genl_info *info
>  	lock_sock(sk);
>  	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
>  	if (!ssk) {
> +		GENL_SET_ERR_MSG(info, "subflow not found");
>  		err = -ESRCH;
>  		goto release_sock;
>  	}
> @@ -634,6 +638,9 @@ int mptcp_userspace_pm_set_flags(struct sk_buff
> *skb, struct genl_info *info)
>  	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr,
> &rem.addr, bkup);
>  	release_sock(sk);
>  
> +	if (ret)
> +		GENL_SET_ERR_MSG(info, "subflow not found");

I guess you don't want to use "subflow not found" here. I changed it as
"mp_prio send ack failed" in v7.

> +
>  set_flags_err:
>  	sock_put(sk);
>  	return ret;
> 

