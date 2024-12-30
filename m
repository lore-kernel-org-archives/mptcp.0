Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10719ABA3
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735576159; cv=none; b=YQtY/+Or5ZCh18K9DOvW0B7IEm+dfjFnK8jpArsyr2seTrXeFSJDWrYvjGL0Zdwv0w/M3WG4+QTJz2RZmEpmuXuLjSJo2n/8ZvGSyRrYdmX2TajA/pqiUHjApNPdyj4SwDSdU9aSF0eudFCMd10jMepfGLM9pfBj1ZrVcCpjRAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735576159; c=relaxed/simple;
	bh=dWaOgoWo607jbTMLD6Fybvln0T4c4bU+f1oNE5Lvcr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6BRG99bE8Trkw58bOhxLuqxWYXzysX0b/SoYttFWJQ/ncoBTVSPyhVmTAc/JTdoCZ25akXjoQKPUbF1w3F/1uO084d1L1/+U5/mdSPdcaN1DOyzKC+t8A+53byYgQlajLxsej6MmIUlPV32F/Of3hFSMXURUFLpd3/b1dHu7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRD4AA4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRD4AA4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B035FC4CED0;
	Mon, 30 Dec 2024 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735576159;
	bh=dWaOgoWo607jbTMLD6Fybvln0T4c4bU+f1oNE5Lvcr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MRD4AA4XmXeHchgMISgGDyAbfrp6yBriStf2SzW+57pftVk7XJWl8RR45ONLGFFbp
	 QInvL8j0jkHsTKJgGmpc7B18Anld//MkZNaek6Us59AJW09BRVqEu5j+dlKBiZjYzC
	 Z+5B3gzAFFxSWKRRZQ0rd1pcTP/mHV0K+nL4YeXv4fv8dpveDMdflYhWPXZHhDBbTw
	 sfRmc/c6TmapM80BkTaIWaQRPBGK5TbOmtNjutR6rVLNmlhxXLkSBmhIzzgYefWeL9
	 gJY51MKPrk7Gf15I0D7xRg0p3HUggPUNK9LNh25Met0XaXrSwU+DFSbPh4O9GqEYH5
	 VojxRbP/CMArw==
Message-ID: <1e38f357-3fe3-4a0a-8dd9-715f879caa82@kernel.org>
Date: Mon, 30 Dec 2024 17:29:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 3/8] mptcp: add id parameter for get_addr
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
 <737e168d74af571f6740cbe64b3a7f46ac981f7b.1734074788.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <737e168d74af571f6740cbe64b3a7f46ac981f7b.1734074788.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Sorry, I just noticed this will cause conflicts with the series I just sent:


https://lore.kernel.org/all/20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org/T/

On 13/12/2024 08:35, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The address id is parsed both in mptcp_pm_nl_get_addr() and
> mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
> So this patch adds a new parameter 'id' for all get_addr() interfaces.
> The address id is only parsed in mptcp_pm_nl_get_addr_doit(), then pass
> it to both mptcp_pm_nl_get_addr() and mptcp_userspace_pm_get_addr().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c           | 16 ++++++++++++----
>  net/mptcp/pm_netlink.c   | 11 +++--------
>  net/mptcp/pm_userspace.c | 11 +++--------
>  net/mptcp/protocol.h     |  4 ++--
>  4 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 526e5bca1fa1..c7d323c7c7aa 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -434,16 +434,24 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
>  	return mptcp_pm_nl_is_backup(msk, &skc_local);
>  }
>  
> -static int mptcp_pm_get_addr(struct genl_info *info)
> +static int mptcp_pm_get_addr(u8 id, struct genl_info *info)
>  {
>  	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
> -		return mptcp_userspace_pm_get_addr(info);
> -	return mptcp_pm_nl_get_addr(info);
> +		return mptcp_userspace_pm_get_addr(id, info);
> +	return mptcp_pm_nl_get_addr(id, info);
>  }
>  
>  int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return mptcp_pm_get_addr(info);
> +	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
> +	struct mptcp_pm_addr_entry addr;
> +	int ret;
> +
> +	ret = mptcp_pm_parse_entry(attr, info, false, &addr);

Could you first check if the attribute is set (to report a more precise
error), before parsing it please?

  if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
        return -EINVAL;

  attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
  ret = mptcp_pm_parse_entry(attr, info, false, &addr);
  (...)

So similar to this:


https://lore.kernel.org/all/20241230-genl_req_attr_check-v6-7-3ec9103559e7@kernel.org/

> +	if (ret < 0)
> +		return ret;
> +
> +	return mptcp_pm_get_addr(addr.addr.id, info);
>  }
>  
>  static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 92b4dcc310d3..de6a8e7a4a1a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1762,19 +1762,14 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
>  	return -EMSGSIZE;
>  }
>  
> -int mptcp_pm_nl_get_addr(struct genl_info *info)
> +int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
>  {
> -	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
>  	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> -	struct mptcp_pm_addr_entry addr, *entry;
> +	struct mptcp_pm_addr_entry *entry;
>  	struct sk_buff *msg;
>  	void *reply;
>  	int ret;
>  
> -	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
> -	if (ret < 0)
> -		return ret;
> -
>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!msg)
>  		return -ENOMEM;
> @@ -1788,7 +1783,7 @@ int mptcp_pm_nl_get_addr(struct genl_info *info)
>  	}
>  
>  	rcu_read_lock();
> -	entry = __lookup_addr_by_id(pernet, addr.addr.id);
> +	entry = __lookup_addr_by_id(pernet, id);
>  	if (!entry) {
>  		GENL_SET_ERR_MSG(info, "address not found");

Mmh, I switched this to NL_SET_ERR_MSG_ATTR() in:


https://patchwork.kernel.org/project/mptcp/patch/20241230-genl_req_attr_check-v6-1-3ec9103559e7@kernel.org/

... which requires 'attr'. We could not do the conversion here in the
patch I sent. But because you are also moving this part to pm.c in the
next patch, I suggest to temporally pass the pointer to 'attr' here in
this patch 3, and remove it in patch 4.

WDYT?

>  		ret = -EINVAL;
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index ab92efec6618..40a018be243e 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -663,10 +663,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  	return ret;
>  }
>  
> -int mptcp_userspace_pm_get_addr(struct genl_info *info)
> +int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
>  {
> -	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
> -	struct mptcp_pm_addr_entry addr, *entry;
> +	struct mptcp_pm_addr_entry *entry;
>  	struct mptcp_sock *msk;
>  	struct sk_buff *msg;
>  	int ret = -EINVAL;
> @@ -679,10 +678,6 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
>  
>  	sk = (struct sock *)msk;
>  
> -	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
> -	if (ret < 0)
> -		goto out;
> -
>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!msg) {
>  		ret = -ENOMEM;
> @@ -699,7 +694,7 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
>  
>  	lock_sock(sk);
>  	spin_lock_bh(&msk->pm.lock);
> -	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
> +	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
>  	if (!entry) {
>  		GENL_SET_ERR_MSG(info, "address not found");

Same here for GENL_SET_ERR_MSG() vs NL_SET_ERR_MSG_ATTR().

>  		ret = -EINVAL;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index dd673b41f0ce..76a0cfe54723 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1131,8 +1131,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
>  			  struct netlink_callback *cb);
>  int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  				 struct netlink_callback *cb);
> -int mptcp_pm_nl_get_addr(struct genl_info *info);
> -int mptcp_userspace_pm_get_addr(struct genl_info *info);
> +int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info);
> +int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
>  
>  static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
>  {

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

