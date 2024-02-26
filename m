Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50617F470
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951245; cv=none; b=trzPAL+HNgP4XmlqnTqI0LbYBTAiGBMwUkvaho3N1aSf3sqoWixGsjVU1xxPX2DWsGVv+5VoIwH3hxCKCUlab4okcRXMUGkjrnbe++S09UBfts/G0jI3rYIKaGW83pnma+Xud5hzzRlI+9ZV2iEQLjsYWLoWs4qFs2xXOXnlz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951245; c=relaxed/simple;
	bh=oIdUsbD1TC71I+fhaoK3JMH3oNgjkGKL8kxO7qOj9Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5UiG5fAnyblmmfmwotot4LJ1g17o+gm0wOEKXehkMb+8pc5Q8OBTIfwCwoQvvAkqsHj/QiQ1FpcqkndfZqEixj/C2yFh4AC5PCKrlmozmk9vHnqRMaj46Tul1GUrhBBH1m0bNIARY/F1EgGg1S+HtCsg+qcCVPGKWThM6UAzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkRED/Ii; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkRED/Ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA70C433C7;
	Mon, 26 Feb 2024 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951245;
	bh=oIdUsbD1TC71I+fhaoK3JMH3oNgjkGKL8kxO7qOj9Bc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qkRED/Ii/MbpMVjJo7dgvttc6LRV9pbrge02o+AIVhB1sonOKCdwmZQlFBRFNnzaO
	 HRGkSY9e6WNsulorE17ztDbyUIBi/BOw7CiZTCGIIZYeS2xbwRqIvda3Pky+j3D8tZ
	 WeHjpGp393wMVnVfX5my0iXO1gBq7IyVXR1F8pjy70s1aL1TqmsX5qjm96+P8AxhUi
	 Fv8Xk038OrjOE+DGU2K6SjnY5EhPGcQFRxgnVEWTR/sBD75alXNdQXygHHqeKFKXzn
	 v00ToDQyittON8LqMfCKqf1TvtfBPVMmExbDDuiwk+ul345dy/E10D/w3xGnUBXo83
	 zANZUyymDRA+g==
Message-ID: <ec8281f5-ff41-43b4-86c9-7696c744a18d@kernel.org>
Date: Mon, 26 Feb 2024 13:40:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 03/12] selftests: mptcp: connect: fix
 misaligned OK/FAIL
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
 <57d3e04f51798ad454f1f028cd9a59a5066f0a96.1708939962.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <57d3e04f51798ad454f1f028cd9a59a5066f0a96.1708939962.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/02/2024 10:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The first [ OK ] and [FAIL] in the output of mptcp_connect.sh misalign
> with the others:
> 
> New MPTCP socket can be blocked via sysctl		[ OK ]
> INFO: validating network environment with pings
> INFO: Using loss of 0.85% delay 16 ms reorder 95% 70% with delay 4ms on
> ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration   184ms) [ OK ]
> ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration    50ms) [ OK ]
> ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration    55ms) [ OK ]
> 
> This patch fixes them.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index ab3bb3b17522..72be905bab1f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -254,7 +254,7 @@ check_mptcp_disabled()
>  
>  	# net.mptcp.enabled should be enabled by default
>  	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
> -		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[FAIL]"
> +		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t\t   [FAIL]"

Best to use one new helper using 'printf %-XXXs', instead of playing
with tabs and spaces.

That will also help to add colours later, with just:

  mptcp_lib_print_success/fail/warn

>  		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
>  		ret=1
>  		return 1
> @@ -267,13 +267,13 @@ check_mptcp_disabled()
>  	mptcp_lib_ns_exit "${disabled_ns}"
>  
>  	if [ ${err} -eq 0 ]; then
> -		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[FAIL]"
> +		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t\t   [FAIL]"
>  		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
>  		ret=1
>  		return 1
>  	fi
>  
> -	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
> +	echo -e "New MPTCP socket can be blocked via sysctl\t\t\t   [ OK ]"
>  	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
>  	return 0
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
