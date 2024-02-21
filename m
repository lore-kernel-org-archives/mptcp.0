Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83D8121F
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532325; cv=none; b=UPVlS1soVjG8NGOJbJIi4LqMyjDUAcYGotuPJ+WznyEzvDg94FhwFKYNAqtGywa9539PUXHu6bHxR+wnwp4RhwbbrCUUvTuOQIzT5daLA/68UOIm515U42lC3zgetDBBGdFurTOremDVH0fr0rCvdtYXbd8CV5P/ga3i03vktAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532325; c=relaxed/simple;
	bh=hIQZXZI62ECGrTPUSK54EdXtJpvcMSd5moO+6qJhglg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELwB0ouTs2/S2Z04Lyyjot2TFYIi1vj0NnYdsKUyIdEsbf9lx8cUd86PmRD0AJ/MxF7yEuJMBSICvWjx2AMS38zpyRT4S4g+il94Lx0V/SdPAEXeR/o2yyuuQRs4jEW4J1UIQifClWQOtfCSFMBc0YAbno3cutr+iYVUt5xg8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W95B24hq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W95B24hq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817BAC433F1;
	Wed, 21 Feb 2024 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532325;
	bh=hIQZXZI62ECGrTPUSK54EdXtJpvcMSd5moO+6qJhglg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W95B24hqCZiYzyOJtSCEXT63K6VvI+VNfaG2gJ+d39Oz9EF/lhvPCYXZ8/yEzAuZW
	 iUMcCeynRhpDCOTjbyMrGzPJT9KmJ74Elf8czE+eV6LxByHh0EH1QiLOFBajVgGamX
	 hQGKFeJZ3r4+OR4Gik6FbDitsy3pZG2M6Q/ZAPtGFsq23ltFYlp54nsOKF6aAF12PN
	 ghLuiZPvKW0+yS93JaSFvPcJebySlzZPAPfR1FIhspMpuQC0kNHm8MPHUuoIMF294S
	 Y1UqqXtp+cmd0zfks6nw/xpGJe9K7xrWsOVFzogRdxd4lMQxK/1+oHhkeeDGx+5tx1
	 AZ+zaEcKp/a+g==
Message-ID: <a716b4b3-c826-4d2c-825c-5f902baa9682@kernel.org>
Date: Wed, 21 Feb 2024 17:18:44 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 4/8] mptcp: set error messages for set_flags
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
 <c8d6e3ae6b110da7d115b720825758708c9a7687.1708497039.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c8d6e3ae6b110da7d115b720825758708c9a7687.1708497039.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/02/2024 7:31 am, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In addition to returning the error value, this patch also sets an error
> messages with GENL_SET_ERR_MSG or NL_SET_ERR_MSG_ATTR both for pm_netlink.c
> and pm_userspace.c.

Good idea!

Even if it might be obvious, please *always* explain the reason(s) why
having this is interesting. Here, just one sentence is enough:

  It will help the userspace to identify the issue.

(same for other patches in general: please *always* add the reason(s))

(...)

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 7ef3b69852f0..09a60f440fef 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -563,13 +563,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	token_val = nla_get_u32(token);
>  
>  	msk = mptcp_token_get_sock(net, token_val);
> -	if (!msk)
> +	if (!msk) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
>  		return ret;
> +	}
>  
>  	sk = (struct sock *)msk;
>  
> -	if (!mptcp_pm_is_userspace(msk))
> +	if (!mptcp_pm_is_userspace(msk)) {
> +		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");

Maybe just "userspace PM not selected"?

>  		goto set_flags_err;
> +	}
>  
>  	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
>  	if (ret < 0)
> @@ -583,6 +587,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
>  
>  	if (loc.addr.family == AF_UNSPEC ||
>  	    rem.addr.family == AF_UNSPEC) {
> +		GENL_SET_ERR_MSG(info, "address families do not match");

Maybe better with this?

  "invalid address families"

>  		ret = -EINVAL;
>  		goto set_flags_err;
>  	}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
