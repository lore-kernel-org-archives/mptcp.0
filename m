Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F8A35952
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152713; cv=none; b=HbbXsugaolCvRDTgqS0Sgyu35z4t0OZUg7Me72lDZbGLpTXcMxhlPnnJlWZ1PcPAtC4a4ek7cKSOQbQiP27pCrqqGZwqVeS9glctJSE97Vy+EH75f8wDEYUv5MDKgVhDdLNfGxTflkwdyU9HPlKhm6hPtq2EHiUgIg5vD2rFTg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152713; c=relaxed/simple;
	bh=GvVpxqJZagIaB3XOxgLf9YF0iL6R8XREHrgoKcgrx8A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UQpMvnaFeOGpt9xJbgxpbyglMHQOKbCR9oPRMavgAP4z/Dxjk9vbcVd7eCI5Dm+F/sPSyuCm3c3bx8DRgRLeGvMtIaH8kPnwEWyg844AtoPr6UhSxtoA1wBOqqtF49nss86X8tMmPDinOgZ74UIpDOGGfxxWbo1Ity3BdHFGqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB0MoMb1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB0MoMb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025EC4CED2;
	Mon,  6 Jan 2025 08:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736152713;
	bh=GvVpxqJZagIaB3XOxgLf9YF0iL6R8XREHrgoKcgrx8A=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=bB0MoMb1KHP3mj1n9HQ4SNivMykW39AXcks5pL+YCXTyg97STEWZzQ1undjyjVSk5
	 KeNzBabcHjISPbUSCIAou5HBKFKqT2Nr5SOlM78Z5UBuTG5ielrxUcJOYFL55fjvwZ
	 3vA/GXFitPT8QtPGyJgWXgQwtr9k99W6QwrEKHgVN0lCToLy8zcMzOiFomcZnv7UYM
	 ug++jvHOXTlOPZglynOjWnje9qodv66GWb8f3pha5+VEh8SrCNxrf3IsJw6LxTpcuD
	 PdOdV8zbiHh+UPZ+MQWkgmBgbJKXkkydKHgBgzFSVaQD5SEb51HFuvB6Ax4C4/XCVr
	 1sjvDhxOfHcNw==
Message-ID: <0152caf3be99da2fe96a6d5e8a672b3ee18f19c7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 2/7] mptcp: pm: more precise error messages
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 06 Jan 2025 16:38:29 +0800
In-Reply-To: <20241230-genl_req_attr_check-v6-2-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
	 <20241230-genl_req_attr_check-v6-2-3ec9103559e7@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-12-30 at 14:24 +0100, Matthieu Baerts (NGI0) wrote:
> Some errors reported by the userspace PM were vague: "this or that is
> invalid".
> 
> It is easier for the userspace to know which part is wrong, instead
> of
> having to guess that.
> 
> By splitting some error messages, NL_SET_ERR_MSG_ATTR() can be used
> instead of GENL_SET_ERR_MSG() in order to give an additional hint to
> the
> userspace developers about which attribute is wrong.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_userspace.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index
> 72d4861e497eef5a516fc1c3ec1659807ffedd53..9c0bec588c498e0aa78acf4018d
> b509abe90cad2 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -224,9 +224,14 @@ int mptcp_pm_nl_announce_doit(struct sk_buff
> *skb, struct genl_info *info)
>  		goto announce_err;
>  	}
>  
> -	if (addr_val.addr.id == 0 || !(addr_val.flags &
> MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, addr,
> -				    "invalid addr id or flags");
> +	if (addr_val.addr.id == 0) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid
> addr id");
> +		err = -EINVAL;
> +		goto announce_err;
> +	}
> +
> +	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid
> addr flags");
>  		err = -EINVAL;
>  		goto announce_err;
>  	}
> @@ -537,8 +542,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct
> sk_buff *skb, struct genl_info *info
>  		goto destroy_err;
>  	}
>  
> -	if (!addr_l.addr.port || !addr_r.port) {
> -		GENL_SET_ERR_MSG(info, "missing local or remote
> port");
> +	if (!addr_l.addr.port) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing
> local port");
> +		err = -EINVAL;
> +		goto destroy_err;
> +	}
> +
> +	if (!addr_r.port) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "missing
> remote port");
>  		err = -EINVAL;
>  		goto destroy_err;
>  	}
> @@ -592,9 +603,16 @@ int mptcp_userspace_pm_set_flags(struct sk_buff
> *skb, struct genl_info *info)
>  			goto set_flags_err;
>  	}
>  
> -	if (loc.addr.family == AF_UNSPEC ||
> -	    rem.addr.family == AF_UNSPEC) {
> -		GENL_SET_ERR_MSG(info, "invalid address families");
> +	if (loc.addr.family == AF_UNSPEC) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +				    "invalid local address family");
> +		ret = -EINVAL;
> +		goto set_flags_err;
> +	}
> +
> +	if (rem.addr.family == AF_UNSPEC) {

I moved this check into "if (attr_rem) {" block in v7.

> +		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
> +				    "invalid remote address
> family");
>  		ret = -EINVAL;
>  		goto set_flags_err;
>  	}
> 

