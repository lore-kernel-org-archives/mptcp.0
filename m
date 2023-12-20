Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7D48CC0
	for <mptcp@lists.linux.dev>; Wed, 20 Dec 2023 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUupo17L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E110C433C8;
	Wed, 20 Dec 2023 19:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703100867;
	bh=W3l5xz/MbnuKJvExIwAnp0rZ8FWJW48p1GsIGgTdYeI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dUupo17L3KQnZ8j+y7TwXpcOT3M0kGLmC+L+bg+7OfOR37BQhrs73Uh28hmtZDPVV
	 mwckStaKh8EeqbP6rRLu3AC2PJxX0pTg9NG0YNUCFoUwG8fBHC4MxW+sxY3XuzbCiy
	 /Z55QgLG2avc3MbVNJCD1FSsiMTgHXaWbw6BtF74ku4BJdQCSF/b8tgD0lCE11pTow
	 gklVBW1qRRukDfXEgFTwNy5Voi7XFpMEAIEfcIvHnGZNcSDMKLg+Ma/iLaVW/z7V64
	 bMZKfdLAQm4NsyvQZGf31Egcy/Xt+JF39N3gOBWpE/GelS8oefE/h6aOSUry4jQUZC
	 67jlpNoY/PWSg==
Date: Wed, 20 Dec 2023 11:34:26 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 05/14] mptcp: add token for get-addr in
 yaml
In-Reply-To: <0a9dad2c2aafd1688760d1ee5d02da08476f90b5.1702992525.git.geliang.tang@linux.dev>
Message-ID: <0bc2f602-2e5c-3826-631b-118a34c69fe1@kernel.org>
References: <cover.1702992525.git.geliang.tang@linux.dev> <0a9dad2c2aafd1688760d1ee5d02da08476f90b5.1702992525.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 19 Dec 2023, Geliang Tang wrote:

> This patch adds token paramenter together with addr in get-addr section
> in mptcp.yaml, then use the following commands to update mptcp_pm_gen.c
> and mptcp_pm_gen.h:
>
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>        --spec Documentation/netlink/specs/mptcp.yaml --source \
>        -o net/mptcp/mptcp_pm_gen.c
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>        --spec Documentation/netlink/specs/mptcp.yaml --header \
>        -o net/mptcp/mptcp_pm_gen.h
>
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>

Hi Geliang -

Can you move this patch to be #3 in the series (before "mptcp: dump addrs 
in userspace pm list")?

> ---
> Documentation/netlink/specs/mptcp_pm.yaml | 5 ++++-
> net/mptcp/mptcp_pm_gen.c                  | 7 ++++---
> net/mptcp/mptcp_pm_gen.h                  | 2 +-
> 3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
> index 49f90cfb4698..cc731dbaa427 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -292,20 +292,23 @@ operations:
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
> +           - token

Is the token needed in the reply attributes? I don't see 
mptcp_nl_fill_addr() populating any token attributes.

>       dump:

I think this also needs:

         request:
           attributes:
           - token

>         reply:
>          attributes:
>            - addr
> +           - token

Same question as above - doesn't look like tokens are added to replies, 
but maybe I missed a detail.

- Mat


>     -
>       name:  flush-addrs
>       doc: flush addresses
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
> 2.35.3
>
>
>
