Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F82505A7
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158629; cv=none; b=gfO2rX0D1uUHEm1iRy1ruO4gGylWTly7I3h8/kahoFIoxlbIAoa6pYYcNFFaSqXg4M/Ff8btejVj1Pw9b55zKqBZjx/+373kP9UzJYaqLyyd7c362/u274lCMBZPSitzyXyrovJYHYFTL21ghSsjmq3xdzQrzVrDgQinRuc9wU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158629; c=relaxed/simple;
	bh=gL377Afco2PQ71g8IKck7adfqy88v72fxv+lL5ROLBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ActniWLagrPTQTz5WeycL6FR1pDw+m7tCd7usVxPcPlK9jhiHnk+hrNipXt5569kA8cLoPpS5TxopTqS7mqVQn4SY1fR41G2RfRhtmAt2xVUSbAtcsU+1pquSPBznMRQvmrGHdgDEFYfCb9ozVB7fDpnfVqesL6QslHDbqNvU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypo/uajS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypo/uajS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D2BC4CED6;
	Fri, 21 Feb 2025 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740158628;
	bh=gL377Afco2PQ71g8IKck7adfqy88v72fxv+lL5ROLBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ypo/uajSE4hPD0lxBvjB6Z1VaQcXdsGRDvv+GIYz1J1GeF/x+mpCymWyNe20Yp3Ka
	 0mrq/MNswAYdK6lLhzSSTx0TC4z4cs9Nik9fq++KOn8fyWpHPNtar+7RQOzotg/hKD
	 meVCdlRKBXBKP87I5Xq/GGyjBTUmq3ei0dhrDab/6AbDxhAqV8F1jsBLKZFKwoSy36
	 37mQERunQZZnLKY/joOEm0xcIRk8+Kikn4X5EIABwMNlEKdEvq2zxJP0A3KVEAL3sO
	 Jj1QwGYjJVeXlWz02IG9nQ+ecXDUcdUduDyh3swXj9XF74plNd1MUMzGF1IcHFxt+j
	 mJ9SvPsPJ+uLg==
Message-ID: <60914d20-36df-4128-a062-4f4e1030367a@kernel.org>
Date: Fri, 21 Feb 2025 18:23:47 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 8/9] mptcp: pm: drop get_local_id helpers
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
 <69747874cdc72593caadf51725cf8835bc45661b.1740019794.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <69747874cdc72593caadf51725cf8835bc45661b.1740019794.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/02/2025 03:57, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Now mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id()
> helpers can be dropped, and mptcp_pm_get_local_id() can directly invoke
> get_local_id() interface through "ops" of "msk->pm".
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c           | 6 +++---
>  net/mptcp/pm_netlink.c   | 4 ++--
>  net/mptcp/pm_userspace.c | 4 ++--
>  net/mptcp/protocol.h     | 4 ----
>  4 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d42aed440a0..d2cc93e21bee 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -438,10 +438,10 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  	skc_local.addr.id = 0;
>  	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
>  
> +	if (!msk->pm.ops || !msk->pm.ops->get_local_id)
Mmh, do we really need to check the "no pm ops" case? If we have to deal
with that, that might be annoying.

Should we not impose the implementation of get_local_id()?

> +		return -ENOTSUPP;
>  	mptcp_pm_param_set_contexts(&param, &skc_local, NULL);
> -	if (mptcp_pm_is_userspace(msk))
> -		return mptcp_userspace_pm_get_local_id(msk, &param);
> -	return mptcp_pm_nl_get_local_id(msk, &param);
> +	return msk->pm.ops->get_local_id(msk, &param);
>  }
>  
>  bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index e0f8754e261e..33b19ff7a313 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1139,8 +1139,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  	return err;
>  }
>  
> -int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
> -			     struct mptcp_pm_param *param)
> +static int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
> +				    struct mptcp_pm_param *param)
>  {
>  	struct mptcp_pm_addr_entry *skc = &param->entry;
>  	struct mptcp_pm_addr_entry *entry;
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6e51335c8bc1..b233d8469a48 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -130,8 +130,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
>  	return NULL;
>  }
>  
> -int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> -				    struct mptcp_pm_param *param)
> +static int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> +					   struct mptcp_pm_param *param)
>  {
>  	__be16 msk_sport =  ((struct inet_sock *)
>  			     inet_sk((struct sock *)msk))->inet_sport;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index cddb919fc120..d06add105df5 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1129,10 +1129,6 @@ void mptcp_pm_param_set_contexts(struct mptcp_pm_param *param,
>  				 const struct mptcp_pm_addr_entry *entry,
>  				 const struct mptcp_addr_info *addr);
>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> -int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
> -			     struct mptcp_pm_param *param);
> -int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> -				    struct mptcp_pm_param *param);
>  bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
>  bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
>  bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

