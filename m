Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793472140;
	b=4F3Kc4sBgCBTo+4aHI2rm2Ul1xOk/rxnM6AspCg1Ch5DgM7S1kTPqA87BDzrhE8vQ7us
	 lMUn7E+y/KwGJFjIMi7tIHRwYxFIAp0Qo6MzQM9hpC4Fl6YzHEMzkEF2lMtA4iB9t6umL
	 As78H9YX7EBgkLE8movAjE+PU2PxaHJwPhhQvzWBJUG0n8tSb1RZkks7DyIDD1qoh4nlq
	 WBE/jLAXPpDbqR68lGgeaJ320SRddCWjIHskXTKgyMbHxHM8hOYuIKAy4ESLdwFEhR4NX
	 k87R/6EYrIxTQuN6QjmMfIuAH36bz3cQUXbnZonnY2TxpicGwP09/jJLqdzpFzLroRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793472140;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=p4x8ycwDocwpEOV1mPZRhGWd/tYikdzHXhGV8TI/mQE=;
	b=zQve68+xWjTZKcAE+f4DcErBvS6CbbnlW14RfiEB9fnZQqgktFVcDktBcb8OTz2ylwIk
	 10gCRC+O0S/M65Ju6UDNxQNQ/KG87NNBf2pmik7vPPD8o0r3P9Njnc7hPLNkSnf3BK3Fl
	 tGMZvBzg8uhw866SydTmgayDTG8Kj/aVneRnPhq99/i6Z5hX+VrLR1f6mDRuuQiPDZlhz
	 A/SKF8fgCz3/9itdAYH/+rjnYqeeoaSB2PZJVyvcMA2EyZPcGCM9+PqyB7i9B6vVOfuUj
	 aF07wgpxw5Ewtw+z5LbO4BPPHGx5q/sefg4P4uUaVqRd6YpfQvgnXxleToiTV2bfyJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQRyLJJI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4AD606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQRyLJJI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B291F000C1;
	Sat, 31 Oct 2026 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793472140;
	bh=p4x8ycwDocwpEOV1mPZRhGWd/tYikdzHXhGV8TI/mQE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HQRyLJJI3Cw/oSJdU9GvpHxvIpYNSmzv5K3KY851r33MfaxXx8jSUA/mmyAwYKmUe
	 9yK3RM+JJgbbJdghDOHdzNLyYdS59winiWbWQcFkjgEC+YtleNBoDTqfHla5HHZEOz
	 M+RulCHum+OIEYrFu+B3uYwg47703TUyhqu/NMkzLMKzpyQTwbsN+KspDqMUYZm/PW
	 sL8xT4qA+fSdq4bRMMYQW3ZEN6N5mtgzNQn2subncEKmhXA/pvFF/18Dv7IdoUu5Zd
	 3NKYLMnOrG5HUWXhtKD+BLsYKMfuz+ZGkGv0TpvGoqE8zuEILzSOuQykNYVIp6JCA0
	 1OUIHZG4Ll8hw==
Subject: Re: [PATCH mptcp-next v13 2/6] netlink: specs: mptcp: add the
 subflow-retries attribute
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 18:42:19 +0000
Message-ID: <179347213935.3128.9508323765921146822@kernel.org>
In-Reply-To: <20261030050727.3534304-3-anilkaushikwireless@gmail.com>
References: <20261030050727.3534304-3-anilkaushikwireless@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The concern is that at commit "netlink: specs: mptcp: add the
  subflow-retries attribute", MPTCP_PM_ATTR_SUBFLOW_RETRIES is already…

--

netlink: specs: mptcp: add the subflow-retries attribute

This commit adds a subflow-retries u32 attribute, capped at 127, to the
MPTCP PM netlink spec. It also adds it to the uAPI enum and to the
generated set-limits and get-limits policies, so that the in-kernel PM
can later use it for SYN retries of subflows re-created after a timeout.

> diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
> index c180930a8e0e4..e2d4af1bc1d5d 100644
> --- a/net/mptcp/mptcp_pm_gen.c
> +++ b/net/mptcp/mptcp_pm_gen.c
> @@ -44,15 +44,17 @@ const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR +
>  };
>
>  /* MPTCP_PM_CMD_SET_LIMITS - do */
> -const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
> +const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
>  	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
> +	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
>  };

[Severity: Low]
This policy, together with the higher maxattr below, means genetlink now
accepts and validates MPTCP_PM_ATTR_SUBFLOW_RETRIES on
MPTCP_PM_CMD_SET_LIMITS. Is anything consuming it yet at this point in
the series?

At this commit, mptcp_pm_nl_set_limits_doit() in net/mptcp/pm_kernel.c
still parses only the two existing limits:

	subflows = pernet->limit_extra_subflows;
	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
	if (ret)
		goto unlock;

	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
	WRITE_ONCE(pernet->limit_extra_subflows, subflows);

So a set-limits request carrying subflow-retries succeeds, and the value
is silently dropped.

mptcp_pm_nl_get_limits_doit() also never puts the attribute in the
reply, even though the spec lists it in the get-limits reply. And no
per-netns field holds the documented default of 127 yet.

The next patch in the series, "mptcp: pm: in-kernel: add the
subflow-retries limit", fixes this. It adds limit_subflow_retries to
struct pm_nl_pernet and parses the attribute in
mptcp_pm_nl_set_limits_doit(). It also emits it in
mptcp_pm_nl_get_limits_doit() and sets the default to MAX_TCP_SYNCNT in
pm_nl_init_net().

So this only shows up when bisecting to this commit. Would it make sense
to fold the two patches together, or is the spec-first ordering
preferred here?

>
>  /* MPTCP_PM_CMD_GET_LIMITS - do */
> -const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
> +const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
>  	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
> +	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
>  };
>
>  /* MPTCP_PM_CMD_SET_FLAGS - do */
> @@ -127,7 +129,7 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
>  		.validate	= GENL_DONT_VALIDATE_STRICT,
>  		.doit		= mptcp_pm_nl_set_limits_doit,
>  		.policy		= mptcp_pm_set_limits_nl_policy,
> -		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
> +		.maxattr	= MPTCP_PM_ATTR_SUBFLOW_RETRIES,
>  		.flags		= GENL_UNS_ADMIN_PERM,
>  	},

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030050727.3534304-1-anilkaushikwireless%40gmail.com
