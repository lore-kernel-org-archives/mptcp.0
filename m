Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390453E2E
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355671; cv=none; b=kMu0Bx8l0gY691/tl0OMiFK08B1Yn6VwLKWr4IJYzq/D4wbJf/EnSnPEq8wl5i5E6TNJ1i7QDAPgXhD0/A5xhuj6QVzG51HiwUfbVHoRzLdYMZA8mRcjDdusJqvAQllrzj/ZkwBaS6t2FLq4s72+Lu3zcGTKqUzSb8BrZ6fOhD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355671; c=relaxed/simple;
	bh=ZB/xU3byNwiQxgm0AstExry5ARQcjT6DlAWFJZ2xc1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBYgeaynOipEa0SOJvU01CFNW2IkpcBzblmNcMyvX8a7P4DLz/XHNNCxuVj9OlLYmBQOhbJgshJkwGoVY8FOso1vHkQahUOwalaDpSM8rMAWX51y9/n23D4a/wJcjftZTwgrEwAAURrXFuLPnqI8Wj4TlEd7U3jY0wsrKUwzaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt5K7GjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt5K7GjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C34CC433C7;
	Wed, 13 Mar 2024 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710355670;
	bh=ZB/xU3byNwiQxgm0AstExry5ARQcjT6DlAWFJZ2xc1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tt5K7GjEeQCoSv5RbdSx7LmMPqGLnVP2XnRiWOqGlIzeQRsplbSlw7aLBluCyhqfy
	 OzuQBUBA0/HRovddGuG9CoMXpl0lfXnx7iHT59mdO4Kf26TBzL6LP2w+3Zd8FTKvYE
	 sfrwATIyCnJSOCA/9FfQnxm1/2DxGsntxh88FxLAEkLWyatvIWQcNd5MX46a0WZVKl
	 DJ+ITgEFm4FqUFLna4VKBgYKaS38uqgu9pWcGt2kZs6De0BvE2rgp0lXZRi492za9A
	 Td/FwI7PgNixOUF5XAELoJuXsFOJG1AaKuGgn2MJoQBtzDuBIu/KVhvlGDs/WTh48N
	 piEfY7h2d+ADg==
Message-ID: <18d67bad-8898-4920-9f6c-2b306046b291@kernel.org>
Date: Wed, 13 Mar 2024 19:47:47 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 02/10] selftests: mptcp: get support for limits
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
 <fe6ee65c22c22e0b2da067841a4226cf8093948a.1710121590.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fe6ee65c22c22e0b2da067841a4226cf8093948a.1710121590.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 11/03/2024 02:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> There's only 'set limits' ability in pm_nl_set_limits(), this patch adds
> 'get limits' support for it as well to show the limits, and rename it as
> pm_nl_limits(). Then pm_nl_set_limits() can be a wrapper of it. Also add
> another wrapper pm_nl_get_limits() to get limits.
> 
> Usage:
>         Set limits - pm_nl_set_limits $ns $addrs $subflows
>         Get limits - pm_nl_get_limits $ns
> 
> A test for 'get limits' is added in endpoint_tests().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 7fd32f645650..8eb5cf54ea42 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -603,19 +603,34 @@ kill_events_pids()
>  	evts_ns2_pid=0
>  }
>  
> -pm_nl_set_limits()
> +pm_nl_limits()
>  {
>  	local ns=$1
>  	local addrs=$2
>  	local subflows=$3
>  
>  	if mptcp_lib_is_ip_mptcp; then
> -		ip -n $ns mptcp limits set add_addr_accepted $addrs subflows $subflows
> +		local limits="limits"
> +
> +		if [ -n "$addrs" ] && [ -n "$subflows" ]; then
> +			limits+=" set add_addr_accepted $addrs subflows $subflows"
> +		fi
> +		ip -n $ns mptcp $limits
>  	else
>  		ip netns exec $ns ./pm_nl_ctl limits $addrs $subflows
>  	fi
>  }
>  
> +pm_nl_set_limits()
> +{
> +	pm_nl_limits "${@}"
> +}
> +
> +pm_nl_get_limits()
> +{
> +	pm_nl_limits "${@}"

Even if it is explained in the commit message, I find it confusing.

Is it not clearer to have dedicated functions for such simple helpers?

  pm_nl_get_limits()
  {
      local ns="${1}"

      if mptcp_lib_is_ip_mptcp; then
          ip -n "${ns}" mptcp limits
      else
          ip netns exec "${ns}" ./pm_nl_ctl limits
      fi
  }

> +}
> +
>  pm_nl_add_endpoint()
>  {
>  	local ns=$1
> @@ -3578,6 +3593,10 @@ endpoint_tests()
>  	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
>  		pm_nl_set_limits $ns1 2 2
>  		pm_nl_set_limits $ns2 2 2
> +		print_check "get limits"
> +		local output=$'accept 2\nsubflows 2'
> +		mptcp_lib_is_ip_mptcp && output="add_addr_accepted 2 subflows 2 "

(maybe clearer with a dedicated helper to get the limit depending on
which tool we use?)

> +		check_output "pm_nl_get_limits ${ns1}" "${output}"

Mmh, I appreciate new tests, but I think we should only add tests that
are covering new kernel code. The goal of MPTCP Join, compared to other
selftests, is to check behaviours when there are multiple subflows.
Here, you are validating the limits, which is already something managed
by pm_netlink.sh which is dedicated to that. And this doesn't depend on
how many subflows are established.

So I think we should drop the patch. WDYT?

>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1 &

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

