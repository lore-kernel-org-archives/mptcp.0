Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F441E480
	for <mptcp@lists.linux.dev>; Sat,  4 May 2024 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714867102; cv=none; b=mgprQbEw3/ZiVmuCTcfPQJhLWJQmDSIyQIA4zojLR5XC4UAvhocuptC6IcwlZckcB8iDpHAGtVpbb8oz0ai2iGD65Z8ZP04Z154iT0+Nkij2CtWl6ciBIQPYfopiXDY5j3ABKSdOSCU3IcbzpQZOYlBeiP/FUfF/s5XtunjfuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714867102; c=relaxed/simple;
	bh=kGBSs76zUQzYTp8FJN3lN/M/W5rnTG6REG7znt5zVII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFijodOCaCt3sxJ7Kp2ZhGggvA3DXaSTe8HL9V8B7GLrWC6Y5J4z+ClfPmVDgTjz00cE/ucTfSPHJsnZZ/zNU69TeRghNZBgdndJWZPF/774jmOR7AUbmz2bC5XQ79gIVMe/2mu7INNT9c0EWcwQX+aEWuaetFHx9KIt4vFuxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe4AFNwh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe4AFNwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178A1C072AA;
	Sat,  4 May 2024 23:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714867102;
	bh=kGBSs76zUQzYTp8FJN3lN/M/W5rnTG6REG7znt5zVII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pe4AFNwhg2cR68S3Bpubp8Qu5bnr3PsdUdHrksg2lOixdarZCgnsI+WJZbCZMTe6F
	 d04hJ4VLCIi1M4FKnEUoTf/HTprrohtzvov3znY4gHMz9RsaULACowILFidcbQTuDu
	 TSf8W5eyCM+/L4EDq6Ux657qMYRctI1u7TCC7Wkm4tsjZz/AzZt/bjQ3EGOZmnhx4q
	 dyGt33KUuIZJLRUfgLkpqvIsBHMVRFte5pl/FFoJVeTmiZ8HS2eX5P7y0Z3benZA8L
	 lNpJSOKn4PvQmphj9HiYiWxGZR9rc8wkXZ4FMY0Mg+zvOJf64TYVkvMRBtayBPyGlz
	 uV35hB6UzkDHQ==
Date: Sun, 5 May 2024 07:58:18 +0800
From: Geliang Tang <geliang@kernel.org>
To: Gregory Detal <gregory.detal@gmail.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: add bpf_mptcp_sched_ops" --
 fix bpf access
Message-ID: <ZjbLmo80HWM4YO70@T480>
References: <20240503-bpf_fix_access-v1-1-5a714318ea64@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-bpf_fix_access-v1-1-5a714318ea64@gmail.com>

Hi Gregory,

On Fri, May 03, 2024 at 07:33:25PM +0000, Gregory Detal wrote:
> The current behavior allows to write to mptcp_sock at offset that is
> defined in mptcp_subflow_context and vice versa.
> 
> This fixes this by splitting the checks for each struct type.
> 
> Signed-off-by: Gregory Detal <gregory.detal@gmail.com>

Thanks for this fix. Looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  net/mptcp/bpf.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 208e5d3f066f..57c47bb430b1 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -47,24 +47,32 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
>  	size_t end;
>  
>  	t = btf_type_by_id(reg->btf, reg->btf_id);
> -	if (t != mptcp_sock_type && t != mptcp_subflow_type) {
> -		bpf_log(log, "only access to mptcp sock or subflow is supported\n");
> -		return -EACCES;
> -	}
>  
> -	switch (off) {
> -	case offsetof(struct mptcp_sock, snd_burst):
> -		end = offsetofend(struct mptcp_sock, snd_burst);
> -		break;
> -	case offsetof(struct mptcp_subflow_context, scheduled):
> -		end = offsetofend(struct mptcp_subflow_context, scheduled);
> -		break;
> -	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
> -		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
> -		break;
> -	default:
> -		bpf_log(log, "no write support to %s at off %d\n",
> -			t == mptcp_sock_type ? "mptcp_sock" : "mptcp_subflow_context", off);
> +	if (t == mptcp_sock_type) {
> +		switch (off) {
> +		case offsetof(struct mptcp_sock, snd_burst):
> +			end = offsetofend(struct mptcp_sock, snd_burst);
> +			break;
> +		default:
> +			bpf_log(log, "no write support to mptcp_sock at off %d\n",
> +				off);
> +			return -EACCES;
> +		}
> +	} else if (t == mptcp_subflow_type) {
> +		switch (off) {
> +		case offsetof(struct mptcp_subflow_context, scheduled):
> +			end = offsetofend(struct mptcp_subflow_context, scheduled);
> +			break;
> +		case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
> +			end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
> +			break;
> +		default:
> +			bpf_log(log, "no write support to mptcp_subflow_context at off %d\n",
> +				off);
> +			return -EACCES;
> +		}
> +	} else {
> +		bpf_log(log, "only access to mptcp sock or subflow is supported\n");
>  		return -EACCES;
>  	}
>  
> 
> ---
> base-commit: 56030f9d3812071365435354c0eb5ffb3504e58a
> change-id: 20240503-bpf_fix_access-a360b88c1534
> 
> Best regards,
> -- 
> Gregory Detal <gregory.detal@gmail.com>
> 
