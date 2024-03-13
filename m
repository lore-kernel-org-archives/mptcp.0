Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F154BD3
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355694; cv=none; b=KFy+I1cviXNQT9Jyv3rjM9iy5HqI9RQYGgyNPfSdDeIRhbpgDD50Rj8rXueFCQ/d8f5ni2oO7/d6XgsSN8r5VRzjDhkgxsi2vucxhRDHeRagHZYkbWR+GJEpAD8BmFU6JMJD0vsZL+pk8df4FUvUziT9ypTwFh37uUjzSrAzayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355694; c=relaxed/simple;
	bh=PHL0oKD0IoROktHDLbULHwTIpiJ3VFZH6mV44JXuXOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axb8ahm7NiZ+SfLeMp0sDdS3I/dLgfsY4hyQyn4i8WAhyLmyrrOQk7PkcJs6cj4zR3qtiUdK1Gi6GZpwW2MikT7LzfKtk8ZQUvlS2OR6wASnG3fYg4vufGDS01Hymn2ZMQGxTN8qvxToeIie2e7GZMIYaHnRNjSaLBmMXqrMyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXF5XUPl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXF5XUPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592BBC433F1;
	Wed, 13 Mar 2024 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710355693;
	bh=PHL0oKD0IoROktHDLbULHwTIpiJ3VFZH6mV44JXuXOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iXF5XUPl7v5IlnhAM3XVoNp5pYkvGCk/Gv8wvo7EQ1o9hTO9XrPllUN8RWjfaa3g/
	 fcJvXLm6C/N4zsnwD33gcqVZs4SwevXMMyWpE0SuSOrVD43IvjoZEFRJOWM5i8+a2K
	 KGPG4+KG7UwmLFUuhp6bBDyZ88Pc41K+deSgHODuMdBtA31+jU00J05WSg0B0Kequh
	 TaBRLyaAIUrmGUEh+F7U4Ak/rnDHN06IdooTCoVIOsr+GpIUEWJcvzw1I1me59f/Id
	 uV7qkinEwPuX4y8Jb5b1vsxwbCpZB1/gjN/JDTFqvh8R8oi7lsQTBogp1MuiGici3k
	 1SW4A1nYnVBLQ==
Message-ID: <17dd5b67-fa9e-4ef8-8736-82f6fa3fe587@kernel.org>
Date: Wed, 13 Mar 2024 19:48:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 04/10] selftests: mptcp: addr support for
 change_endpoint
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
 <4f69ef8b2a7d3a131548424ddf9f0ba96ee53f78.1710121590.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4f69ef8b2a7d3a131548424ddf9f0ba96ee53f78.1710121590.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 11/03/2024 02:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The address that needs to change flags can only be identified by an address
> ID in pm_nl_change_endpoint(). This patch adds support for passing an IP
> address directly to this helper.
> 
>         Address ID:
>                 pm_nl_change_endpoint $ns id $id $flags
> 
>         IP address:
>                 pm_nl_change_endpoint $ns $addr $flags
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  5 +++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e33a136aef8e..431233e25abc 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -717,13 +717,17 @@ pm_nl_show_endpoints()
>  pm_nl_change_endpoint()
>  {
>  	local ns=$1
> -	local id=$2
> +	local addr=$2
>  	local flags=$3
>  
> +	if ! mptcp_lib_is_addr "$addr"; then
> +		[ $addr -gt 0 ] && [ $addr -lt 256 ] && addr="id $addr"
> +	fi
> +
>  	if mptcp_lib_is_ip_mptcp; then
> -		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
> +		ip -n $ns mptcp endpoint change $addr ${flags//","/" "}
>  	else
> -		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
> +		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags
>  	fi
>  }
>  
> @@ -3609,6 +3613,11 @@ endpoint_tests()
>  		output="id 1 flags signal 10.0.2.1"
>  		mptcp_lib_is_ip_mptcp && output="10.0.2.1 id 1 signal "
>  		check_output "pm_nl_show_endpoints ${ns1} 1" "${output}"
> +		pm_nl_change_endpoint ${ns1} 1 backup
> +		print_check "change id 1 addr"
> +		output="id 1 flags signal,backup 10.0.2.1"
> +		mptcp_lib_is_ip_mptcp && output="10.0.2.1 id 1 signal backup "
> +		check_output "pm_nl_show_endpoints ${ns1}" "${output}"

I feel like here as well, that's something already validated in
pm_netlink.sh, and this will not check anything new, no?

>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1 &
>  		local tests_pid=$!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

