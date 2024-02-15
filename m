Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC113AA23
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038000; cv=none; b=l97y1TWzcmyNO3XSB1t2iFJj4wFbrNN+mvSWGL/vRCiBeyhyWId7bQvlRG7kQ36WiOj5/M4MzICcNghtRuJYjLNgYKuNI6VYakmWOzGC+zzzgvmEiFP5rcS9NwvVhStLtI6pZmGBYWT3WXv+crUgsIYWWsF3y0MljRPsl1rQD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038000; c=relaxed/simple;
	bh=0BgsY+i+Oqs3WVpv+XdOoQTekNVY1laMf1oFsrPevtw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M576D2ekI7W8MYK5JTbuFXfCoXIP7W8Utm1qKlg9dnoFZDkpW6Y44y6wL3TFEVCcafIS0cdmYINt4scqLptbwDiBP11Gz5N/pBrwAJW2DGCBFW8QFM9C9nOLc1zGsDva48SuwPNlU2gnbrHDj98rkpmMvM09P4qgE6+sRvLyp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkkWKHyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkkWKHyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B92BC433C7;
	Thu, 15 Feb 2024 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708038000;
	bh=0BgsY+i+Oqs3WVpv+XdOoQTekNVY1laMf1oFsrPevtw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BkkWKHyKMS0ZpOkT73noRMtbo4bCdrv9rkJEFJH9v8gT74O4v6woi2I9M4EZxjvnt
	 iVM8hwkYp4vGdUPFZc9AQsUtn0jtX0/ofYAJ0XAo0B0pmcyy0X2dG6MALr85b5Yx8w
	 IY/Phb584eO8wwz0VcgF2cbruS0V9ZaWBBV+hXa63kxKst40x+0A6w6T++PJvuumR8
	 P0y2Vk8iogkDYRONdtL+BRnPvaXybMkoFxiLvXAKpW2uRujnhbfLICE5+os2gDq+Jw
	 A1kCy1dxYoWtHmOuwgMCGJEz4+nMT4RI9vjSMIO5HjjM38pC1y6ZgxgA0Ppk02Cd1u
	 hsZgpSrcqWNVQ==
Date: Thu, 15 Feb 2024 15:00:00 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v12 03/15] mptcp: add token for get-addr in
 yaml
In-Reply-To: <4504a86fc813270a21893220297e712e89c4195d.1707910454.git.tanggeliang@kylinos.cn>
Message-ID: <6854381a-37e5-347d-7b00-c5e1831227d6@kernel.org>
References: <cover.1707910454.git.tanggeliang@kylinos.cn> <4504a86fc813270a21893220297e712e89c4195d.1707910454.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 14 Feb 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds token paramenter together with addr in get-addr section in

Hi Geliang -

The CI shows a checkpatch warning for the misspelled "parameter" above.

Thanks,

Mat

> mptcp_pm.yaml, then use the following commands to update mptcp_pm_gen.c
> and mptcp_pm_gen.h:
>
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>        --spec Documentation/netlink/specs/mptcp_pm.yaml --source \
>        -o net/mptcp/mptcp_pm_gen.c
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>        --spec Documentation/netlink/specs/mptcp_pm.yaml --header \
>        -o net/mptcp/mptcp_pm_gen.h
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> Documentation/netlink/specs/mptcp_pm.yaml | 3 ++-
> net/mptcp/mptcp_pm_gen.c                  | 7 ++++---
> net/mptcp/mptcp_pm_gen.h                  | 2 +-
> 3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
> index 49f90cfb4698..af525ed29792 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -292,13 +292,14 @@ operations:
>     -
>       name: get-addr
>       doc: Get endpoint information
> -      attribute-set: endpoint
> +      attribute-set: attr
>       dont-validate: [ strict ]
>       flags: [ uns-admin-perm ]
>       do: &get-addr-attrs
>         request:
>           attributes:
>            - addr
> +           - token
>         reply:
>           attributes:
>            - addr
> diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
> index 670da7822e6c..c30a2a90a192 100644
> --- a/net/mptcp/mptcp_pm_gen.c
> +++ b/net/mptcp/mptcp_pm_gen.c
> @@ -32,8 +32,9 @@ const struct nla_policy mptcp_pm_del_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1]
> };
>
> /* MPTCP_PM_CMD_GET_ADDR - do */
> -const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1] = {
> -	[MPTCP_PM_ENDPOINT_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
> +const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ATTR_TOKEN + 1] = {
> +	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
> +	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
> };
>
> /* MPTCP_PM_CMD_FLUSH_ADDRS - do */
> @@ -110,7 +111,7 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
> 		.doit		= mptcp_pm_nl_get_addr_doit,
> 		.dumpit		= mptcp_pm_nl_get_addr_dumpit,
> 		.policy		= mptcp_pm_get_addr_nl_policy,
> -		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
> +		.maxattr	= MPTCP_PM_ATTR_TOKEN,
> 		.flags		= GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> diff --git a/net/mptcp/mptcp_pm_gen.h b/net/mptcp/mptcp_pm_gen.h
> index ac9fc7225b6a..e24258f6f819 100644
> --- a/net/mptcp/mptcp_pm_gen.h
> +++ b/net/mptcp/mptcp_pm_gen.h
> @@ -18,7 +18,7 @@ extern const struct nla_policy mptcp_pm_add_addr_nl_policy[MPTCP_PM_ENDPOINT_ADD
>
> extern const struct nla_policy mptcp_pm_del_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
>
> -extern const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
> +extern const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ATTR_TOKEN + 1];
>
> extern const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
>
> -- 
> 2.40.1
>
>
>
