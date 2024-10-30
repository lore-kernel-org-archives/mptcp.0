Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEB1C7B68
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312588; cv=none; b=GSXx4wgaBG/QHC36pIt2Dw+dJZfSktMmIRihfmG2+S701UEbwex3bPEJ00QnKQ9cdZ5VUU5HbpR1xeTfq5/o0YE9BZSvb6zviHgk0EIAZIkaPSeoQ1oiOLTgGZFh59jWlpCazb5m/7cfs95drRP8syF/Rbc6X7dS6xuimpIm31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312588; c=relaxed/simple;
	bh=wy3nSusVwupfHNYopJVUoEiG24ZBFX9jrs+77oLK9Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPrkey3PRROpO2ncx2QFNcSA1V/jxY478iRvNCEnan5+gHkYluia4NQBwZ9vnBXFuX/rGGznCHEkI90e7dDQBJqavw5QPMdJolA4urCS9NdeKPo4I4mfLkooDUwsxICDLr3KnpG1jW8kjI3enacVEWW7w99QDB2y8YaOqXd6ekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkIDcc7+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkIDcc7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213FFC4CED1;
	Wed, 30 Oct 2024 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730312588;
	bh=wy3nSusVwupfHNYopJVUoEiG24ZBFX9jrs+77oLK9Qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VkIDcc7+tNb+HpMTNjbNpTksQGIiD2p6ryva0/dE0n0Am0FI26hxEyRRFz19pmf/8
	 0SOoMhR3nVWuUNAUci1GilL1r9eMjBBkNECLXzfq4lNorlLE5AALXGr0xVaU+zrFwn
	 2rlVdof+ADZsbiHF7k3pNJoZq/kmCB1pAuWsW2gGMEmJ30APIO3gZsb3TVgy7YTkPs
	 l1J7yGHbl7iR4p34v9VsiP3cjyhJ82oi/QB1Mim5IwzqUPOfIkca75HRd5gg71xKQ0
	 Ac2gaIJPo0pcY0MuGYORn1nB4HqwoiYxfQYfb2NwR/4Mps8qRU8gW9gE4Dxt2N6JW9
	 uncdw1EFr8AHA==
Message-ID: <8833171c-167d-4f5e-99a6-dc4b2a26e119@kernel.org>
Date: Wed, 30 Oct 2024 19:23:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 06/36] mptcp: add
 mptcp_userspace_pm_get_sock helper
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <020b0eb4dff6e4b19dba43609c758e49d1f38a08.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <020b0eb4dff6e4b19dba43609c758e49d1f38a08.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Each userspace pm netlink function uses nla_get_u32() to get the msk
> token value, then pass it to mptcp_token_get_sock() to get the msk.
> Finally check whether userspace PM is selected on this msk. It makes
> sense to wrap them into a helper, named mptcp_userspace_pm_get_sock(),
> to do this.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 137 +++++++++++++--------------------------
>  1 file changed, 44 insertions(+), 93 deletions(-)

Looks like a good refactoring!

> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index ce0f7131c701..79ae32c921b7 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -169,36 +169,51 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
>  	return backup;
>  }
>  
> -int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
> +static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
>  {
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> +	struct mptcp_sock *msk = NULL;

(no need to set it to NULL, see below)

> +
> +	if (!token) {
> +		GENL_SET_ERR_MSG(info, "missing required inputs");

Maybe we can take this opportunity to mention the token: "missing
required token".

> +		goto out;

Detail: simply return 'NULL' here, there is no clean-up to do, no?

> +	}
> +
> +	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));

I see that below, we were also using sock_net(skb->sk) or even
sock_net(msg->sk). Please mention such modifications in the commit
message, explaining why it is OK to use only genl_info_net(). I guess it
is the same info, but better to be sure and not hide that.

> +	if (!msk) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +		goto out;

Same here.

