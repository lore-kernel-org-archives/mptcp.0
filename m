Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F83BB131
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301965; cv=none; b=p1KQuhhh9U5KLQBbrjESpLYw9MDHx4e+f/dKpzTHhK+8KUEobBYeaBOir9ECnAP40gtjolMHH6TLGJ9vTWASc20h4Jn6VsMDHhyr85ZukpzsJXUWMaX+SMe1juYT4SvFQQR334Skv7U9NQpqsvQ2MVPWwkOrExFcn8b4gaG1MCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301965; c=relaxed/simple;
	bh=phTdQMGSu4lMoH0tj5DhfB9R/Y+twwYI3VZOaDsQkr4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJVxtgDYD+oRQBNXdPutJFLi0oxKzV1bBgw/xlsDVw/jq8liFSGiUVH9JABTO5L5g4VA3g4LiTxUYx2EocQuA6wIeapC1KA4FoB0yairu/JVze0xQakiAMWkjkVsVXCNsIUolDbj0UgpkB13y6vbNVJyMzxfDqRAmPA24DExMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT1IP06O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT1IP06O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628D11F000C4;
	Sun, 18 Oct 2026 05:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792301963;
	bh=q+BKmnbMzp5HjI1fdza+b225MUtFDgU7/CaBVnvwnTo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RT1IP06Ox9F0M/JPckr895pprOYNcBQlgHkPtznq8gJwRzbnt8R5wtsz5FJ/Oh3r1
	 ls0X5RwviImDtdllsK0nwjug2Z5rAOUIaxD8rW8hn77ftLoYnY6oL9IPG+n1N48FIv
	 Q0q+uIBtporbj7Pu0L3OzeGQGJEjv7uyEYkr+XnAEhCPjukIjdqFy/Xbu5v2ii38A+
	 zTPLPw4copM10g3w7VaZtmpzl/d+6sl09ZYWOMNU5OAwihEOYOccgeLjxvWcmOWbSb
	 WKLdeqjQBruHkF4pGLi7WXFInWkoR8reUTPIf8kehdyvTpMhnN+XlJpVmA9vmCvCQF
	 ah5eAknKVhJIw==
Subject: Re: [PATCH mptcp-next v5 3/7] netlink: specs: mptcp: add the
 subflow-retries attribute
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 18 Oct 2026 05:39:22 +0000
Message-ID: <179230196294.3133.3154846340684241967@kernel.org>
In-Reply-To: <20261016160926.1155262-4-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-4-anilkaushikwireless@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This gap exists only at this one commit; the next patch in the
  series closes it.

--

netlink: specs: mptcp: add the subflow-retries attribute

This adds a subflow-retries u32 attribute to the MPTCP PM netlink spec and
lists it in the set-limits request and in the get-limits request and reply.
The uapi header and the generated policy files are regenerated to match.

> diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
> index c180930a8e0e4..127a1fadaac40 100644
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
> +	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = { .type = NLA_U32, },
>  };

[ ... ]

> @@ -127,7 +129,7 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
>  		.validate	= GENL_DONT_VALIDATE_STRICT,
>  		.doit		= mptcp_pm_nl_set_limits_doit,
>  		.policy		= mptcp_pm_set_limits_nl_policy,
> -		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
> +		.maxattr	= MPTCP_PM_ATTR_SUBFLOW_RETRIES,
>  		.flags		= GENL_UNS_ADMIN_PERM,
>  	},

[Severity: Low]
With only this patch applied, MPTCP_PM_CMD_SET_LIMITS accepts
MPTCP_PM_ATTR_SUBFLOW_RETRIES. Is the value then silently dropped?

mptcp_pm_nl_set_limits_doit() in net/mptcp/pm_kernel.c still parses only
the two existing limits:

	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs,
			  MPTCP_PM_SUBFLOWS_MAX);
	...
	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows,
			  MPTCP_PM_SUBFLOWS_MAX);
	...
	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
	WRITE_ONCE(pernet->limit_extra_subflows, subflows);

A request that carries subflow-retries passes validation and returns 0,
but the value is not stored anywhere.

In the same way, mptcp_pm_nl_get_limits_doit() never adds
MPTCP_PM_ATTR_SUBFLOW_RETRIES to its reply, even though the spec lists it
in the get-limits reply.

Only a bisect build at this commit is affected. The next patch in the
series, "mptcp: pm: in-kernel: add the subflow-retries limit", adds the
parse_limit() call, the WRITE_ONCE(pernet->limit_subflow_retries, ...) and
the nla_put_u32() in the reply. At the end of the series the spec and the
implementation match.

Could this spec change be squashed into that patch, so the attribute is
never advertised without a handler?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016160926.1155262-1-anilkaushikwireless%40gmail.com
