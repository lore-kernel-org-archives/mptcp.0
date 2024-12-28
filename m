Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839802111
	for <mptcp@lists.linux.dev>; Sat, 28 Dec 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735402566; cv=none; b=Wv9eeJNkvXDZsHI7HLjMs4I7Wu6HgW/tNeRr5xm76/SOBng7Z+W303SI+7XBGwaBjkby2kEeF9sq+tt99mVp0YEDmYCJcn80A1ip9nVQgwK/SD56tUrjMYLUo1jcEy/XZbasWFPiikUgWCHlA78/liuHHO0k0kS67oeLCbL3fRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735402566; c=relaxed/simple;
	bh=+WI8YkvzWQ8fTQLcEhHrKdxcR3P+cqG7nV3ZwW4Vayc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4Ffwtehf/ukm8nyJjQ9Y0g0HtP9pXkPdttPF+ICge6v6MR0kVy/srrAClo6ssbhcnXP4GljY/gHx7jLk6RFEBTP1r+ysJI8ZqmwT3ckN/f694W6RSYIMjfRUfUOjWOpx4qCRLsFchjHqsFb4vpnrLTe3nb0TH30ieJOJORGuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3iR4Vt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3iR4Vt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E56C4CECD;
	Sat, 28 Dec 2024 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735402566;
	bh=+WI8YkvzWQ8fTQLcEhHrKdxcR3P+cqG7nV3ZwW4Vayc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T3iR4Vt0H53bgGm9BlKkyj4siglm85D+bfNcZhoryNT9sRgwuMjPA1x+rgAZsHpKw
	 zakyqZbDldUPNJaRmRzLyY6fHmCZdJkJ/JA8md5aXAJDKKBXQukqLF1+kzg2KGyI4R
	 k02lh3NHiaWW20TXMW5u9kN0L+EG09Qrhb+0KP1VdXkfIhK3FXPh3SVdvBnECSgZFv
	 Ue7THRu8hA/kIj3CHu2iVftGESkq0kw9/AwU5Pa+BMSDEangvO0VPP3yORgyhY+VMF
	 S7rkn5zce5EawY4HBvDb2awPJf0lk8bMuurwlZg0S1fFQy1Ih/qdcnQmwCtSbfU6CP
	 24rVXZZiMgSgw==
Message-ID: <bb281101-ad9c-4710-ae8e-eab3abd6819b@kernel.org>
Date: Sat, 28 Dec 2024 17:16:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5] mptcp: use GENL_REQ_ATTR_CHECK in userspace
 pm
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <ef87c8dd40c8dac4b946bf77e272d01ca64cc9dd.1734941967.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ef87c8dd40c8dac4b946bf77e272d01ca64cc9dd.1734941967.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/12/2024 09:24, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> A more general way to check if MPTCP_PM_ATTR_* exists in 'info'
> is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_*) instead of
> directly reading info->attrs[MPTCP_PM_ATTR_*] and then checking
> if it's NULL.
> 
> So this patch uses GENL_REQ_ATTR_CHECK() for userspace PM in
> mptcp_pm_nl_announce_doit(), mptcp_pm_nl_remove_doit(),
> mptcp_pm_nl_subflow_create_doit(), mptcp_pm_nl_subflow_destroy_doit()
> and mptcp_userspace_pm_get_sock().
> 
> 'Suggested-by: Jakub Kicinski <kuba@kernel.org>'
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v5:
>  - drop 'struct nlattr *' variables as Matt suggested (thanks)

Thank you for the v5!

> v4:
>  - use GENL_REQ_ATTR_CHECK in more functions as Matt suggested (thanks)
> 
> v3:
>  - use GENL_REQ_ATTR_CHECK in mptcp_userspace_pm_get_sock only
>  - drop GENL_SET_ERR_MSG as Matt suggested (thanks)
> 
> v2:
>  - use GENL_REQ_ATTR_CHECK in get_addr(), dump_addr() and set_flags()
>    too.
> ---
>  net/mptcp/pm_userspace.c | 69 ++++++++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 740a10d669f8..42dda8877372 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -175,17 +175,17 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
>  
>  static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
>  {
> -	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct mptcp_sock *msk;
>  
> -	if (!token) {
> -		GENL_SET_ERR_MSG(info, "missing required token");
> +	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
>  		return NULL;
> -	}
>  
> -	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
> +	msk = mptcp_token_get_sock(genl_info_net(info),
> +				   nla_get_u32(info->attrs[MPTCP_PM_ATTR_TOKEN]));
>  	if (!msk) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +		NL_SET_ERR_MSG_ATTR(info->extack,
> +				    info->attrs[MPTCP_PM_ATTR_TOKEN],
> +				    "invalid token");

Arf, sorry, I didn't notice the 'struct nlattr *' variables were used in
multiple places: I guess I only looked at mptcp_pm_nl_remove_doit()
where in the v4, we had:

 	id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	id_val = nla_get_u8(id);

... and 'id' was only used there. But maybe that's not normal to use
'id' only once: probably because we used GENL_SET_ERR_MSG() instead of
NL_SET_ERR_MSG_ATTR() which seems better, no?
(same in mptcp_pm_nl_announce_doit())

I can send a quick patch for that, and place your v4 on top of it.

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

