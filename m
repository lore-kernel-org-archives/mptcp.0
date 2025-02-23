Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16ACA64
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740330825; cv=none; b=X3xd7+LbUhqSyFYI/OtHWs+8waQQfJADpQBbQABz05vVCsWLrTXVqE60voagPQqqLqyuB59O50lAnvsLUWCvIxyk3sfPQwR0Mrs/ZtWcCgxUNQLbug2w5idgj5Nmz6E5u6QHZkq4CeFGreNBJGI+03lFOwEUEFaVTMua6AQozxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740330825; c=relaxed/simple;
	bh=pTvPUSmkoVY08HTUd8IfFlxD6m8/YYDdZazdPpCQjQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l41NgTwAUsSvyH47bhiwzPD5xqDKXHf2IJ/jQnjNiPTfTptOK2mbAoZ3Kaurfkzo0jaqoIxTJuXDBQjM+i2barlGgf/80WTjnAnoMpISSibrge/pfZxmvWzCB1733shlGCpqp3OEFkt6xdLCGc19X6SGZ/+zRCswVreEgfuNZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWtkybTa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWtkybTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A040AC4CEDD;
	Sun, 23 Feb 2025 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740330824;
	bh=pTvPUSmkoVY08HTUd8IfFlxD6m8/YYDdZazdPpCQjQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YWtkybTamc8HPcMFvbLYuiAbtviUvyBgufEKzEi5MY6YZndDOhket1NztDpefOZut
	 05aNYHsWOy/SB3fASzapSmJ4/X6afg7QJqUFJG8UzONalqHGB0DgD3h8wmehfUYZG6
	 PWkOyvDmp+afF8pUP9qssWwPNiWaG3b0juIA6QCmvnRNAdzy9p88n+NE7O8Es1qMsG
	 zTEC9mqFxELbA4CGIssnNIfPZh/DCMQK4UKwdZsxegVY/GflDrupdgOpkZJ/HX1OuN
	 VlAuCYeyTyM2nt1a+LOn/Gsb4gqWJ9fCGoWjkGi1We5hBfngabXRWGIZdwKrpm2tfi
	 pC3c8ntb5LSZQ==
Message-ID: <c49517d2-38e2-4848-9fb9-1c7748689cec@kernel.org>
Date: Sun, 23 Feb 2025 18:13:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 13/13] selftests/mptcp: use path_manager
 instead of pm_type
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
 <b94e2a3b16486315acd2fa31cde3830a98573d5d.1740320007.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b94e2a3b16486315acd2fa31cde3830a98573d5d.1740320007.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/02/2025 15:26, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses the newly added net.mptcp.path_manager instead of the
> old net.mptcp.pm_type for all path manager selftests in mptcp_join.sh
> and userspace_pm.sh.

With the mapping for "pm_type" and "path_manager" sysctl knobs I
mentioned before, this patch should not be needed (and would cause
issues when validating older kernels, see below).

Still, I think it would be good to make sure such mapping is working
well. Instead, I think it would be better to add a specific test in
userspace_pm.sh to make sure the mapping is correct. See below.

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++----------
>  .../selftests/net/mptcp/userspace_pm.sh       |  4 +--
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 13a3b68181ee..ed04e7dedf23 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -99,7 +99,7 @@ init_partial()
>  
>  	local netns
>  	for netns in "$ns1" "$ns2"; do
> -		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
> +		ip netns exec $netns sysctl -q net.mptcp.path_manager="in-kernel" 2>/dev/null || true

If you change this here, it means that the selftests will report errors
when running on older kernels. So please, do not change that.

>  		if $checksum; then
>  			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
>  		fi
> @@ -1920,7 +1920,7 @@ set_userspace_pm()
>  {
>  	local ns=$1
>  
> -	ip netns exec $ns sysctl -q net.mptcp.pm_type=1
> +	ip netns exec $ns sysctl -q net.mptcp.path_manager="userspace"

Same here.

>  }
>  
>  subflows_tests()
> @@ -3497,7 +3497,7 @@ userspace_tests()
>  {
>  	# userspace pm type prevents add_addr
>  	if reset "userspace pm type prevents add_addr" &&
> -	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then

Here, it means the tests will be skipped on older kernels while they
don't require this new sysctl knob.

So please do not change that. Same below.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 3651f73451cf..dfeec8d4aecf 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -13,7 +13,7 @@
>  mptcp_lib_check_mptcp
>  mptcp_lib_check_kallsyms
>  
> -if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +if ! mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then

Same here.

>  	echo "userspace pm tests are not supported by the kernel: SKIP"
>  	exit ${KSFT_SKIP}
>  fi
> @@ -119,7 +119,7 @@ trap cleanup EXIT
>  # Create and configure network namespaces for testing
>  mptcp_lib_ns_init ns1 ns2

Here, if /proc/sys/net/mptcp/path_manager is available:

 - set it to "userspace", then check if "pm_type" is set to 1.
 - set "pm_type" to 0, and check if "path_manager" is "kernel".
 - then continue like before (so setting pm_type=1)
 - (you might have to move 'print_title "Init"' here above if these new
steps can create errors)

I don't think we need individual subtests here, only fail if it doesn't
work as expected (again, if the new sysctl is available, not to fail on
older kernels).

>  for i in "$ns1" "$ns2" ;do
> -	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
> +	ip netns exec "$i" sysctl -q net.mptcp.path_manager="userspace"

Do not change that.

>  done
>  
>  #  "$ns1"              ns2

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

