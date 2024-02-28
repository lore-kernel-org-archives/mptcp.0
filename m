Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA67350A
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122003; cv=none; b=NDu0r0oBwzVK3oGs54c81c24SFfm+oUBupzmlCu90c2Cu9DKJrdhvPBv2MF/tDvFYvGflKIweMtRwV3FNdQ0gOZ4M6wo6ZEkO29LFZldvqHtffCSgBba9qkj993dmk3gyy1tHEs03PS6BVDIXTPXeCC/aDo/ruwjDBO6L3uIADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122003; c=relaxed/simple;
	bh=lE9E6qumv7RSYNveFLWJ1IlPDiFUFZBl8fIOcTt6gpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lx3lR/Kejxiq52f62YPKQgAQ+QhSViDCPkLojuJPsxR82S5ARoFRYglj6Lk1c6eUZip9YU4YOcg0gZPA+wKsQXK0Lw/BrEgg4XRfowZSAJnRNNoF2l+bfJsQMhCQ1nrptmptks+UW/tIEUFqN8GoruHFjBe5bgeoiyghB+9+LoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODmN9re7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODmN9re7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339F5C433C7;
	Wed, 28 Feb 2024 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709122002;
	bh=lE9E6qumv7RSYNveFLWJ1IlPDiFUFZBl8fIOcTt6gpw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ODmN9re7KMinZz1YeANnwe2AYvv/DElx1ifi0AZ9sn/5LQYMhHP36wx5yXCfyMQTa
	 MaXy7PC4qhzbcMOrBkOLgPnsFKcQXlroTJ19HgtQJWftDKWbnCIHWX22SsNmZ9S3pY
	 Rf6g3uUjGuU6QIA/ZWLkPpRyBF6MFj6HoTggEe/8jwbxcmbtvJxdLPGv41pI6gWisM
	 AU/CUTyA6nuRu8d6nFAvkPifyS9u4Xq4XuXR9EyvdtQLtXgL7zs4kVEvfxZiH4GZDy
	 DAiXdNv4fbWON5LElhc/hw5WAa3uzHrGP0yKCl1XmzMsjShldS3Sp7Y/Z7XyiAzmJc
	 vTTVsch9FhTGw==
Message-ID: <9d0bbb5a-f31c-46d6-a84e-8c01ae988737@kernel.org>
Date: Wed, 28 Feb 2024 13:06:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v6 4/9] selftests: mptcp: simult_flows: fix
 misaligned output
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
 <0d087d6856e7919af1f3303669468bd8bcc45778.1709105922.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0d087d6856e7919af1f3303669468bd8bcc45778.1709105922.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/02/2024 08:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The last line in the output of simult_flows.sh misaligns with the other
> lines, and all lines are over maximum 75 chars per line.
> 
> This patch aligns them by using the newly added print_title() helper,
> and truncate them within 75 chars per line.
> 
> The new output looks like this:
> 
> balanced bwidth                                        7395 max 7906 [ OK ]
> balanced bwidth - reverse direction                    7484 max 7906 [ OK ]
> balanced bwidth with unbalanced delay                  7394 max 7906 [ OK ]
> balanced bwidth with unbalanced delay - reverse direct 7399 max 7906 [ OK ]
> unbalanced bwidth                                      7692 max 7906 [ OK ]
> unbalanced bwidth - reverse direction                  7614 max 7906 [ OK ]
> unbalanced bwidth with unbalanced delay                7425 max 7906 [ OK ]
> unbalanced bwidth with unbalanced delay - reverse dire 7473 max 7906 [ OK ]
> unbalanced bwidth with opposed, unbalanced delay       7639 max 7906 [ OK ]
> unbalanced bwidth with opposed, unbalanced delay - rev 7611 max 7906 [ OK ]
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> 
> Notes:
>     add print_title helper
> 
>  tools/testing/selftests/net/mptcp/simult_flows.sh | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index af6d9a81c317..4aa0f95ae11f 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -184,7 +184,7 @@ do_transfer()
>  	cmp $cin $sout > /dev/null 2>&1
>  	local cmpc=$?
>  
> -	printf "%-16s" " max $max_time "
> +	printf "%-10s" " max $max_time "
>  	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
>  	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
>  		mptcp_lib_pr_ok
> @@ -205,6 +205,11 @@ do_transfer()
>  	return 1
>  }
>  
> +print_title()
> +{
> +	printf "%-55s" "${@}"
> +}
> +
>  run_test()
>  {
>  	local rate1=$1
> @@ -239,7 +244,7 @@ run_test()
>  	# completion (see mptcp_connect): 200ms on each side, add some slack
>  	time=$((time + 400 + slack))
>  
> -	printf "%-60s" "$msg"
> +	print_title "$msg"
>  	do_transfer $small $large $time
>  	lret=$?
>  	mptcp_lib_result_code "${lret}" "${msg}"
> @@ -248,8 +253,8 @@ run_test()
>  		[ $bail -eq 0 ] || exit $ret
>  	fi
>  
> -	msg+=" - reverse direction"
> -	printf "%-60s" "${msg}"
> +	msg=$(echo -n "${msg} - reverse direction" | cut -c1-54)

Best not to change the title name passed to "mptcp_lib_result_code" not
to break the tracking.

But also, why not having a wider output instead? Why the 75 chars limit?

I mean: yes, the test names should not be too long. But here, probably
too late to change, only modify (increase) the value in print_title(), no?

> +	print_title "${msg}"
>  	do_transfer $large $small $time
>  	lret=$?
>  	mptcp_lib_result_code "${lret}" "${msg}"

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
