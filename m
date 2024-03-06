Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3855FBB7
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722013; cv=none; b=G706SjhNnluwQAYJZtlov+uxuAGlNYvPUW2bLvGDNcLyT/Q3FHqQWK2unbFIHFMde5r5deOJXNmZ+zFNMPH2T1tcezF5NdN0goxONHTlZDteAnvubUHm0krAvOl0Ll/GOvdhF6RUUgjhxuWyUDqrAWZNVX4eEqe1ciXq8B5p90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722013; c=relaxed/simple;
	bh=C2/DuUeD1SQphk5wFK8NxIqFT7ZNwAopsEJlfPwb06k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRA7OvnevUVnoGFvbM41RiNc3iYysHC9nS3R13TeILkYQNXqT/vG5T6rTw5H63f4v8lAH34M33Z7rvnqm7yCKWOYY6Nw81HT9XrO+DTjNsAs4GZgu+kjOSRCT4o50nf6BCpPhEaDr20jnzYBO3EK235gQWFoDx+INnRgloby+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVSWFz+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVSWFz+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F25C433C7;
	Wed,  6 Mar 2024 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722013;
	bh=C2/DuUeD1SQphk5wFK8NxIqFT7ZNwAopsEJlfPwb06k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WVSWFz+fyla+792CLBf+Gwv/74VKJwpryV82kUE6JvQLzjqTd5WnhQYT66DZqtMwm
	 kIKhsYFoq3yQzmqEx3eI9g0pJ/SZZ71m9a1o7Z4uUv8vQvROwHFv817ywqZGeZ19se
	 48e3vf8RGRmy9HXwphrGupb5K1klcxm1UKLbQN8Ux1PAsL3xSbweXQpTkjGW8i34X4
	 Lot/ieX/lp25tZvdGu3twrP2Ehu503M87tsbCC865SlCb1B3UxXI9gDtcvd2T+ClCu
	 IQD69mJb6ubJaZg4LcRGwtsBXJEefjJn6sJn0tysIqW1PZiqnSCPVk2cIxSXZCLeiA
	 V1h8TkLfbmxXA==
Message-ID: <1d3f25b3-1fc1-45ee-b712-b910f3828f3f@kernel.org>
Date: Wed, 6 Mar 2024 11:46:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iperf3 v2] add MPTCPv1 support
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <487902825fa971916541b59e43ed25c7525b60e0.1709695652.git.geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <487902825fa971916541b59e43ed25c7525b60e0.1709695652.git.geliang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

(Without the iperf3 maintainer in CC)

On 06/03/2024 04:28, Geliang Tang wrote:
> The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in the
> upstream Linux kernel since v5.16.

since v5.6, not v5.16

> MPTCP is strongly tied to TCP, and the kernel APIs are almost the same.
> The only required dependency is the 'IPPROTO_MPTCP' protocol number
> definition, which should be provided by the netinet/in.h header.

Maybe add "if it is recent enough)

> This patch adds a new flag --mptcp to support MPTCPv1. It can be used
> like this:
> 
>  > iperf3 --mptcp -s
>  > iperf3 --mptcp -c 127.0.0.1
> 
> There is no need to check for IPPROTO_MPTCP support in configure.ac at
> build time, it is at runtime we will see if the kernel being use supports
> or not MPTCP.
> 
> If IPPROTO_MPTCP is not supported by the kernel being tested, it is
> normal to fail because the feature is not available.

(and the user explicitly asked to use MPTCP.)

> Linked: https://github.com/esnet/iperf/pull/1166

Thank you for the new version!

The code looks good to me, but that's up to the IPerf maintainers to
accept it or not.

I guess the new patches should be proposed via a new GitHub pull
request. Do you mind opening a new one, and mentioning it is replacing
the one from Paolo and https://github.com/esnet/iperf/pull/1615 (just a
rebase from what I understood)

> Suggested-by: Paolo Abeni <pabeni@redhat.com>

Co-developed-by maybe?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
