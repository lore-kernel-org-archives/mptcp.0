Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF169634FD
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201269; cv=none; b=PQKsSRbzZTF47KUT/HpEPmFZm5WReRqAOPN/lg7+aYVwNPsEybu/HIIupF+/A6ZicAl3FOcRDceWOz27XaG1sGI9HUZ7JQP4K5HlA2s8x0dRQa8qXfuBIa+l3JUtbOI9Fv3svX+b4TQsl+VN4N/Xz9qKEvTVrECAhlP/2mbfBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201269; c=relaxed/simple;
	bh=/SXZphYS5dJhSDCJelWlblU7zT3BD7WJzbfZUDgmfeU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPRxZ0BIwohpQfRAoBr63Cz4UqS5A4S4LK8cfSIiDRwAvNl1u23GWyWF4WkDGk8vsB8dO3Ise3TZAoUU+qclFD8ynRBBKyNVqcYchRVhCmT9XoK1+5LVWM5u1bmrfPrj+CCS5IOZeLOM3oW5pp8GQb+XDFGNhW231bLxL465Ghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/vgbNfq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/vgbNfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC44C433F1
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709201269;
	bh=/SXZphYS5dJhSDCJelWlblU7zT3BD7WJzbfZUDgmfeU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=T/vgbNfqU9I4ulW7b5OIMJmwNPxSbzDYMVwgUx7Q1kIX3iikmWMT6QMobhexbeC1o
	 woMPpUiUZ8v2OhlD5a+xaZMZe0VVXq0KNCAerOtkm0oK1o5/Qp9d8H2G5j1W5V98IL
	 UhVuK4qG1u0fmNglZzLE1qY1FqmRYxFIP6u7X5pBwxr2KFEJDEqah2ARYk6opMSGHZ
	 oAn4lfDNzKFGoSeEb/Enryaet9Lphh6oCVp3bbBTkIFQHFRvQBty6pPmDIxJT6rJI2
	 gkmVGu7DChL2zrWI0t7dQdEULjwLcE8f6BtDD5ruUSMlBMz+QXfH+lfjv5SjeUatW2
	 eHwQh50k7f5OQ==
Date: Thu, 29 Feb 2024 18:07:44 +0800
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 4/8] selftests: mptcp: simult_flows: fix
 misaligned output
Message-ID: <ZeBXcFdtho6hZUZV@t480>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <c5534d2e878f0d776e0f46a28ba6703e0a05abd9.1709200070.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5534d2e878f0d776e0f46a28ba6703e0a05abd9.1709200070.git.tanggeliang@kylinos.cn>

On Thu, Feb 29, 2024 at 05:51:07PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The last line in the output of simult_flows.sh misaligns with the other
> lines, and all lines are over maximum 75 chars per line.
> 
> This patch aligns them by using the newly added print_title() helper,
> and truncate them within 75 chars per line to allow it to be displayed
> normally in regular terminals without breaking lines.

This part of commit log needs to be updated:

    This patch aligns them by reducing the number of spaces before [ OK ] to
    1, and truncate them within 75 chars per line to allow it to be displayed
    normally in regular terminals without breaking lines.

Thanks,
-Geliang

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
>  tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 467feb17e07b..d5f8521b88d5 100755
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
>  		echo "[ OK ]"
> @@ -249,7 +249,7 @@ run_test()
>  	fi
>  
>  	msg+=" - reverse direction"
> -	printf "%-60s" "${msg}"
> +	printf "%-60s" "$(echo -n ${msg} | cut -c1-54)"
>  	do_transfer $large $small $time
>  	lret=$?
>  	mptcp_lib_result_code "${lret}" "${msg}"
> -- 
> 2.40.1
> 