> +	}
> +
> +	if (!mptcp_pm_is_userspace(msk)) {
> +		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> +		sock_put((struct sock *)msk);

Mmh, I was not sure if it would be a good idea to do this check and
sock_put() here, but I guess that's OK as we just got the msk with the
previous call. (no need to change then)

> +		msk = NULL;

I guess you can also simply return NULL here, and remove the 'out' label.

> +	}
> +
> +out:
> +	return msk;
> +}
> +
> +int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
> +{
>  	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
>  	struct mptcp_pm_addr_entry addr_val;
>  	struct mptcp_sock *msk;
>  	int err = -EINVAL;
>  	struct sock *sk;
> -	u32 token_val;
>  
> -	if (!addr || !token) {
> +	if (!addr) {
>  		GENL_SET_ERR_MSG(info, "missing required inputs");

Same here, "missing required address".

>  		return err;
>  	}
>  
> -	token_val = nla_get_u32(token);
> -
> -	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
> -	if (!msk) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +	msk = mptcp_userspace_pm_get_sock(info);
> +	if (!msk)
>  		return err;
> -	}
>  
>  	sk = (struct sock *)msk;
>  
> -	if (!mptcp_pm_is_userspace(msk)) {
> -		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> -		goto announce_err;
> -	}
> -
>  	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
>  	if (err < 0) {
>  		GENL_SET_ERR_MSG(info, "error parsing local address");
> @@ -271,7 +286,6 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
>  
>  int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
>  	struct mptcp_pm_addr_entry *match;
>  	struct mptcp_pm_addr_entry *entry;
> @@ -279,30 +293,21 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  	LIST_HEAD(free_list);
>  	int err = -EINVAL;
>  	struct sock *sk;
> -	u32 token_val;
>  	u8 id_val;
>  
> -	if (!id || !token) {
> +	if (!id) {
>  		GENL_SET_ERR_MSG(info, "missing required inputs");

Same here, "missing required ID".

>  		return err;
>  	}
>  
>  	id_val = nla_get_u8(id);
> -	token_val = nla_get_u32(token);
>  
> -	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
> -	if (!msk) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +	msk = mptcp_userspace_pm_get_sock(info);
> +	if (!msk)
>  		return err;
> -	}
>  
>  	sk = (struct sock *)msk;
>  
> -	if (!mptcp_pm_is_userspace(msk)) {
> -		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> -		goto out;
> -	}
> -
>  	if (id_val == 0) {
>  		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
>  		goto out;
> @@ -336,7 +341,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
> -	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
>  	struct mptcp_pm_addr_entry entry = { 0 };
>  	struct mptcp_addr_info addr_r;
> @@ -344,28 +348,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  	struct mptcp_sock *msk;
>  	int err = -EINVAL;
>  	struct sock *sk;
> -	u32 token_val;
>  
> -	if (!laddr || !raddr || !token) {
> +	if (!laddr || !raddr) {
>  		GENL_SET_ERR_MSG(info, "missing required inputs");

I guess here, you could have "missing required address(es)".

>  		return err;
>  	}
>  
> -	token_val = nla_get_u32(token);
> -
> -	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
> -	if (!msk) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +	msk = mptcp_userspace_pm_get_sock(info);
> +	if (!msk)
>  		return err;
> -	}
>  
>  	sk = (struct sock *)msk;
>  
> -	if (!mptcp_pm_is_userspace(msk)) {
> -		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> -		goto create_err;
> -	}
> -
>  	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
>  	if (err < 0) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
> @@ -468,35 +462,24 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
>  int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
> -	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
>  	struct mptcp_addr_info addr_l;
>  	struct mptcp_addr_info addr_r;
>  	struct mptcp_sock *msk;
>  	struct sock *sk, *ssk;
>  	int err = -EINVAL;
> -	u32 token_val;
>  
> -	if (!laddr || !raddr || !token) {
> +	if (!laddr || !raddr) {

I guess here, you could have "missing required address(es)".

>  		GENL_SET_ERR_MSG(info, "missing required inputs");
>  		return err;
>  	}
>  
> -	token_val = nla_get_u32(token);
> -
> -	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
> -	if (!msk) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +	msk = mptcp_userspace_pm_get_sock(info);
> +	if (!msk)
>  		return err;
> -	}
>  
>  	sk = (struct sock *)msk;
>  
> -	if (!mptcp_pm_is_userspace(msk)) {
> -		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> -		goto destroy_err;
> -	}
> -
>  	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
>  	if (err < 0) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
> @@ -559,30 +542,18 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
>  	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
>  	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
> -	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
> -	struct net *net = sock_net(skb->sk);
>  	struct mptcp_sock *msk;
>  	int ret = -EINVAL;
>  	struct sock *sk;
> -	u32 token_val;
>  	u8 bkup = 0;
>  
> -	token_val = nla_get_u32(token);
> -
> -	msk = mptcp_token_get_sock(net, token_val);
> -	if (!msk) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +	msk = mptcp_userspace_pm_get_sock(info);
> +	if (!msk)
>  		return ret;
> -	}
>  
>  	sk = (struct sock *)msk;
>  
> -	if (!mptcp_pm_is_userspace(msk)) {
> -		GENL_SET_ERR_MSG(info, "userspace PM not selected");
> -		goto set_flags_err;
> -	}
> -
>  	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
>  	if (ret < 0)
>  		goto set_flags_err;
> @@ -619,30 +590,20 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
>  	} *bitmap;
>  	const struct genl_info *info = genl_info_dump(cb);
> -	struct net *net = sock_net(msg->sk);
>  	struct mptcp_pm_addr_entry *entry;
>  	struct mptcp_sock *msk;
> -	struct nlattr *token;
>  	int ret = -EINVAL;
>  	struct sock *sk;
>  	void *hdr;
>  
>  	bitmap = (struct id_bitmap *)cb->ctx;
> -	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  
> -	msk = mptcp_token_get_sock(net, nla_get_u32(token));
> -	if (!msk) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +	msk = mptcp_userspace_pm_get_sock(info);
> +	if (!msk)
>  		return ret;
> -	}
>  
>  	sk = (struct sock *)msk;
>  
> -	if (!mptcp_pm_is_userspace(msk)) {
> -		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> -		goto out;
> -	}
> -
>  	lock_sock(sk);
>  	spin_lock_bh(&msk->pm.lock);
>  	mptcp_for_each_address(msk, entry) {
> @@ -667,7 +628,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  	release_sock(sk);
>  	ret = msg->len;
>  
> -out:
>  	sock_put(sk);
>  	return ret;
>  }
> @@ -676,28 +636,19 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
>  				struct genl_info *info)
>  {
>  	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
> -	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct mptcp_pm_addr_entry addr, *entry;
> -	struct net *net = sock_net(skb->sk);
>  	struct mptcp_sock *msk;
>  	struct sk_buff *msg;
>  	int ret = -EINVAL;
>  	struct sock *sk;
>  	void *reply;
>  
> -	msk = mptcp_token_get_sock(net, nla_get_u32(token));
> -	if (!msk) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +	msk = mptcp_userspace_pm_get_sock(info);
> +	if (!msk)
>  		return ret;
> -	}
>  
>  	sk = (struct sock *)msk;
>  
> -	if (!mptcp_pm_is_userspace(msk)) {
> -		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> -		goto out;
> -	}
> -
>  	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
>  	if (ret < 0)
>  		goto out;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

