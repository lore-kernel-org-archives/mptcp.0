Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36EA1E502
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396223; cv=none; b=X4+fOOGRwlHJ6UNwfNgzKm1ybGRTsQPgVDhV3VS6oDKX4Nhp6JkXEUve+4ifynLUqIFh5gaTN2GZWK+tmHAZDaadTqIIBdtS9CgCKum6hL/A8l3rMTi8suayKmW1zyFSVUfR6no3lj4lsssOinmQcpSf/cnelyj+/7yKMnnRX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396223; c=relaxed/simple;
	bh=qcvcS+1LhRHL23qPF/ns7QyeONBgggyPLrzT0Vi+fWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=buSkuK6OW1aiifLYAgGq0CynX9sj8coR44b/k1mO9Rd6VK0IfciHoBDYHXT+YyFfN6edxA6eso9A0CF5IjWDzVyCaoWgpIaJDbs3Fm+gUu/NxkmOMiWmUV1a0vmmLknumVRK6zUuCsna9uK4SJOOIpCDeKAC5UIVs7aHGDeOqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdiaugO6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdiaugO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E1BC4CEEB;
	Thu, 28 Aug 2025 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756396222;
	bh=qcvcS+1LhRHL23qPF/ns7QyeONBgggyPLrzT0Vi+fWU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QdiaugO6UA5apDJGYOSE5rWDJy3QpsGFX4IrnSszz2ZYRzU7le3ztOEFWsRHI8xRN
	 Ebvr1ah2FOEDK/cv54qCt0gPo31WC/ItzHiETaNHGfrAwn93p2fFRrdKLW8OJwJJJV
	 0DVCqjC+4W4XTT3U3xTSMu/toCfXos20zGgmrzBh9HmRB92yjG92FpqwCbbPiPP0kl
	 NtFUBQI3NkPdlmE6O1VjPjTAqVLf3qw11EsFT5D2qUij4o6JlecfopZlA26NZjy5fM
	 wXnk4pA4csnBXwTYY/ccFRU2BkVHGGcr8z62ScG8DUNx5bXlck7If89V5wg+VyrGbf
	 yKIKaUjxtGODQ==
Message-ID: <1d98d911-34a7-42cd-b963-26eede462547@kernel.org>
Date: Thu, 28 Aug 2025 17:50:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 1/2] net: Add rfs_needed() helper
Content-Language: en-GB, fr-BE
To: cpaasch@openai.com, MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20250825-b4-mptcp_perf-v2-0-5d2d68dfa8af@openai.com>
 <20250825-b4-mptcp_perf-v2-1-5d2d68dfa8af@openai.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250825-b4-mptcp_perf-v2-1-5d2d68dfa8af@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 26/08/2025 06:30, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> Add a helper to check if RFS is needed or not. Allows to make the code a
> bit cleaner and the next patch to have MPTCP use this helper to decide
> whether or not to iterate over the subflows.
> 
> tun_flow_update() was calling sock_rps_record_flow_hash() regardless of
> the state of rfs_needed. This was not really a bug as sock_flow_table
> simply ends up being NULL and thus everything will be fine.
> This commit here thus also implicitly makes tun_flow_update() respect
> the state of rfs_needed.

Thank you for having added this new helper!

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  include/net/rps.h | 85 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 29 deletions(-)
> 
> diff --git a/include/net/rps.h b/include/net/rps.h
> index d8ab3a08bcc4882e2ad9c84c22ef26b254c14680..a89d2822a257a1fcf54e9722fdc22d01c28cc87b 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h

(...)
> @@ -144,6 +132,45 @@ static inline void sock_rps_delete_flow(const struct sock *sk)
>  			WRITE_ONCE(table->ents[index], RPS_NO_CPU);
>  	}
>  	rcu_read_unlock();
> +}
> +#endif /* CONFIG_RPS */
> +
> +static inline bool rfs_is_needed(void)
> +{
> +#ifdef CONFIG_RPS
> +	return static_branch_unlikely(&rfs_needed);
> +#else
> +	return false;
> +#endif

It looks strange to see all these #ifdef/#else inside the functions,
instead of "empty" functions at the end when CONFIG_RPS is not defined
as it is usually being done. But I see you are following what is
currently being done in this file, so all good!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

