Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153672;
	b=zztdl4GzcY3sjfCddF+m7vVLs6nTjRKj2v64Hw9b4PTxlTwS0tcx+IB0ISWEPRXaZgr0
	 I+AOojdnumXwbpuw12UPwJQaJYzFBX4e5KsFnn9/gzqPI37N/zE7ytJCJvGeNDTEiO/9U
	 UUt6eC/aIwMDyvCl0akFcuOsQRvFksihmXU8o0Z4pkFde2p37xQiCMa4ItvPspOD8i2qV
	 KtDPQ1j5NEfWVJYM7ro23PTvN8J2fsd6s1rDKPrQGR0gcB+eXj57JU9xbAyvkRuuAEPX+
	 5ZlDWh/AoPMIgkRy1dNUipYu4jX2g8LxJzF6zFmLyr7vLOV0oxe20UOQIb1u6GvXidg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153672;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8V35njRw5S3YfcjpoRa4+oOLuQDy6Rlobkl2Dq7vmJ0=;
	b=oiXJfyqqj2JcKHODypx+RIZZQj1o1v8n9n1R5NjaFh7Z8QUoD2jbia1QLcR5ft6I7SKn
	 odajm7Qc/HRz76jsA4rVnDvWn9DVVjbUmgjqJLRcZ75TBM2euC+AP+DKvtw6tsGrtRUE6
	 +6VkTfMRrK4tRPjnHHcy/XsHlh/iZb+a1AVKVn4JVjQUCiMOubJqbO9AeQEIj0rDshcdW
	 dkEzxPMKWuog1CY+emJO4QTe5V3Adabj1kCyoWtESic/ht58l9eVinR8Qp70TGkMT+kbU
	 jcV+rGkjLExLoVLww24Da6iFr20SHreoNsz+hk0/qWVKCCU6wQPrSMF7ICLBE9lfl5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okmszkvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE21606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okmszkvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EA01F01825;
	Wed, 28 Oct 2026 02:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793153671;
	bh=8V35njRw5S3YfcjpoRa4+oOLuQDy6Rlobkl2Dq7vmJ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=okmszkvOk80GpHGvFrx3katlPK9Zl4PT4jQRQB3viOE3aXyqY3/xJZ4CbqFKmw8LR
	 olecwL+rnUSFOv9ZZRvIiT6sPP16Z4taI3rAIABPAXCc2AGdbxL/PBRLkbauXlCcud
	 /Lc6MLFJYeoCw/WJWnTXSfT8sdbPrMAuDGbfD/kxRSl4HPgfmWDgxdnltaMn/H8C5P
	 0wN4EG+kyR2Hip04rjfd7FcQ83Xugblr9QLnP7QkMiXhMxRCGamZlo5ztnCpVxo9RO
	 aj/CptbUhISSpgKFD/L/joY6yuya6x6OS1zAnv5R1JBp/4zU6w5Xj0f5ZDlkBNxu+M
	 wyO/LIfoA6hpw==
Subject: Re: [PATCH mptcp-next v11 2/6] netlink: specs: mptcp: add the
 subflow-retries attribute
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 28 Oct 2026 02:14:30 +0000
Message-ID: <179315367073.3132.13400521849828888593@kernel.org>
In-Reply-To: <20261026125345.3019372-3-anilkaushikwireless@gmail.com>
References: <20261026125345.3019372-3-anilkaushikwireless@gmail.com>
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

- [Low] In this commit only, the spec, uAPI header and generated policy
  for MPTCP_PM_ATTR_SUBFLOW_RETRIES get ahead of the PM handlers.

--

netlink: specs: mptcp: add the subflow-retries attribute

This commit adds a subflow-retries u32 attribute, capped at 127, to the
mptcp_pm netlink spec. It is added to the set-limits and get-limits
commands. The uapi header and the generated policy files are regenerated
with ynl-regen.

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
At this commit, the policy and .maxattr accept MPTCP_PM_ATTR_SUBFLOW_RETRIES
for SET_LIMITS and GET_LIMITS, but the handlers in net/mptcp/pm_kernel.c
have not changed. mptcp_pm_nl_set_limits_doit() still parses only the two
existing limits:

net/mptcp/pm_kernel.c:mptcp_pm_nl_set_limits_doit() {
    ...
	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
    ...
	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
    ...
}

On a kernel built at exactly this commit, would a SET_LIMITS request
carrying subflow-retries pass validation and return success, with the value
silently ignored?

mptcp_pm_nl_get_limits_doit() also does not put the attribute in its reply.
No per-netns default of MAX_TCP_SYNCNT exists yet either, even though the
spec doc says it is the default.

The next patch in the series, "mptcp: pm: in-kernel: add the
subflow-retries limit", adds all of this:

- nla_get_u32_default() in set_limits, stored in
  pernet->limit_subflow_retries
- nla_put_u32() in get_limits
- pernet->limit_subflow_retries = MAX_TCP_SYNCNT at init

So the gap only shows up when bisecting between these two adjacent patches.
Splitting the spec change from the implementation is a common way to
structure netlink series, so this may be fine as is.

A smaller point: the GET_LIMITS request policy also range-checks
subflow-retries, even though the handler ignores request attributes. This
follows the existing spec pattern for rcv-add-addrs and subflows.

>  
>  /* MPTCP_PM_CMD_GET_LIMITS - do */
> -const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
> +const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
>  	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
> +	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026125345.3019372-1-anilkaushikwireless%40gmail.com
