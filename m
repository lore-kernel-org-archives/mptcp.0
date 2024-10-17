Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3F1D27A6
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162137; cv=none; b=YePLmm3ZO+aa7UckAseBnq0z7o7/uDsgNnKKDX98iYP6d0OVFYLZfs96OHUjWQmwgvK8cVRuD9mTjZWwuwyW3LVdJQg6AzaLbs7LGYczSXcn8F9Ni+UKG5kVuCG7y4Elc38ZzvF0MRj/Zw4y/1WuhnVm5cEEvR6UPfpQGyDbcLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162137; c=relaxed/simple;
	bh=P2e3gLxOYJ7QHPjx4/8bqZnN5wN8X7+IAhqPJsVR660=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qxZ7X/FLzPOIUxF2GYDyzUeihnUHMKtWEefv7U4Dspz3sKY2G0J7OJyQC8/E1p+khVhigS7Cm9CjiN49OwGJvId3McSwc8wpu1vmxA6PuTzJ8IapWdpSYR9RR8wxr8Tuxn4tN/TP9c9NYKCojN6uylxC75JqUIQPjSqZbpLBMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxz8BJfu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxz8BJfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788B2C4CEC3;
	Thu, 17 Oct 2024 10:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729162137;
	bh=P2e3gLxOYJ7QHPjx4/8bqZnN5wN8X7+IAhqPJsVR660=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=Mxz8BJfuLFBxcdVKXmlLA06DLCDmLg/PjViiKXY9Dd4QIRMg3Sg79PU7NWtX6FuEE
	 KhFpDyd3VYeK/l6CV1sO1DuyOvH9YHOAnIUagkedEhwcO3ukeYow1vZb8hEPqLWV2C
	 EG+gt7ztye3oxtjJe+MvbF4B/2g/+a+Bx/1aqCfv3aOhHM0ZAnCCiQ8mQKRbSltJ4x
	 csCpSRKxziR8RgBlM1lSmHindbKZ8wSpUtN5az+qu9u9O9IdRGoDuXAkRrHiYk27q/
	 NNLmXu82NnlwrND4bS74D5hRE1/RcE+RnHuJw6AE7bcG3fQrCf0edEUcIlynwYELXo
	 B9hOczc4uQGqA==
Message-ID: <79bc45a2-452f-447d-96b3-187c45e15d26@kernel.org>
Date: Thu, 17 Oct 2024 12:48:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2] tools: ynl-gen: use big-endian netlink
 attribute types
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>
References: <20241017094704.3222173-1-ast@fiberby.net>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20241017094704.3222173-1-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Davide,

On 17/10/2024 11:47, Asbjørn Sloth Tønnesen wrote:
> Change ynl-gen-c.py to use NLA_BE16 and NLA_BE32 types to represent
> big-endian u16 and u32 ynl types.
> 
> Doing this enables those attributes to have range checks applied, as
> the validator will then convert to host endianness prior to validation.
> 
> The autogenerated kernel/uapi code have been regenerated by running:
>   ./tools/net/ynl/ynl-regen.sh -f
> 
> This changes the policy types of the following attributes:
> 
>   FOU_ATTR_PORT (NLA_U16 -> NLA_BE16)
>   FOU_ATTR_PEER_PORT (NLA_U16 -> NLA_BE16)
>     These two are used with nla_get_be16/nla_put_be16().
> 
>   MPTCP_PM_ADDR_ATTR_ADDR4 (NLA_U32 -> NLA_BE32)
>     This one is used with nla_get_in_addr/nla_put_in_addr(),
>     which uses nla_get_be32/nla_put_be32().

This modification looks good to me, but just in case, do you mind having
a quick look, and eventually send your Acked-by, please? :)

(...)

> diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
> index c30a2a90a192..5a6b2b4510d3 100644
> --- a/net/mptcp/mptcp_pm_gen.c
> +++ b/net/mptcp/mptcp_pm_gen.c
> @@ -14,7 +14,7 @@
>  const struct nla_policy mptcp_pm_address_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
>  	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
>  	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
> -	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
> +	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_BE32, },
>  	[MPTCP_PM_ADDR_ATTR_ADDR6] = NLA_POLICY_EXACT_LEN(16),
>  	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
>  	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

