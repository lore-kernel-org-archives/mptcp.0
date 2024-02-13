Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7E249F3
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824133; cv=none; b=V1VUX5poofPN9DdWOE9ZWHgwaYo6bsla2SA4o+dD++8JjqlGHjRF7v8fwdrS8vPLDSeT07ehhCz8cucp/x9OhAqBhdn7uL3jHJlzZMRgwEra/7/S35E3HG8F+xHzA32FypHw0l0UdJMRjdilhuH6/PvUfyrfTASPaAJBk+LqYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824133; c=relaxed/simple;
	bh=yYej/2sbnLLCGZQ5EKQc5uDe8HnSkdTH8sG0kB13IpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuJoS0QicSQRyXS7d3i6tHSLscakX/lhJQohFCd2Ecs+KPpHuOhOgidl7kjZ0IJ9kXMwDh/SR1P9xbi0WkqMyOioS2lMiLhvyRRP+qYn8C5U8d28jHkYT3Fa5CUeEYp8nmkqHtWGoDTL25E+SoWLIN/8kE8ca3aL5VJ+A0qdlzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiZEIkG+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiZEIkG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30245C433C7;
	Tue, 13 Feb 2024 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707824132;
	bh=yYej/2sbnLLCGZQ5EKQc5uDe8HnSkdTH8sG0kB13IpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiZEIkG+fDpQ6P3OHYif9T2lMOrBrDCM27BxUnB7rK1mVHf5/aFm5X2CLv84M36/i
	 Ew5V5HyNmv6vZOGQHuQOdSIkOFsdP7jI+bL7+Sde4GTFlMYi9EL8+ximw83v8zG2PL
	 XBN721VKSmHOo9Zjb1TVOLKEH1z2MNr7FANDGsWWoDgE5k/X2e+CuDvXc+7vjF1llZ
	 vTAdfR1U1gTfC0SjZXXYZBP49IZsFlDVVt/ZCMLjxANWTUgm0ufX9YJC0S99thIBTR
	 Y8cdXw9aPc6KeUFLNikdV6XY+B96JktuJdlreG8OFa1du3mZFBoUwcTPLDJHrtG2bY
	 7L2exemYOXZ8g==
Date: Tue, 13 Feb 2024 19:34:59 +0800
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 1/5] selftests: mptcp: simult flows: fix some
 subtest names
Message-ID: <ZctT4/w/nH6+4Ocz@t480>
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
 <20240209-selftests-mptcp-uniq-title-v1-1-e4fb3a3b5f66@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-selftests-mptcp-uniq-title-v1-1-e4fb3a3b5f66@kernel.org>

Hi Matt,

On Fri, Feb 09, 2024 at 06:28:39PM +0100, Matthieu Baerts (NGI0) wrote:
> The selftest was correctly recording all the results, but the 'reverse
> direction' part was missing in the name when needed.
> 
> It is important to have a unique (sub)test name in TAP, because some CI
> environments drop tests with duplicated name.
> 
> Fixes: 675d99338e7a ("selftests: mptcp: simult flows: format subtests results in TAP")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 619be0e1acf5..f377ef01970b 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -250,7 +250,8 @@ run_test()
>  		[ $bail -eq 0 ] || exit $ret
>  	fi
>  
> -	printf "%-60s" "$msg - reverse direction"
> +	msg="${msg} - reverse direction"

How about using '+=' operator to append a string like:

	msg+=" - reverse direction"

The same in patch 3 and patch 4:

	msg+=" after flush"

WDYT?

Thanks,
-Geliang

> +	printf "%-60s" "${msg}"
>  	do_transfer $large $small $time
>  	lret=$?
>  	mptcp_lib_result_code "${lret}" "${msg}"
> 
> -- 
> 2.43.0
> 
