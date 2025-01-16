Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CA78F2B
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044974; cv=none; b=nSF6/dfyLeJtGSUx3w9gDPcCCW/iifzHmqZOxPOHcXKYM1y2WsPTgdluHRB0gJdnhZo1DC+sT6Q4DpB4wVOEAFd8XiiiASWISCUauMJ4W1njVcAwkBuHpvCK3gb4xa41yWO1Zaw/UOrs9bz3w8nTZSmUafytxAGNnxqnuLod11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044974; c=relaxed/simple;
	bh=Q4I/VKMOndqEib53EtOgc/vucSqT4KwEzQCMR9VrDe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqAdODU5YZPRz8Cl7iKvAfQXNLY7o7M91zP2HqczzXrJ9P1xFNneDRVwKic0SEQL6+IJu3hygE3apzY4PKjC8iXci9/4MHdPkSuCZcsCLB94Y6rUWkBG1Ei3fPbMOMyqW4oWoTC8KHfsjF12Ozfj0ShlU4HKZJTQNuE0KZSE7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcgJmqv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcgJmqv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81814C4CED6;
	Thu, 16 Jan 2025 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737044974;
	bh=Q4I/VKMOndqEib53EtOgc/vucSqT4KwEzQCMR9VrDe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fcgJmqv6EjoGkAnSwAjfKJEIWeSpkZ+1gVJJaIOl2qs9C8YbGuDkEV+4JvIaKBMYj
	 zcwWVeh7GJe7zBCVb5nPe/LAQhO/fdI5VokN9u7zvHlyCMhnzIj7/yFPAxZLJRxENq
	 b6Vbz8ybsLZFLWuL5pn7pMCehT1k3lrIlY2vyRMCHX41+Xm4Ql4x9MZTACZ0bcsWNE
	 y5facqGiaHgm/fr+BCROw4ufwtNJNoF+gV1B5svXT4dKIjOJSCvGJpmb4UDW4A+Y5c
	 2/nxniDAy41C9wrR8CPZOkEriCVGRsvdNVc1uVxMK6DRIQQK6BdykB0xcCscrP68lg
	 KJKdbBpa/+k2w==
Message-ID: <b5a01f30-3e9d-4ae7-97d1-0efec4e87ed1@kernel.org>
Date: Thu, 16 Jan 2025 17:29:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] selftests: mptcp: Fix incorrect file descriptor check
 in main_loop
Content-Language: en-GB
To: Cong Liu <liucong2@kylinos.cn>
Cc: mptcp@lists.linux.dev
References: <5e2058ea-2292-4403-a7b9-ace4b21dc9c1@kernel.org>
 <20250116085459.31419-1-liucong2@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250116085459.31419-1-liucong2@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Cong Liu,

(-Cc everybody, except the MPTCP ML)

Thank you for the v2.

On 16/01/2025 09:54, Cong Liu wrote:
> Fix a bug where the code was checking the wrong file descriptor
> when opening the input file. The code was checking 'fd' instead
> of 'fd_in', which could lead to incorrect error handling.
> 
> Fixes: ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener")

I think the first issue has been introduced in 05be5e273c84 ("selftests:
mptcp: add disconnect tests"), then in the one you mentioned. Because it
is just in the selftests, feel free to add the older one, or both.

> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 4209b9569039..31f4c5618569 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1249,7 +1249,7 @@ int main_loop(void)
>  
>  	if (cfg_input && cfg_sockopt_types.mptfo) {
>  		fd_in = open(cfg_input, O_RDONLY);
> -		if (fd < 0)
> +		if (fd_in < 0)
>  			xerror("can't open %s:%d", cfg_input, errno);
>  	}
>  
> @@ -1272,7 +1272,7 @@ int main_loop(void)
>  
>  	if (cfg_input && !cfg_sockopt_types.mptfo) {
>  		fd_in = open(cfg_input, O_RDONLY);
> -		if (fd < 0)
> +		if (fd_in < 0)
>  			xerror("can't open %s:%d", cfg_input, errno);
>  	}

The CI is not able to apply your patch. On which base are you?
Do you mind using our 'export' branch from our GitHub repository?

> When I tried to solve the problem where fd_in was closed in the again
> code block but not reopened in certain scenarios, I encountered some 
> issues. Here's my code, but it causes the disconnect test to fail and I'm
> not sure how to fix this. 

Some fixes have been recently applied around the 'disconnect' tests,
maybe this issue has already been fixed?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

