Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161233612C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122224; cv=none; b=YU8kKckYMfbHqYBmEAMyV6K+j/KZdpW1Jdx/g6eG9l3xVfAX1O8RvNe6eXpV2aGkttlqZUD8wXUSjKgafO7QzCXry77KrBvj0qVN56t5m9lpwv8sf4Sy/nRC3Y/bKBk/oM1lHlalX+h49UlfISjVZ/o3k5qLnr0+XobsFUdqQVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122224; c=relaxed/simple;
	bh=au8wjmSJvGzOCsnRP+7cayRsCPgG1I9tSE6CjS7RVfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdFgQKg9ufHgNhztCFYyp8ApaoSWUJD0GHDz6/Yk4Rs/TfXXYO6wIJhoaCBr+UoGzXpy+DzORia8Z4nCJzZP/oDy/+1kzotpAgQ5ihwe0kOSTLh7VMBYdxqKxXTrdKvLVfpd713PPZZOrWZg262r0IH2PoiSx6ZQcfGOQpR0Iu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYj2DVOl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYj2DVOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244BAC433C7;
	Wed, 28 Feb 2024 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709122223;
	bh=au8wjmSJvGzOCsnRP+7cayRsCPgG1I9tSE6CjS7RVfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uYj2DVOljIPdlihy6ISio6JGyyhHj/gq79TbSUCz1Wwpufp4Od/GKlZoJAkSTr9dr
	 jnn8WwR7pDHYd67/4y3B/1YTVZdvSx+xwt7pZyG1t1oFr+x9BZkeIpjML8BiAFbIaV
	 ATJf4MdTNZEcNMu8mJKQo1/025pQ/z1sw0JdEqR2nGK7Nj/2z++j8gRZAS4htt4VE0
	 l/vaVAkbYJ12N/gDh/6/oa3zFjhnMC2jgVzquC2uMpk7lokLiiUwEyPQ4ml7qOps4R
	 d48bZAkGoIT3mWrH2gJw7fMcRK5r/cl8iQO76BCpwT851UHbIC3BT0ZjS8xK+/R7ki
	 6bPOGd7oHWriw==
Message-ID: <f4923585-f34d-46ca-b5e4-9f306ba3fcab@kernel.org>
Date: Wed, 28 Feb 2024 13:10:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v6 6/9] selftests: mptcp: connect: print out
 ping tests info
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
 <e15cd3404da3211183979a3fa5e700cc97d2b770.1709105922.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e15cd3404da3211183979a3fa5e700cc97d2b770.1709105922.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 08:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> 'ping tests' shows in the test results of mptcp_connect.sh:
> 
> 1..68
> ok 1 - mptcp_connect: New MPTCP socket can be blocked via sysctl
> ok 2 - mptcp_connect: ping tests
> ok 3 - mptcp_connect: loopback v4: ns1 MPTCP -> ns1 (10.0.1.1:10000) MPTCP
> ok 4 - mptcp_connect: loopback v4: ns1 MPTCP -> ns1 (10.0.1.1:10001) TCP
> 
> But not in the test output of this script:
> 
> New MPTCP socket can be blocked via sysctl                         [ OK ]
> INFO: validating network environment with pings
> INFO: Using loss of 0.01% delay 30 ms reorder 94% 9% with delay 7ms on
> ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP   (duration    79ms) [ OK ]
> ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP     (duration    49ms) [ OK ]
> 
> This patch fixes this by adding ping tests in test output:
> 
> New MPTCP socket can be blocked via sysctl                         [ OK ]
> INFO: validating network environment with pings
> ping tests                                                         [ OK ]
> INFO: Using loss of 0.55%
> delay 36 ms reorder 97% 43% with delay 9ms on ns3eth4
> ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP   (duration    34ms) [ OK ]
> ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP     (duration    20ms) [ OK ]
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 7a53c8fb1783..bb0c7bf5b368 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -866,6 +866,9 @@ mptcp_lib_result_code "${ret}" "ping tests"
>  
>  stop_if_error "Could not even run ping tests"
>  
> +print_title "ping tests" 69

Same here: avoid passing '69' here. 'print_title' is certainly using the
wrong default value.

(and moved below as done in the Squash-to patch)

> +mptcp_lib_pr_ok
> +
>  [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
>  mptcp_lib_pr_info "Using loss of $tc_loss "
>  test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
