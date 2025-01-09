Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3E192D66
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444349; cv=none; b=WDfuNKmRstojZLuNR1fit/3oOwjQbjBovnuCwZm1vXC6kWpMuiTEVevO5Wq+q/jECrcTk0FoLlUqmgCKS7dX1P0RufZ/OBYNBVyjTVvrLNBL2Y/pyXjW7pkbsvfms1XkU1kBPp6HD4urDZ1UilpadNB6AytL+JAG2JiS6GjUGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444349; c=relaxed/simple;
	bh=L8Pt3OOExHMBTdKMo4uGbp+BDMO9F6GoW7j+RpXWh9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdYtJZSLdZz+MU0FKEHq1ebJtbfjr0f71GAM9tCgFhpRhBGvow/SYq2xkbIAk8ZzuhaWDbuHnezi6G++FlkpYjORtCjeSp+koYVxuylX9lkrwaxUI6Hrje20cCV5QSECAtrsUyARPEvdg7kvKv4mBYt4lxrxx7ZCeTD5EeHktCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtAUrBor; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtAUrBor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7993C4CED3;
	Thu,  9 Jan 2025 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736444349;
	bh=L8Pt3OOExHMBTdKMo4uGbp+BDMO9F6GoW7j+RpXWh9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VtAUrBoryPcBoiNdzzaEV0vdeJOtBrcak60s4jZZbmQN4QktCmmRDEgDWIuethVHW
	 LhNvWzDeSsRhEC81238te+1d2fUWtkje9nrzItI6aQM4WrMQ8WnKY+/fA1vKrs2573
	 9Vj6YKBwCvTjpMWBOmA7gBb6Xlqf8OSJJBXRdazUt/JDL9w9h9lt6cwgrYDZQvL4Z0
	 hO2vglAaUuCcpU0CRlCxr9m0ofLq7EJFgWpuMbBb/akkRsWkJBHfsucAohsyLP6s23
	 K5bPX2BzTF4MhymZchCqkzgVOCq4ViMngaF0xvoqeRaM8AXbHWJlLW68/8F6KUWWVK
	 Llh1kWv0mw0FQ==
Message-ID: <4665ba1f-fec0-4355-a639-0ce02b8ad95f@kernel.org>
Date: Thu, 9 Jan 2025 18:39:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 3/3] selftests: mptcp: add a testcase for invalid addr
 timeout
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <tencent_FF589D3CCA6CB1BB13DCD53D469928F3610A@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_FF589D3CCA6CB1BB13DCD53D469928F3610A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang

On 09/01/2025 14:32, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch adds a timeout testcase, which includes a invalid address
> within the same LAN, along with another valid address. The invalid
> address in the LAN triggers a TCP error, leading to an incorrect
> increment of 'add_addr_accepted'. This test ensures the valid address
> can still join in this situation.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 6b0705d10840..80ce8daac2a8 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2318,6 +2318,20 @@ add_addr_timeout_tests()
>  			chk_join_nr 1 1 1
>  		chk_add_nr 8 0
>  	fi
> +
> +	# signal invalid LAN addresses, which will cause an error at TCP level
> +	if reset_with_add_addr_timeout "invalid LAN address, ADD_ADDR timeout"; then
> +		pm_nl_set_limits $ns1 2 2
> +		pm_nl_add_endpoint $ns1 10.0.1.3 flags signal

Please add a comment that 10.0.1.3 is invalid: it doesn't look like one
when you look at it.

> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_set_limits $ns2 2 2

Should you not put the limit to 1 accepted add_addr? With 2, it should
be able to connect even without the patch, no?

(or that's maybe what I didn't get with the double increment?)

> +
> +		speed=10 \
> +			run_tests $ns1 $ns2 10.0.1.1
> +		join_syn_tx=+2 \

Is the '+' needed because there might be some retransmissions? Can you
not prevent them somehow? e.g. by setting a different sysctl knob? If
yes, it is more reliable, and the previous patch is not needed.

> +			chk_join_nr 1 1 1
> +		chk_add_nr 8 0
> +	fi
>  }
>  
>  remove_tests()

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

