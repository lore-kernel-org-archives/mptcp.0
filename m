Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074D2505CE
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158607; cv=none; b=s9D6ihSkvOivllw+vWHeMkLum/2d4j1VOrDkEfH5R0aRgGyfB5OvRu2OspwMqL7Lvw4FEGTrOYf1Xn4O1EghodvorGpjbWIEaycWuXciCq+UF/l0gjxmxvRUQziT+RTA3qsvAx/ReO64IgMZl56dL6LIWWfR6sxpAGkt06BZTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158607; c=relaxed/simple;
	bh=LM4dHPWcoBYUntMG6Aw7n0QTFV4jpvRo2GXU8tT3++0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGFjJX2FPrR6cGlkBOyuu7K3GTb/I5BhLTUDT4hrRM6ebek5YmLySiqHkeKYpx6+/XxdYM0LwX3Ra4GQUBBuCrLCi8EFcYLoShmDcmtPzdoCMBQG8GxwixHF1buAnomTwlOlaaGNDVBATJGkZhHgSEu4EeheNb1Zoei0x4PnoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhg7B72o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhg7B72o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE8EC4CED6;
	Fri, 21 Feb 2025 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740158607;
	bh=LM4dHPWcoBYUntMG6Aw7n0QTFV4jpvRo2GXU8tT3++0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bhg7B72oOkmjN2lmrxs3SDwenjb8DIqjuVYJFKoHus7T2CJK+qKeT1duAdZO4iRdV
	 LxAl5JJ7uHravH+q+q/7B6EWP+aiEcLN5rql6sq6rcSCUHfPWDFpyMzFIi9qEeJDlD
	 mMuF93qydfO4vKxDX7h6Hsg1mboQNJcx4jMsZllIV2oWYhjf1DkfSpV+YNMWEmXPkb
	 l8af4ZaHqVKLZ01wNU1W4vu9RDavsn1azAgjoPNQTxkPnGV62LYbi79DacOiz1Ad3S
	 MJgq6W3YCfRM3If3EBd1ye+I4vASW64hIcS8jVZ2bRljcWIL27q1lKGYNS16bHt5Fp
	 yZCAcXgGuSe6Q==
Message-ID: <9f7ee817-529f-4382-bc53-6a6d6e532e49@kernel.org>
Date: Fri, 21 Feb 2025 18:23:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 2/9] mptcp: pm: add struct mptcp_pm_param
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
 <2f68d8851458f6f5acfd9a6ea549f3b73029d4bc.1740019794.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2f68d8851458f6f5acfd9a6ea549f3b73029d4bc.1740019794.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/02/2025 03:57, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Generally, in the path manager interfaces, the local address is defined
> as an mptcp_pm_addr_entry type address, while the remote address is
> defined as an mptcp_addr_info type one:
> 
>     (struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)
> 
> In order to make these interfaces more flexible and extensible, a struct
> mptcp_pm_param is defined here to pass parameters. "entry" can be used
> as the local address entry, and "addr" can be used as the remote address.

Mmh, it is not clear to me why you cannot use only the parameters that
are needed per interfaces, e.g. "local" and "remote". These parameters
are not even always needed, e.g. when an address has been announced,
"remote" doesn't make sense here. Same for get_local_id and
get_priority. Similarly, when an address has been removed, only the ID
is needed for the PM, etc.

I'm not convinced by the "flexible and extensible" reasons for the
future: "local" and "remote" will likely not change. If we want to add
more parameters, will we require them for all interfaces?

Also, if you use similar signatures as the ones being used, no need to
do many changes in the current in-kernel and userspace PM, e.g. no need
to introduce the new helpers in patches 5 and 6. Instead, these patches
could directly set the available helpers, and we can reduce the number
of patches, e.g. patches 8 and 9 (and more) could all come in one, no?

Plus, it feels strange to copy data from one structure to another just
to pass parameters, no?

Are you sure we need this patch? (and the next one?)

> Also add a new helper mptcp_pm_param_set_contexts() to set a struct
> mptcp_pm_param type parameter.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h  | 13 +++++++++++++
>  net/mptcp/pm.c       | 10 ++++++++++
>  net/mptcp/protocol.h | 11 +++--------
>  3 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 72d6e6597add..a41d6c74760f 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -121,6 +121,19 @@ struct mptcp_sched_ops {
>  	void (*release)(struct mptcp_sock *msk);
>  } ____cacheline_aligned_in_smp;
>  
> +struct mptcp_pm_addr_entry {
> +	struct list_head	list;
> +	struct mptcp_addr_info	addr;
> +	u8			flags;
> +	int			ifindex;
> +	struct socket		*lsk;
> +};
> +
> +struct mptcp_pm_param {
> +	struct mptcp_pm_addr_entry	entry;
> +	struct mptcp_addr_info		addr;
If this structure is really needed, it seems clearer to use "local" and
"remote" instead of "entry" and "addr".

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

