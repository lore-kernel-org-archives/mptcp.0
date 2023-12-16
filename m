Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56137110D
	for <mptcp@lists.linux.dev>; Sat, 16 Dec 2023 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJeZPfhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A66C433C7;
	Sat, 16 Dec 2023 01:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702691300;
	bh=m78bg3lHC+gxtTMxIxqSc34s5XgvwLIrt8CNYEihkAg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JJeZPfhWzFlFdukATr+sQ+VOYF3VCMq7IUErr0GM5pUlEaUjR0VoJuY2ce7M3NG/t
	 hJL9vapJcWF97+0mcQZDVidIlljQjg3vskXnEDOOn4Sy5j3QvW4CzaJlD82XVnWwea
	 wx41xfp+IvYjBHPPzcFe9DpcH4qq5a2sPqW1oQxgkS1a2hPo+PVj+m8TZO7GJt2kP6
	 cpVVDAEqxNdoUCEWXjhxPkqO6aknMXydfJwNwnz9FwigRiXpzIk3bedk8UYLLy8MIz
	 y3YFdnMpnirezLRjkTKtR1JzmBjLqDuVFjNl+kcI/qkT6OArdDun+NBuU+St2iDJK/
	 za/ct3zQcG/oA==
Date: Fri, 15 Dec 2023 17:48:19 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 10/12] mptcp: get addr in userspace pm list
In-Reply-To: <5e5a1023c8ceaf2781c61974b7b6540e2de50609.1702282411.git.geliang.tang@linux.dev>
Message-ID: <61a04b95-5ba7-ddcf-c7fe-a9f6a9d60928@kernel.org>
References: <cover.1702282411.git.geliang.tang@linux.dev> <5e5a1023c8ceaf2781c61974b7b6540e2de50609.1702282411.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 11 Dec 2023, Geliang Tang wrote:

> This patch adds 'MPTCP_PM_ATTR_TOKEN' in mptcp_pm_get_addr_nl_policy,
> then token can be gotten in mptcp_pm_nl_get_addr_doit(). If token isn't
> null, invoke mptcp_userspace_pm_get_addr() to get addr in userspace pm
> list.
>
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> net/mptcp/mptcp_pm_gen.c | 5 +++--
> net/mptcp/mptcp_pm_gen.h | 2 +-

Hi Geliang -

These two files should not be edited directly (check the comments at the 
top of the files).

Instead, modify the yaml that is used to generate them:

Documentation/netlink/specs/mptcp.yaml

(rename to mptcp_pm.yaml is happening now: 
https://patchwork.kernel.org/project/netdevbpf/patch/20231215015735.3419974-4-kuba@kernel.org/ 
)

See also the commit message for aab4d8564947f391674391e5c346d7f6f1c49f89


- Mat


> net/mptcp/pm_netlink.c   | 5 +++++
> 3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
> index a2325e70ddab..f1b470178d66 100644
> --- a/net/mptcp/mptcp_pm_gen.c
> +++ b/net/mptcp/mptcp_pm_gen.c
> @@ -32,8 +32,9 @@ const struct nla_policy mptcp_pm_del_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1]
> };
>
> /* MPTCP_PM_CMD_GET_ADDR - do */
> -const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1] = {
> +const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ATTR_TOKEN + 1] = {
> 	[MPTCP_PM_ENDPOINT_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
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
> index 10579d184587..3963c55950b7 100644
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
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 0c1ea3c42584..dace3a65c680 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1713,14 +1713,19 @@ int mptcp_pm_nl_put_entry_msg(struct sk_buff *msg,
> int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
> {
> 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
> +	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> 	struct mptcp_pm_addr_entry addr, *entry;
> +	struct net *net = sock_net(skb->sk);
> 	int ret;
>
> 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
> 	if (ret < 0)
> 		return ret;
>
> +	if (token)
> +		return mptcp_userspace_pm_get_addr(net, info, token, addr.addr.id);
> +
> 	spin_lock_bh(&pernet->lock);
> 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
> 	if (!entry) {
> -- 
> 2.35.3
>
>
>
